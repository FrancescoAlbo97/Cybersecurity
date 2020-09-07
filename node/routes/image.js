const express = require('express');
const sendBlock = require('../utils/sendBlock')
const getBlock = require('../utils/getBlock')
const router = express.Router();
const fs = require('fs');
const jwt = require('jsonwebtoken');
const ipfsClient = require('ipfs-http-client');
var ExifImage = require('exif').ExifImage;


const ipfs = new ipfsClient({ host: 'localhost', port: '5001', protocol: 'http'});

//ROTTA CARICAMENTO IMMAGINE SCRIPT
router.get('/', (req, res) => {
    res.render('../views/image.ejs');
})

//ROTTA PER RECUPERARE IMMAGINI
router.get('/get', authenticateToken, async (req, res) => {  
    let images = new Object();
    const list = await getBlock.getAll(); 
    images['gallery'] = list;
    res.json(images);
})


//ROTTA CARICAMENTO IMMAGINE SU IPFS
router.post('/uploadIPFS', authenticateToken, (req, res) => {
  if(!req.files || Object.keys(req.files).length === 0){
      res.status(400).send('No file');
  }
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
                async (metadata) => {
                  sendBlock.send(hash, metadata, tags);        
                  console.log("caricamento...");
                  let images = new Object();
                  images['gallery'] = await getBlock.getAll(); 
                }
              )//.catch(                res.json({hash: 'immagine non supportata'})              );
          }).auth(apiKey, apiSecret, true);

      fs.unlink(filePath, (err) => {   //rimuovo il file appena creato
          if (err) console.log(err);
      });    
      res.json({hash: 'https://ipfs.io/ipfs/' + hash});
  })
})


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
            if (error){
                console.log('Error: '+error.message);
                reject();
            }
            else
              resolve(exifData);
        });
    } catch (error) {
        console.log('Error: ' + error.message);
        reject();
    }
    } 
  );
}

module.exports = router;