// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ECDSA} from "../lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";
import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract FoolProofNFT is ERC721 {

    mapping(bytes32 => bool) seen;
    uint tokenId;

    constructor() ERC721("Fool", "Proof") {}


    function mintOnlyOncePerAddress(bytes memory sig, address receiver) external {
        bytes32 key = keccak256(sig);
        require(!seen[key]);
        seen[key] = true;

        bytes32 hash = keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n20", receiver));
        address signer = ECDSA.recover(hash, sig);
        require(signer == receiver);

        _mint(receiver, tokenId++);
    }

    function _transfer(
        address,
        address,
        uint256
    ) internal virtual override {
        revert();
    }
}
