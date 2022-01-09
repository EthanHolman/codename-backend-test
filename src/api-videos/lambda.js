const serverless = require("serverless-http");
const { app } = require("./api.js");

exports.handler = serverless(app);
