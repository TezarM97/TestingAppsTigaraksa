import express from "express";
import bodyParser from "body-parser";
import koneksi from "./config.js";
// const express = require('express');
// const bodyParser = require('body-parser');
// const koneksi = require('./config');


const app = express();
const PORT = process.env.PORT || 5000;
// set body parser

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));


app.listen(PORT, () => console.log(`Server running at port: ${PORT}`));

