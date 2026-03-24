require('dotenv').config();
const {app, BrowserWindow} = require('electron');
const { Client } = require('pg');

const dbConfig = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT
};

const client = new Client(dbConfig);

client.connect()
    .then(() => {
        console.log('База данных подключена');
        return client.query('SELECT * FROM branches');
    })
    .then(res => {
        console.log('СПИСОК ОТДЕЛЕНИЙ');
        console.table(res.rows);
    })
    .catch(err => console.error(`Ошибка: ${err.message}`));

function createWindow() {
    const win = new BrowserWindow({
        width: 800,
        height: 600
        }
    );

    win.setMenu(null);

    win.loadFile('index.html');
}

app.whenReady().then(createWindow);