# Progetto Cybersecurity UNIVPM 

> GRUPPO 7: Alborino Francesco, Borc Bogdan Petru, Marchetti Michele, Mazzucchelli Chiara, Scoppolini Massini Lorenzo


# Indice

- [Come iniziare](#come-iniziare)
- [Documentazione esterna](#Documentazione)

# Come iniziare

## Scaricare il progetto

```bash
git clone https://github.com/FrancescoAlbo97/Cybersecurity.git
```

## Installare go-ipfs

```bash
cd go-ipfs && sudo bash install.sh && ipfs init
```
> Se Ipfs dovesse dare problemi, scaricarlo in questo modo:
```bash
wget https://github.com/ipfs/go-ipfs/releases/download/v0.6.0/go-ipfs_v0.6.0_linux-amd64.tar.gz
tar -xvzf go-ipfs_v0.6.0_linux-amd64.tar.gz
cd go-ipfs && sudo bash install.sh && ipfs init
```

## Avviare

```bash
ipfs daemon
```
Lasciare attivo il daemon per poter utilizzare il servizio ipfs

## Avviare la Blockchain Quorum

```bash
cd Cybersecurity/network/4-nodes && ./start.sh
```

Tornare poi sulla cartella Cybersecurity

## Installare ed eseguire Truffle

```bash
sudo npm install -g truffle
truffle migrate
```

## Installare Dipendenze di Node.js

```bash
cd node && sudo npm install 
```
> Se qualche package dovesse dar problemi, eseguire:
 ```bash
sudo npm install *package* -g --save
```
> con nodemon al posto di *package* per esempio.

## Avviare il server e il sito

```bash
nodemon app.js
```
Una volta comparso il print "connected to db" accedere a
```
http://localhost:3000/image
```

per caricare le immagini simulando l'invio di queste da parte del drone, quelle di prova sono state riportate nella Cartella Cybersecurity/immagini/

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

## Codice Frontend

Nella cartella Cybersecurity/node/project_front_end è disponibile il codice del frontend.
Comunque per semplicità di utilizzo è stato realizzato già il build e inserito nella cartella Cybersecurity/node/public.

Nella cartella Cybersecurity/immagini sono disponibili le immagini di prova da caricare per simulare l'invio del drone

## Link a documentazione esterna 

IPFS [link](https://docs.ipfs.io/how-to/command-line-quick-start/#install-ipfs)

Quorum-wizard [link](https://github.com/jpmorganchase/quorum-wizard)

Truffle [link](https://www.trufflesuite.com/docs)

Npm [link](https://docs.npmjs.com/packages-and-modules/)

Flutter [link](https://flutter.dev/web)





