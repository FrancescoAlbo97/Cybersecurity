const Web3 = require('web3');
const contractJson = require('/home/alessio/Scrivania/Cybersecurity/build/contracts/Image.json');
const contractAddress = contractJson.networks['10'];
const contractABI = contractJson.abi;
module.exports = {
    send: function ( hash, metadata, tags){
        var web3 = new Web3('http://localhost:22000');
        var block = new web3.eth.Contract(contractABI, contractAddress.address);
        web3.eth.getAccounts().then(console.log);
    
        let accounts = [];
    
        web3.eth.getAccounts()
        .then(_accounts => {
            accounts = _accounts;
            var confidences = [Math.round(tags[0]['confidence']), Math.round(tags[1]['confidence']), Math.round(tags[2]['confidence']), Math.round(tags[3]['confidence']), Math.round(tags[4]['confidence'])];
            var newTags = [JSON.stringify(tags[0]['tag']), JSON.stringify(tags[1]['tag']), JSON.stringify(tags[2]['tag']), JSON.stringify(tags[3]['tag']), JSON.stringify(tags[4]['tag'])];
            block.methods
            .set(hash, confidences, newTags, JSON.stringify(metadata['image']), JSON.stringify(metadata['gps']))
            .send({from: accounts[0]})
            .then((result) => 
            {
              console.log(result);
            });
        });         
    }
}