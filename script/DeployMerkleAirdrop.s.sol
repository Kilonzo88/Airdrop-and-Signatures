// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {AppleToken} from "src/AppleToken.sol";
import {Script} from "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script{
    bytes32 private s_merkleRoot = bytes32(0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4);
    uint256 private s_amountToTransfer = 4 * 25 * 1e18;

    AppleToken public appleToken;
    MerkleAirdrop public merkleAirdrop;


    function deployMerkleAirdrop() public returns(MerkleAirdrop, AppleToken) {
        vm.startBroadcast();
        appleToken = new AppleToken();
        merkleAirdrop = new MerkleAirdrop(s_merkleRoot, appleToken);
        appleToken.mint(appleToken.owner(), s_amountToTransfer);
        appleToken.transfer(address(merkleAirdrop), s_amountToTransfer);
        vm.stopBroadcast();

        return (merkleAirdrop, appleToken);
    }

    function run() external returns (MerkleAirdrop, AppleToken) {
        return deployMerkleAirdrop();
    }
}