import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';

const app = express();

app.use(express.json());
app.use(express.urlencoded({extended : true}));
app.use(cors());

app.get("/", async (req, res) => {
    res.json("yoyo");
})

app.listen(10000, () => console.log("server running on port 10000"));