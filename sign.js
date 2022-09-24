const EthCrypto = require("eth-crypto");

const signerIdentity = EthCrypto.createIdentity();
const message = EthCrypto.hash.keccak256([
{type: "string",value: "Hello World!"}
]);
const signature = EthCrypto.sign(signerIdentity.privateKey, message);
console.log(`hash: ${message}`);
console.log(`signature: ${signature}`);
console.log(`address: ${signerIdentity.address}`);

if (signature.length != 132) {
    throw "invalid sign, exit";
}

const sign1 = signature.slice(2);
const r = sign1.slice(0, 64);
const s = sign1.slice(64, 128);
const v = sign1.slice(128);

console.log("r", "0x"+r);
console.log("s", "0x"+s);
console.log("v", parseInt(v,16));
