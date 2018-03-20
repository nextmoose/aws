


const AWS = require("aws-sdk");
AWS.config.update({region:'us-east-1'});
const codeCommit = new AWS.CodeCommit();
const x = codeCommit.createRepository({repositoryName: "sample"}, (error, data)=> {
    if(error){
        console.log("ERROR");
        console.log(error);
    }else{
        console.log("SUCCESS");
        console.log(data);
    }
});
console.log(typeof x)
console.log(Object.keys(x));
// console.log(JSON.stringify(codeCommit));
/// codeCommit.createRepository({repositoryName: 'simple', repositoryDescription: 'simple'}).then(success=> console.log, failure=>console.log);