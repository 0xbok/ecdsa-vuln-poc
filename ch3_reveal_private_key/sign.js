import pkg from 'secp256k1';
const { ecdsaSign } = pkg;
import { hash as _hash, util } from "eth-crypto";
import pkg1 from 'elliptic';
const { ec: EC } = pkg1;
const ec = new EC('secp256k1')
const ecparams = ec.curve
const BN = ecparams.n.constructor


// ecdsa sign using a nonce provided as an argument.
// code modified from eth-crypto's sign.js to expose nonce argument.
function sign(privateKey, hash, nonce) {
    hash = util.addLeading0x(hash);
    if (hash.length !== 66)
        throw new Error('EthCrypto.sign(): Can only sign hashes, given: ' + hash);

    const sigObj = ecdsaSign(
        new Uint8Array(Buffer.from(util.removeLeading0x(hash), 'hex')),
        new Uint8Array(Buffer.from(util.removeLeading0x(privateKey), 'hex')),
        {   // function always returns fixed nonce.
            noncefn: (message, privateKey, algo,
               data, attempt) => { return new Uint8Array(Buffer.from(util.removeLeading0x(nonce), 'hex')) }
        }
    );

    const recoveryId = sigObj.recid === 1 ? '1c' : '1b';

    const newSignature = '0x' + Buffer.from(sigObj.signature).toString('hex') + recoveryId;
    return newSignature;
}

// split signature into r,s,v values
function get_rsv(sig) {
    const sig1 = util.removeLeading0x(sig);

    const r = sig1.slice(0, 64);
    const s = sig1.slice(64, 128);
    const v = sig1.slice(128);
    return {r:r, s:s, v:v};
}

// we will only use privateKey for signing.
const privateKey = "0xe8f2ae1b4e2932271ac9fab5dac2b0aa83498376e969c915b47863a85bb91a9a";
// corresponding address: "0xF6A2dc49a58C3260e2AF963A44e36F8C4332a640";
const message1 = "0x62ba5d9a955135bd710cbe6cf9f35a15364ab928f278104c682912d096811a7d";
const message2 = "0x7521d1cadbcfa91eec65aa16715b94ffc1c9654ba57ea2ef1a2127bca1127a84";

const nonce = _hash.keccak256("x");
// generating two signature with the same nonce.
const sig1 = sign(privateKey, message1, nonce);
const sig2 = sign(privateKey, message2, nonce);

// `privateKey` is never used until the end where we
// match it with the recovered private key.
const rsv1 = get_rsv(sig1);
console.log("r1", util.addLeading0x(rsv1.r));
console.log("s1", util.addLeading0x(rsv1.s));

const rsv2 = get_rsv(sig2);

console.log("s2", util.addLeading0x(rsv2.s));

// notice that r are same.
if (rsv1.r !== rsv2.r) {
    throw("r do not match, not possible");
}

const s1 = new BN(rsv1.s, 16);
const s2 = new BN(rsv2.s, 16);
const r = new BN(rsv1.r, 16);
const h1 = new BN(util.removeLeading0x(message1), 16);
const h2 = new BN(util.removeLeading0x(message2), 16);

/**
 *  we now calculate
 * (s2*h1 - s1*h2) / (r*(s1-s2)) mod n
 * where n is the group order of secp256k1
 */

let num = s2.mul(h1).mod(ecparams.n).sub(s1.mul(h2).mod(ecparams.n));
if (num.isNeg()) {
    num = num.add(ecparams.n);
}

let den = r.mul(s1).mod(ecparams.n).sub(r.mul(s2).mod(ecparams.n));
if (den.isNeg()) {
    den = den.add(ecparams.n);
}

let deninv = den.invm(ecparams.n);

//////////////////////////////////

const recoveredPrivateKey = util.addLeading0x(num.mul(deninv).mod(ecparams.n).toString(16));

if (recoveredPrivateKey === privateKey) {
    console.log("recovered private key successfully");
} else {
    console.log("recovered private key doesn't match. not possible");
}