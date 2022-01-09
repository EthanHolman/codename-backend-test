const express = require("express");
const app = express();

app.get("*/user", (req, res) => {
  const user = {
    userId: 32325,
    username: "ethanh",
    profileVideoId: 3252,
  };

  res.send(user);
});

exports.app = app;
