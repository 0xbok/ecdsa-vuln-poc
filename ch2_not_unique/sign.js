import pkg from 'secp256k1';
const { ecdsaSign } = pkg;
import { hash as _hash, util } from "eth-crypto";

// ecdsa sign using a nonce provided as an argument.
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

const privateKey = "0xe8f2ae1b4e2932271ac9fab5dac2b0aa83498376e969c915b47863a85bb91a9a";
// corresponding address: "0xF6A2dc49a58C3260e2AF963A44e36F8C4332a640";
const message = "0x62ba5d9a955135bd710cbe6cf9f35a15364ab928f278104c682912d096811a7d";

// generating first signature.
let nonce = _hash.keccak256("x");
const sig1 = sign(privateKey, message, nonce);
console.log(`sig1: ${sig1}`);

// generating a new signature with a different nonce.
nonce = _hash.keccak256("y");
const sig2 = sign(privateKey, message, nonce)
console.log(`sig2: ${sig2}`);
