# ECDSA signature vulnerabilities

This repository reproduces ECDSA vulnerabilities. I've been trying to replicate them, and thought it could be useful to others exploring this, especially since they are used a lot in Ethereum.

To be clear, these vulnerabilities are not in ECDSA algorithm but rather specific to its verification or application.

There's plenty of online material explaining different ECDSA related attacks. This repo contains different chapters each focusing on one attack. You might already be aware of best practices in smart contracts when dealing with ECDSA signatures, but here the goal is to show why these practices are recommended.

- [Chapter 1](./ch1_malleable/) - ECDSA signatures are malleable.
- [Chapter 2](./ch2_not_unique/) - ECDSA signatures are not unique.
- [Chapter 3](./ch3_reveal_private_key/) - ECDSA signatures can reveal your private key if you use the same random number (aka nonce).

Each chapter goes into more detail to demonstrate the vulnerability, directing you towards material if you want to read further.

## Steps to run
This assumes familiarity with Javascript, Solidity and Foundry.

1. Clone the repository.
2. Run `yarn` to install npm packages. The installed packages will be used to generate keys and sign messages.
3. [Install foundry](https://book.getfoundry.sh/getting-started/installation) and run `forge install`.
4. For chapter 1, run `FOUNDRY_PROFILE=ch1 forge test`, and so on.

## Understanding chapters
Each chapter demonstrates a different attack, and documents what can be done to be safe. Due to the use of Solidity, the recommendations provided are specifically applicable on smart contracts on Ethereum, but the general concept remains the same and hence may be applied outside of Ethereum too.
