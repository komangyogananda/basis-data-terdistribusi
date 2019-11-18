import express from "express";
import router from "../routes/routes";
import mongoose from "mongoose";
import bodyParser from "body-parser";

const app = express();
app.use(express.json());
app.use(
  bodyParser.urlencoded({
    extended: true
  })
);
app.use(bodyParser.json());
app.use(router);

mongoose.connect("mongodb://192.168.17.116:27017/bdt?retryWrites=false", {
  useNewUrlParser: true
});

if (!mongoose.connection) console.log("Error connecting db");
else console.log("Db connected successfully");

app.listen(process.env.PORT || 5000);

export default app;
