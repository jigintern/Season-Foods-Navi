const fs = require("fs");

const inputJSONfile = "DummyDataList.json";
const jsonObject = JSON.parse(ReadFile(inputJSONfile));

console.log(jsonObject);//.recipiList[0].name);

Object.keys(jsonObject.foodList).forEach(function(key){
  console.log(jsonObject.foodList[key].name);
});

/* function */

function ReadFile(filePath){
    var content = "";
    if(CheckFile(filePath)) {
      content = fs.readFileSync(filePath, "utf8");
    }
    return content;
};

function CheckFile(filePath){
    var isExist = false;
  try {
    fs.statSync(filePath);
    isExist = true;
  } catch(err) {
    isExist = false;
  }
  return isExist;
};

function WriteFile(filePath, stream) {
  try {
    fs.writeFileSync(filePath, JSON.stringify(stream));
    return true;
  } catch(err) {
    return false;
  }
};

