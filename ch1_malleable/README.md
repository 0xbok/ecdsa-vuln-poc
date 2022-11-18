# ECDSA signatures are malleable

Details: https://www.derpturkey.com/inherent-malleability-of-ecdsa-signatures.
From the article:
> It allows anyone to modify the signature in a specific way without access to the private key and yet the signature remains perfectly valid!

javascript implementation from: https://blog.openzeppelin.com/signing-and-validating-ethereum-signatures/

A signature is a tuple of `(r,s,v)` values. `v` is restricted to 27 or 28. We show that just by substituting `s = N - s` where `N` is a pre-defined constant (order of the elliptic curve group used by Bitcoin and Ethereum, `secp256k1`), we can change the recovered address (by `ecrecover`) fooling the verifier into thinking that someone else signed the message.

- Run `FOUNDRY_PROFILE=ch1 forge test` to see how a signature can be modified to get the same signer, and can also be modified to get a completely different signer address.
- The code that just ran is in `ch1_malleable/Verifier.t.sol`.

If you want to generate your own keys and signatures:
- Run `node sign.js` to print ethereum address, and `r,s,v` values from signature.
- Copy `r,s,v` values into `Verifier.t.sol`. Go through the file.
- Now, run `FOUNDRY_PROFILE=ch1 forge test`.

What `Verifier.t.sol` does:
- First it recovers the original address using correct signature.
- Then it modifies the signature (by changing `s`) to show someone other address signed the message! Which is why it's important to restrict the value of `s` to be lower of the two possible values.
- Then we also change `v` to show you can create another signature that recovers the original signer address.

## Be safe
You can be safe from this vulnerability by using OpenZeppelin's ECDSA library instead of the vanilla `ecrecover` operation.
