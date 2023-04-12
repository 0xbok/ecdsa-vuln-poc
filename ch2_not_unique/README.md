# ECDSA signatures can be different for the same message
Applying from last chapter, this chapter uses OpenZeppelin's ECDSA library for signature verification. However...

ECDSA uses a random number (aka nonce) to generate a signature. Read [Nakov's description](https://cryptobook.nakov.com/digital-signatures/ecdsa-sign-verify-messages#ecdsa-sign) to understand more. Signature libraries hide this complexity from users, so we generally get the same signature when the private key signs a message multiple times.

This chapter shows how using different random numbers produces different signatures.

`sign.js` exposes the random number (aka nonce) argument in the signing function, generally hidden away. It then takes a message and signs it using two difference nonces. These signatures and the corresponding signing address is used in `Verifier.t.sol` for signature verification. To run this, use `node sign.js`.

These signatures are copied to `Verifier.t.sol` to show:
It's possible to have two different signatures be produced on the same message and signer.
- Run `FOUNDRY_PROFILE=ch2 forge test` to see how 2 completely different signatures can recover the same signer address.

## Be safe
If your smart contract depends on signature verification, and you don't want to verify for the same data twice - store the message instead of the signature to recognize that the data has been verified before.