const firebase = require("firebase");
// Required for side-effects
require("firebase/firestore");

// Initialize Cloud Firestore through Firebase
firebase.initializeApp({
    apiKey: "AIzaSyDdU5r-NF7dNCMvCFV6WUoVBd0e8BkBD_w",
    authDomain: "flutter-schooldev.firebaseapp.com",
    projectId: "flutter-schooldev"
  });
  
var db = firebase.firestore();

const School = require('node-school-kr') 
const school = new School()

school.init(School.Type.HIGH, School.Region.KANGWON, 'K100000414')
var meal

const sampleAsync = async function() {
meal = await school.getMeal()


   // 년도와 달을 지정하여 해당 날짜의 데이터를 조회할 수 있습니다.
  const mealCustom = await school.getMeal(2019, 12)


// for(var objVarName in mealCustom) {
//     console.log(mealCustom[objVarName])
//     db.collection("meals").add({
//         meal : mealCustom[objVarName],
//         date : "day" + objVarName
//     }).then(function(docRef) {
//         console.log("Document written with ID: ", docRef.id);
//     })
//     .catch(function(error) {
//         console.error("Error adding document: ", error);
//     });
// }
for(var objVarName in mealCustom){
    console.log(mealCustom[objVarName])
    data = {
        date : "day" + objVarName,
        meal : mealCustom[objVarName]
    }
    db.collection('meals').doc(objVarName).set(data);

}
}
sampleAsync()

 
