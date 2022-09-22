// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SigVerifier {
    // bytes32 constant public groupOrder = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141;

    // function splitSignature(bytes32 first32, bytes32 second32, bytes1 third1) external returns (uint8, bytes32, bytes32) {
    //     // require(sig.length == 65);

    //     bytes32 r;
    //     bytes32 s;
    //     uint8 v;

    //     assembly {
    //         // first 32 bytes
    //         r := mload(add(sig, 0x20))
    //         // next 32 bytes
    //         s := mload(add(sig, 0x40))
    //         // next byte
    //         v := byte(0, mload(add(sig, 0x60)))
    //     }
    //     return (v, r, s);
    // }

    function verify(
        bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external pure returns (address a1) {
        a1 = ecrecover(hash, v, r, s);
        // a2 = ecrecover(hash, v, r, bytes32(uint256(groupOrder)-uint256(s)));
    }
}
