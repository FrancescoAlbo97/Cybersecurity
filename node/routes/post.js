const express = require('express');
const router = express.Router();
const UsersCredentials = require('../models/Post.js');
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');


//SUBMITS A POST
router.post('/', async (req, res) => {
    const salt = await bcrypt.genSalt(10);
    const post = new UsersCredentials({
        username: req.body.username,
        password: await bcrypt.hash(req.body.password, salt),
    });
    try {
        const savedPost = await post.save();
        res.json(savedPost);
    } catch (err) {
        res.json({ message: err });
    }
});


//LOGIN
router.post('/login', async (req, res) => {
    try {
        const checkUser = await UsersCredentials.find(
            { 
                username: req.body.username
            },
        );
        if(checkUser.length > 0) {
            valid = await bcrypt.compare(req.body.password, checkUser[0].password);
            if(valid){
                res.json(generateToken({
                    username: req.body.username,
                    password: req.body.password
                }));
            } else res.sendStatus(403)   
        } else res.sendStatus(403)       
    } catch (err) {
        res.json({ message: err });
    }
})


function generateToken(user){
    const accessToken = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET);
    return accessToken;
}

module.exports = router;