# ECDSA signatures are malleable

Details: https://www.derpturkey.com/inherent-malleability-of-ecdsa-signatures
From the article:
> It allows anyone to modify the signature in a specific way without access to the private key and yet the signature remains perfectly valid!

A signature is a tuple of `(r,s,v)` values. `v` is restricted to 27 or 28. We show that just be substituting `s = N - s` where `N` is a pre-defined constant (order of the elliptic curve group used by Bitcoin and Ethereum), we can change the recovered address (by `ecrecover`) fooling the verifier into thinking that someone else signed the message.

- Go to `SignVerifierTest.t.sol` to see how you can change the signature for Ethereum's Secp256k1 curve.
Once someone signs a message and produces a signature, just using the signature, you can create another signature that is perfectly valid (that is `ecrecover` will tell you the original signer signed it).

- Next we also show that we can modify the signature to show someone other address signed the message! Which is why it's important to restrict the value of `s` to be lower of the two values.

## Steps to run
- `forge install` ([Install foundry](https://book.getfoundry.sh/getting-started/installation) if you haven't).
- `forge test -vv` and two same addresses should be printed on screen.

## Be safe
You can be safe from these footguns by using OpenZeppelin's ECDSA library instead of the vanilla `ecrecover` operation.

Please note that just using this library won't protect you from all signature vulnerabilities.