import { config } from "dotenv";
import mysql from "mysql";
// const mysql = require('mysql');

// buat konfigurasi koneksi
const koneksi = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'datatest',
    multipleStatements: true
});
// koneksi database
koneksi.connect((err) => {
    if (err) throw err;
    console.log('MySQL Connected');
    console.log(`error => ${err}`);
});
// module.exports = koneksi;
export default config