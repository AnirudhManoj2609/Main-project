exports.getWelcomeMessage = (req, res) => {
    res.status(200).json({
        message: "Hello from the Controller!",
        status: "Success"
    });
};