// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ECDSA} from "../lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";
import "forge-std/Test.sol";

contract SignVerifierTest is Test {

    function setUp() public {}

    function testNotUnique() public {
        address signer = 0xF6A2dc49a58C3260e2AF963A44e36F8C4332a640;
        bytes32 hash = 0x62ba5d9a955135bd710cbe6cf9f35a15364ab928f278104c682912d096811a7d;
        bytes memory sig1 = hex"0659dbb28cb9a26c45d9a5fd0105f873730a92d988afe9ab27c87b42b274685d714667f208b6ffc7e1184eeb3cc6cdd550a73225f60ffa877ae6fb32a1a62ff81b";
        bytes memory sig2 = hex"863fcb3a9f79fc61bc5984aac1fc5ed0d08398b690fa33e218f9dbe690344ac07c73560633b878145adab260f3aa1841bdb012461b28996606c9f2e06727dcce1c";

        assertEq(signer, ECDSA.recover(hash, sig1));
        assertEq(signer, ECDSA.recover(hash, sig2));
    }
}
