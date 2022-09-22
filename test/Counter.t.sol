// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    SigVerifier public counter;
    bytes32 constant public groupOrder = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141;
    // bytes32 constant public groupOrder = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;
    function setUp() public {
    }

    function testMalleable() public {
        // bytes memory sig = abi.encodePacked(0x8e3d4cafe30a0db22cd60c58dc75bdb59e50d41d4e439366f206ddfa34b127e100ed19b92c90c1c6f55cc2e8b4ddd653cf0aeec9c5b786c97f8a48c6e9093acd1b);
        // (uint8 v, bytes32 r, bytes32 s) = counter.splitSignature(sig);
        bytes32 r = 0x1556a70d76cc452ae54e83bb167a9041f0d062d000fa0dcb42593f77c544f647;
        bytes32 s = 0x1643d14dbd6a6edc658f4b16699a585181a08dba4f6d16a9273e0e2cbed622da;
        // uint8 v = 27;
        bytes32 hash = 0x3ea2f1d0abf3fc66cf29eebb70cbd4e7fe762ef8a09bcc06c8edf641230afec0;
        console.log(ecrecover(hash, 27, r, s));

        bytes32 s1 = bytes32(uint256(groupOrder)-uint256(s));
        console.log(ecrecover(hash, 28, r, s1));
    }

}
