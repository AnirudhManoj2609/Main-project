import base64
import io
import time
from PIL import Image, ImageOps

def lambda_handler(event, context=None):
    start = time.time()

    image_bytes = base64.b64decode(event["imageBase64"])
    image = Image.open(io.BytesIO(image_bytes)).convert("RGB")

    negative = ImageOps.invert(image)

    buffer = io.BytesIO()
    negative.save(buffer, format="PNG")

    return {
        "imageBase64": base64.b64encode(buffer.getvalue()).decode("utf-8"),
        "executionTimeMs": int((time.time() - start) * 1000)
    }
