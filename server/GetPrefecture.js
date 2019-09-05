'use strict'

const http = require('http');

var REQUEST_PREFECTURE_URL = "http://geoapi.heartrails.com/api/json?method=searchByGeoLocation"

//var x = 136.180764, y = 35.966679; 
//console.log(JSON.parse(GetPrefecture(x,y)).response.location[0].prefecture);
//GetPrefecture(x,y);

async function GetPrefecture(longitude,latitude){
    const pref = await new Promise((resolve, reject) => {
        REQUEST_PREFECTURE_URL += '&x=' + longitude + '&y=' + latitude;
        // console.log(REQUEST_PREFECTURE_URL);
        http.get(REQUEST_PREFECTURE_URL, (res) => {
            let body = '';
            res.on('data',(chunk) => {
                body += chunk;
            });
            
            res.on('end',(res) => {
                // console.log(body);
                if(body.indexOf('error') >= 0){
                    res = "null";
                }else{
                    res = JSON.parse(body).response.location[0].prefecture;
                }
                // console.log(res);
                resolve(res)
            });
        }).on('error', (e) => {
            console.log(e.message);
            reject(e.message)
        });
    });

    return pref
}
module.exports = {
	GetPrefecture: GetPrefecture,
}