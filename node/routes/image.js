const express = require('express');
const sendBlock = require('../utils/sendBlock')
const getBlock = require('../utils/getBlock')
const router = express.Router();
const fs = require('fs');
const jwt = require('jsonwebtoken');
const ipfsClient = require('ipfs-http-client');
const { isNullOrUndefined } = require('util');
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
    let tags;
    let metadata;
    file.mv(imagePath, async (err) => {
        if (err) {
            console.log('Error: failed to load the file');
            return res.status(500).send(err);
        }
        const f = fs.readFileSync(imagePath);
        const fileAdded = await ipfs.add({ path: "fire", content: f });
        hash = fileAdded.cid.toString(); //hash del file appena caricato

        getImageMetadata(f).then(
            async (result) => {
                metadata = result;
                if(!isEmpty(metadata.exif)){
                    getImageData(imagePath).then(
                        async (result) => {
                            tags = result;
                            await sendToBlockChain(hash, metadata, tags); 
                        }
                    );
                }else console.log("caricamento immagine non avvenuto");       
        
                fs.unlink(imagePath, (err) => {   //rimuovo il file appena creato
                    if (err) console.log(err);
                });   
        
                res.json({value: 'https://ipfs.io/ipfs/' + hash});
            }
        ).catch(
            () => {
                fs.unlink(imagePath, (err) => {   //rimuovo il file appena creato
                    if (err) console.log(err);
                });

                res.json({value: 'error: l\'immagine non è supportata'});
            }
        );

    })
})

function isEmpty(obj) {
    for(var key in obj) {
        if(obj.hasOwnProperty(key))
            return false;
    }
    return true;
}


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
                    console.log('Error: '+ error.message);
                    reject();
                } else
                    resolve(exifData);
            });
        } catch (error) {
            console.log('Error: ' + error.message);
            reject();
        }
    } 
  );
}

function getImageData(imagePath) {
    let fs1 = require('fs'),
        request = require('request'),
        apiKey = 'acc_3a4bbdbae6a16ba',
        apiSecret = '28251a159773af4d1569790407dc44c8',
        filePath = imagePath,
        formData = {
            image: fs1.createReadStream(imagePath)
        };
    return new Promise(
      (resolve, reject) => {
        request.post({url:'https://api.imagga.com/v2/tags', formData: formData},
        function (error, response, body) {
            let data = JSON.parse(body);
            let tags = data.result.tags.slice(0, 5);
            resolve(tags);
      }).auth(apiKey, apiSecret, true);
      } 
    );
}

async function sendToBlockChain(hash, metadata, tags) {
    sendBlock.send(hash, metadata, tags);        
    console.log("caricamento...");
    let images = new Object();
    images['gallery'] = await getBlock.getAll(); 
}

module.exports = router;