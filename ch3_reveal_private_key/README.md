# Reusing nonce reveals your private key

Source: https://billatnapier.medium.com/ecdsa-weakness-where-nonces-are-reused-2be63856a01a
As shown in previous chapter, ECDSA algorithm uses a nonce to generate a signature, and this complexity is hidden from the end user.

Here we see that if the same nonce is used on different data, just by having the two signatures, anyone can extract the private key (and the nonce).

`sign.js` uses the same nonce to sign on different data, and shows you can can retrieve the private key just from the two signatures. To run it: `node sign.js`.

## Be safe
Never specify your nonce even if you produce it randomly. This complexity is hidden for a reason.