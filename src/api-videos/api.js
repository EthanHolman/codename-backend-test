const express = require("express");
const app = express();

app.get("*", (req, res) => {
  const videos = [
    { id: 2, videoId: 343, createdBy: "ethanh" },
    { id: 4, videoId: 64, createdBy: "ethanh" },
    { id: 7, videoId: 7567, createdBy: "charisg" },
  ];

  res.send(videos);
});

exports.app = app;
