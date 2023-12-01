import express from 'express';

const router = express.Router();

const users =[
    {
        firstname : "Tezar Maulana",
        address : "Komp. TCI Blok F.18",
        age :  26,
        current : "Staff Mobile Dev"
    }
]

router.get('/', (req,res) => {
    console.log(users);
    res.send(users);
});

export default router;