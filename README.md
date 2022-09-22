# ECDSA signatures are malleable

Details: https://www.derpturkey.com/inherent-malleability-of-ecdsa-signatures
From the article:
> It allows anyone to modify the signature in a specific way without access to the private key and yet the signature remains perfectly valid!

Go to `SignVerifierTest.t.sol` to see how you can change the signature for Ethereum's Secp256k1 curve.
Once someone signs a message and produces a signature, just using the signature, you can create another signature that is perfectly valid (that is `ecrecover` will tell you the original signer signed it).

## Steps to run
- `forge install` ([Install foundry](https://book.getfoundry.sh/getting-started/installation) if you haven't).
- `forge test -vv` and two same addresses should be printed on screen.

## Be safe
You can be safe from these footguns by using OpenZeppelin's ECDSA library instead of the vanilla `ecrecover` operation.

Please note that just using this library won't protect you from all signature vulnerabilities.