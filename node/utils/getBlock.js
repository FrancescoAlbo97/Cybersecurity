const Web3 = require('web3');
const contractJson = require('../../build/contracts/Image.json');
const contractAddress = contractJson.networks['10'];
const contractABI = contractJson.abi;
module.exports = {
    getAll: async function (){
        var web3 = new Web3('http://localhost:22000');
        var block = new web3.eth.Contract(contractABI, contractAddress.address);
        return await getAllImages(block);

        async function getAllImages(block){
          const allAddress = await getImagesAddress(block); //recupera tutti gli hash delle immagini
          const list = await getInfoFromImages(allAddress);
          return list;
        }

       async function getInfoFromImages(allAddress){
          let list = [];
          const l = allAddress.length;
          for( let item of allAddress){
            let js = new Object();
            js = await getImageByAddress(block, item); //recupera le info associate ad un hash(un'immagine)
            js['hash'] = item;
            list.push(js);
          }
          return list;
        }

        function getImagesAddress(block) {
            return new Promise(
              (resolve, reject) => {
                block.methods
                .getAllAddress()
                .call()
                .then((result) => {resolve(result)});
              } 
            );
          }
          
          function getImageByAddress(block, hash) {
            return new Promise(
              (resolve, reject) => {
                block.methods
                .getByAddress(hash)
                .call()
                .then((result) => {
                  if(result){
                    var list = [];
                    let tag = new Object();
                    for(i = 0; i < 5; i++){
                      tag = JSON.parse(result[1][i]);
                      list.push({
                        "confidence": parseInt(result[0][i]),
                        "tag" : tag['en']
                      });
                    }
                    var newJson = new Object();
                    newJson['measures'] = list;
                    newJson['image'] = JSON.parse(result[2]);
                    newJson['gps'] = JSON.parse(result[3]);
                    resolve(newJson);
                  }
                    else resolve({"error" : "non ci sono tag"});
                });
              } 
            );
          }
          
    }
}