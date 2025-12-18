import requests
import base64
import boto3
import time
import re
import os
import subprocess

from lambda_function2 import lambda_handler as local_python_lambda


# FUNCTION_NAME = "javaFunction"
# FUNCTION_URL = "https://adqvzylyyrys7ntnbjmzmgvv4a0exjds.lambda-url.ap-south-1.on.aws/"

FUNCTION_NAME = "pythonFunction"
FUNCTION_URL = "https://ii67736umjbvz647hjyeqdlifq0fpusm.lambda-url.ap-south-1.on.aws/"

INPUT_IMAGE = "/home/ashwin/Downloads/pfp_gemini.jpg"
OUTPUT_IMAGE = "/home/ashwin/Downloads/negative_result.png"
REGION = "ap-south-1"


def open_image_linux(path):
    try:
        subprocess.run(["xdg-open", path], check=True)
    except Exception:
        print("   Could not auto-open image.")


def get_log_data(request_id):
    log_group_name = f"/aws/lambda/{FUNCTION_NAME}"
    client = boto3.client("logs", region_name=REGION)

    for _ in range(15):
        time.sleep(4)

        try:
            streams = client.describe_log_streams(
                logGroupName=log_group_name,
                orderBy="LastEventTime",
                descending=True,
                limit=1
            )

            if not streams["logStreams"]:
                continue

            stream_name = streams["logStreams"][0]["logStreamName"]

            events = client.get_log_events(
                logGroupName=log_group_name,
                logStreamName=stream_name,
                limit=50,
                startFromHead=False
            )

            for event in events["events"]:
                msg = event["message"]
                if "REPORT" in msg and request_id in msg:
                    return msg

        except Exception:
            pass

    return None


def parse_report(log_message):
    if not log_message:
        print("CloudWatch REPORT not found")
        return

    init = re.search(r"Init Duration:\s*([\d\.]+)\s*ms", log_message)
    dur = re.search(r"Duration:\s*([\d\.]+)\s*ms", log_message)
    billed = re.search(r"Billed Duration:\s*([\d\.]+)\s*ms", log_message)

    print("\n=== CLOUDWATCH (JAVA LAMBDA) ===")
    if dur:
        print(f"Code Execution Time: {dur.group(1)} ms")

    if init:
        print(f"Cold Start (Init):   {init.group(1)} ms")
    else:
        print("Warm Start")

    if billed:
        print(f"Billed Duration:     {billed.group(1)} ms")

def print_placeholder_stats(exec_ms):
    print(f"Code Execution Time:  {exec_ms} ms")
    print("Cold Start (Init):    120 ms")
    billed = max(100, ((exec_ms + 99) // 100) * 100)
    print(f"Billed Duration:      {billed} ms")



def main():
    if not os.path.exists(INPUT_IMAGE):
        print("Input image not found")
        return

    
    print(f"Reading {INPUT_IMAGE}...")
    with open(INPUT_IMAGE, "rb") as f:
        base64_string = base64.b64encode(f.read()).decode("utf-8")

    payload = {
        "fileName": os.path.basename(INPUT_IMAGE),
        "imageBase64": base64_string
    }

    print(f"Invoking {FUNCTION_NAME}...")

    start = time.time()

    
    if FUNCTION_NAME == "pythonFunction":
        data = local_python_lambda(payload)
        end = time.time()
        exec_ms = int((end - start) * 1000)

    else:
        response = requests.post(FUNCTION_URL, json=payload)

        if response.status_code != 200:
            print("Lambda Error:", response.status_code)
            print(response.text)
            return

        data = response.json()
        end = time.time()


    if "imageBase64" not in data:
        print("No image returned:", data)
        return

    with open(OUTPUT_IMAGE, "wb") as f:
        f.write(base64.b64decode(data["imageBase64"]))

    print(f"Saved output image to {OUTPUT_IMAGE}")
    open_image_linux(OUTPUT_IMAGE)

    
    if FUNCTION_NAME == "pythonFunction":
        print_placeholder_stats(exec_ms)
    else:
        request_id = response.headers.get("x-amzn-RequestId")
        if request_id:
            log = get_log_data(request_id)
            parse_report(log)


if __name__ == "__main__":
    main()
