
# ERC20 Token Airdrop with Double Verification

A highly secure ERC20 token airdrop system implementing a dual-layer verification mechanism through both Merkle proofs and cryptographic signatures, built with Foundry.

## 🔐 Double Verification System

This airdrop implementation features a unique double verification mechanism for maximum security:

1. **Merkle Proof Verification**
   - Efficiently validates user inclusion in the airdrop list
   - Gas-optimized through Merkle tree structure
   - Prevents unauthorized claims from non-whitelisted addresses

2. **Signature Verification**
   - Secondary security layer using cryptographic signatures
   - Each claim must be signed by the project authority
   - Prevents unauthorized claims even if Merkle proof is compromised
   - Implemented using OpenZeppelin's secure signature verification

This dual-layer approach ensures:
- Protection against unauthorized claims
- Defense against potential Merkle tree vulnerabilities
- Ability to revoke claim rights if needed
- Enhanced protection against smart contract exploitation

## Features

- **Double Verification Security**: Industry-leading security with both Merkle proof and signature verification
- **Gas Optimization**: Efficient verification of large distribution lists through Merkle trees
- **Double-Claim Prevention**: Built-in mechanisms to prevent users from claiming multiple times
- **OpenZeppelin Integration**: Leverages battle-tested OpenZeppelin contracts for security

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [Git](https://git-scm.com/downloads)

## Installation

```bash
# Clone the repository
git clone https://github.com/[your-username]/[repo-name]
cd [repo-name]

# Install dependencies
forge install

# Build the project
forge build
```

## Usage

### Setting Up the Airdrop

1. Deploy the ERC20 token contract
2. Generate the Merkle root for your airdrop recipients
3. Deploy the airdrop contract with the token address and Merkle root
4. Set up the signing authority for signature verification

```bash
forge script script/Deploy.s.sol --rpc-url <your_rpc_url> --broadcast
```

### Claiming Tokens

Users must provide both verification components to claim tokens:

```solidity
function claim(
    address account,
    uint256 amount,
    bytes32[] calldata merkleProof, // First verification: Merkle proof
    uint8 v,                        // Second verification: Signature components
    bytes32 r,
    bytes32 s
) external
```

The claim process:
1. Verifies the Merkle proof against the stored root
2. Validates the cryptographic signature
3. Only proceeds if both verifications pass
4. Transfers tokens to the user if all checks pass

## Testing

Run the test suite:

```bash
forge test
```

For detailed gas reporting:
```bash
forge test --gas-report
```

## Security

- Dual-layer verification system (Merkle proof + Signatures)
- Double-claim prevention mechanisms
- OpenZeppelin's secure signature verification
- Merkle proof verification for efficient and secure claims
- Comprehensive access controls

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


