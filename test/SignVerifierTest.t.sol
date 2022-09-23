// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract SignVerifierTest is Test {
    // group order value of Secp256k1 curve
    // https://github.com/bmancini55/bitcoin-ecc/blob/df048235cdc89c4dd9cd253310637061ed17f5e8/lib/Secp256k1.ts#L7
    bytes32 constant public groupOrder = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141;
    function setUp() public {
    }

    function testMalleable() public view {
        // r, s, hash value from https://blog.openzeppelin.com/signing-and-validating-ethereum-signatures
        // first 32 bytes of the signature
        bytes32 r = 0x1556a70d76cc452ae54e83bb167a9041f0d062d000fa0dcb42593f77c544f647;
        // next 32 bytes
        bytes32 s = 0x1643d14dbd6a6edc658f4b16699a585181a08dba4f6d16a9273e0e2cbed622da;

        bytes32 hash = 0x3ea2f1d0abf3fc66cf29eebb70cbd4e7fe762ef8a09bcc06c8edf641230afec0;

        // prints the address (signer)
        console.log("original signer", ecrecover(hash, 27, r, s));

        // we change the s value changing the signature, and we get the same address
        bytes32 s1 = bytes32(uint256(groupOrder)-uint256(s));
        console.log("original signer with changed signature", ecrecover(hash, 28, r, s1));

        // we changed the signature and show that it signed without knowing the private key
        console.log("different signer without knowing their private key", ecrecover(hash, 27, r, s1));
    }

}
