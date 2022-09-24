// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract SignVerifierTest is Test {
    // group order value of Secp256k1 curve
    // https://github.com/bmancini55/bitcoin-ecc/blob/df048235cdc89c4dd9cd253310637061ed17f5e8/lib/Secp256k1.ts#L7
    bytes32 constant public groupOrder = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141;
    function setUp() public {
    }

    function testMalleable() public {
        // put r,s,v,hash values from `node sign.js` logs
        // first 32 bytes of the signature
        bytes32 r = 0xc1d9e2b5dd63860d27c38a8b276e5a5ab5e19a97452b0cb24094613bcbd517d8;
        // next 32 bytes
        bytes32 s = 0x6dc0d1a7743c3328bfcfe05a2f8691e114f9143776a461ddad6e8b858bb19c1d;
        uint8 v = 28;

        bytes32 hash = 0x3ea2f1d0abf3fc66cf29eebb70cbd4e7fe762ef8a09bcc06c8edf641230afec0;

        // prints the address (signer)
        console.log("original signer", ecrecover(hash, v, r, s));

        // we change the s value changing the signature
        bytes32 s1 = bytes32(uint256(groupOrder)-uint256(s));
        // original signature should use the lower s value
        assertTrue(uint(s1) > uint(s));

        // we changed the signature and show that it signed without knowing the private key
        console.log("Change s, we get a different signer");
        console.log(ecrecover(hash, v, r, s1));

        console.log("Change s and v, we get the same signer");
        uint8 v1 = v==27 ? 28 : 27;
        console.log("original signer with changed signature", ecrecover(hash, v1, r, s1));

    }

}