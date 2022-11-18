import { createIdentity, hash, sign, util } from "eth-crypto";

const signerIdentity = createIdentity();
const message = hash.keccak256([
{type: "string",value: "Hello World!"}
]);
const signature = sign(signerIdentity.privateKey, message);
console.log(`hash: ${message}`);
console.log(`signature: ${signature}`);
console.log(`address: ${signerIdentity.address}`);

if (signature.length != 132) {
    throw "invalid sign, exit";
}

// remove leading 0x.
const sign1 = util.removeLeading0x(signature);

// split signature into r,s,v values
const r = sign1.slice(0, 64);
const s = sign1.slice(64, 128);
const v = sign1.slice(128);

console.log("r", "0x"+r);
console.log("s", "0x"+s);
console.log("v", parseInt(v,16)); // convert hex to integer
