# Progetto Cybersecurity UNIVPM 

> GRUPPO 7: Alborino Francesco, Borc Bogdan Petru, Marchetti Michele, Mazzucchelli Chiara, Scoppolini Massini Lorenzo


# Indice

- [Come iniziare](#come-iniziare)
- [Documentazione esterna](#Documentazione)

# Come iniziare

## Scaricare go-ipfs

```bash
wget https://github.com/ipfs/go-ipfs/releases/download/v0.6.0/go-ipfs_v0.6.0_linux-amd64.tar.gz
tar -xvzf go-ipfs_v0.6.0_linux-amd64.tar.gz
cd go-ipfs && sudo bash install.sh && ipfs init
```
## Installare go-ipfs

```bash
cd go-ipfs && sudo bash install.sh && ipfs init
```
## Avviare

```bash
ipfs daemon
```

## Scaricare il progetto

```bash
git clone https://github.com/FrancescoAlbo97/Cybersecurity.git
```

## Avviare la Blockchain Quorum

```bash
cd network/4-nodes && ./start.sh
```

Tornare poi sulla cartella principale

## Installare ed eseguire Truffle

```bash
npm install -g truffle
truffle migrate
```

## Installare Dipendenze di Node.js

```bash
cd node
sudo npm install 
```

## Avviare il server e il sito

```bash
nodemon app.js
```

In seguito accedere a
```
http://localhost:3000/image
```

per caricare le immagini simulando l'invio di queste da parte del drone

In seguito accedere a
```
http://localhost:3000/
```

Effettuare il Login con le credenziali per visualizzare le immagini "caricate dal drone"
```
user: Admin05
password: Av6jW!x
```

# Documentazione

## Link a documentazione esterna 

IPFS [link](https://docs.ipfs.io/how-to/command-line-quick-start/#install-ipfs).

Quorum-wizard [link](https://github.com/jpmorganchase/quorum-wizard)

Truffle [link](https://www.trufflesuite.com/docs)




