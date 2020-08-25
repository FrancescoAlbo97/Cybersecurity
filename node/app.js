const express = require('express');
const app = express();
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const fileUpload = require('express-fileupload');
const cors = require('cors');
require('dotenv/config');

app.set('view engine', 'ejs');

//Middlewares
app.use(cors());  //da usere per permette l'accessa da tutti i domini
app.use(fileUpload({}));  //debug: true
app.use(bodyParser.urlencoded({extended: false}));  //fa in modo che ogni volta che viene fatta una richiesta viene lanciato body-parser
app.use(bodyParser.json({limit: "15mb"})); 


//Import routes
const postsRoute = require('./routes/post');  //definisco un file che lancio se 
app.use('/post', postsRoute);  //la rotta richiesta è quella segnata qui

const imageRoute = require('./routes/image');  //definisco un file che lancio se 
app.use('/image', imageRoute);  //la rotta richiesta è quella segnata qui

const getsRoute = require('./routes/get');  //definisco un file che lancio se 
app.use('/get', getsRoute);  //la rotta richiesta è quella segnata qui

//Connect to DB
mongoose.connect(process.env.DB_CONNECTION, 
    { 
      useNewUrlParser: true,
      //useUnifiedTopology: true,
    },
    () => console.log('connected to DB!')
);

app.listen(3000);