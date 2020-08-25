const express = require('express');
const sendBlock = require('../utils/sendBlock')
const getBlock = require('../utils/getBlock')
const router = express.Router();
const fs = require('fs');
const jwt = require('jsonwebtoken');
const ipfsClient = require('ipfs-http-client');
//const https = require("https");
var ExifImage = require('exif').ExifImage;
let unirest = require("unirest");
const { rejects } = require('assert');


const ipfs = new ipfsClient({ host: 'localhost', port: '5001', protocol: 'http'});

//ROTTA CARICAMENTO IMMAGINE SCRIPT
router.get('/', (req, res) => {
    res.render('../views/image.ejs');
})
//ROTTA CARICAMENTO IMMAGINE SU IPFS
router.post('/uploadIPFS', authenticateToken, (req, res) => {
  if(!req.files || Object.keys(req.files).length === 0){
      res.status(400).send('No file');
  }
  //console.log(JSON.stringify(req.headers));
  const file = req.files.image;
  const imagePath = './files/' + file.name;
  let hash = "";
  file.mv(imagePath, async (err) => {
      if (err) {
          console.log('Error: failed to load the file');
          return res.status(500).send(err);
      }
      const f = fs.readFileSync(imagePath);
      const fileAdded = await ipfs.add({ path: "fire", content: f });
      hash = fileAdded.cid.toString(); //hash del file appena caricato
      console.log(hash);
      //getImageMetadata(f);
      

      let fs1 = require('fs'),
          request = require('request'),
          apiKey = 'acc_3a4bbdbae6a16ba',
          apiSecret = '28251a159773af4d1569790407dc44c8',
          filePath = imagePath,
          formData = {
              image: fs1.createReadStream(imagePath)
          };

      request.post({url:'https://api.imagga.com/v2/tags', formData: formData},
          function (error, response, body) {
              let data = JSON.parse(body);
              let tags = data.result.tags.slice(0, 5);
              getImageMetadata(f).then(
                (metadata) => {
                  sendBlock.send(hash, metadata, tags);
                  let bene = getBlock.getAll();          
                  console.log(bene);       
                }
              );
          }).auth(apiKey, apiSecret, true);

      fs.unlink(filePath, (err) => {   //rimuovo il file appena creato
          if (err) console.log(err);
      });    
      res.json({hash: 'https://ipfs.io/ipfs/' + hash})
  })
})
/*
//ROTTA CARICAMENTO IMMAGINE SU IPFS
router.post('/uploadIPFS', authenticateToken, (req, res) => {
    if(!req.files || Object.keys(req.files).length === 0){
        res.status(400).send('No file');
    }
    //console.log(JSON.stringify(req.headers));
    const file = req.files.image;
    const filePath = './files/' + file.name;
    let hash = "";
    file.mv(filePath, async (err) => {
        if (err) {
            console.log('Error: failed to load the file');
            return res.status(500).send(err);
        }
        const f = fs.readFileSync(filePath);
        const fileAdded = await ipfs.add({ path: "fire", content: f });
        hash = fileAdded.cid.toString(); //hash del file appena caricato
        //console.log(hash);
        //getImageMetadata(f);
        fs.unlink(filePath, (err) => {   //rimuovo il file appena creato
            if (err) console.log(err);
        });
        let apiReq = unirest("GET", "https://api.imagga.com/v2/tags");
        const imageUrl = "https://ipfs.io/ipfs/" + hash;
        apiReq.query({
            "image_url": imageUrl,
            "version": "2"
        });
        apiReq.headers({
            "accept": "application/json",
            "authorization": "Basic YWNjXzNhNGJiZGJhZTZhMTZiYToyODI1MWExNTk3NzNhZjRkMTU2OTc5MDQwN2RjNDRjOA=="
        });

        var tags;

        apiReq.end(async function (res) {
            //if (res.error) throw new Error(res.error);
            if (res.error) tags = [
              {"confidence": 1, 'tag': {'en': 'vehicle'}},
              {"confidence": 1, 'tag': {'en': 'vehicle'}},
              {"confidence": 1, 'tag': {'en': 'vehicle'}},
              {"confidence": 1, 'tag': {'en': 'vehicle'}},
              {"confidence": 1, 'tag': {'en': 'vehicle'}}
            ];
            else tags = res.body.result.tags.slice(0, 5);
            //console.log(tags);
            var metadata = await getImageMetadata(f);
            sendBlock(hash, metadata, tags);
        });
        //res.json(res.body.result); //non riesco ad inviare in json indietro!! però funziona

        res.json({hash: 'https://ipfs.io/ipfs/' + hash})
        //console.log(tags);
        
    })
    */
  

function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]  //con la prima condizione mi assicuro di avere un header
    if (token == null) 
        return res.sendStatus(401)
    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
        if (err) return res.sendStatus(403)  //singifica che ho un token sbagliato
        req.user = user
        next()
    })
}

function getImageMetadata(filePath) {
  return new Promise(
    (resolve, reject) => {
      try {
        new ExifImage({ image : filePath }, function (error, exifData) {
            if (error)
                console.log('Error: '+error.message);
            else
              resolve(exifData);
                //console.log(exifData); // Do something with your data!
        });
    } catch (error) {
        console.log('Error: ' + error.message);
    }
    } 
  );
}

module.exports = router;