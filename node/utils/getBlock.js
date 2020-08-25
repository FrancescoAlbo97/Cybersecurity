const Web3 = require('web3');
const contractJson = require('/home/alessio/Scrivania/Cybersecurity/build/contracts/Image.json');
const contractAddress = contractJson.networks['10'];
const contractABI = contractJson.abi;
module.exports = {
    getAll: async function (){
        var web3 = new Web3('http://localhost:22000');

        var block = new web3.eth.Contract(contractABI, contractAddress.address);
        return getAllImages(block);

        async function getAllImages(block){
          let bene = "ciao00000";
          let allAddress = await getImagesAddress(block); //recupera tutti gli hash delle immagini
          for(  i=0; i < allAddress.length; i++){
            getImageByAddress(block, allAddress[i])  //recupera le info associate ad un hash(un'immagine)
                  .then((res) => console.log(res));
          }
          return bene;
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
                  var list = [];
                  for(i = 0; i < 5; i++){
                    list.push({
                      "confidence": parseInt(result[0][i])
                    },
                    {"tag" : result[1][i]}
                    );
                  }
                  var newJson = new Object();
                  newJson['measures'] = list;
                  newJson['image'] = JSON.parse(result[2]);
                  newJson['gps'] = JSON.parse(result[3]);
                  resolve(newJson);
                });
              } 
            );
          }
          
    }
}