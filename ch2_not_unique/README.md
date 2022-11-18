# ECDSA signatures can be different for the same message
Applying from last chaper, this chapter uses OpenZeppelin's ECDSA library for signature verification. However...

ECDSA uses a random number (aka nonce) to generate a signature. Signature libraries hide this complexity is generally hidden from users, so we generally get the same signature when the private key signs a message multiple times.

This chapter shows how using different random numbers produces different signatures.

- Run `FOUNDRY_PROFILE=ch1 forge test` to see how a signature can be modified to get the same signer, and can also be modified to get a completely different signer address.
- The code that just ran is in `ch2_not_unique/SignVerifier.t.sol`.

`SignVerifier.t.sol` shows:
It's possible to have two different signatures be produced on the same message and signer. To see how, go through `sign.js` and run `node sign.js`.

`sign.js` exposes the random number (aka nonce) argument in the signing function, generally hidden away. It then takes a message and signs it using two difference nonces. These signatures and the corresponding signing address is used in `SignVerifier.t.sol` for signature verification.

## Be safe
If your smart contract depends on signature verification, and you don't want to verify for the same data twice - store the message instead of the signature to recognize that the data has been verified before.