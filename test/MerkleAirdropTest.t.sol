//SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {AppleToken} from "src/AppleToken.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {Test, console} from "forge-std/Test.sol";
import {ZkSyncChainChecker} from "foundry-devops/src/ZkSyncChainChecker.sol";
import {DeployMerkleAirdrop} from "../script/DeployMerkleAirdrop.s.sol";

contract MerkleAirdropTest is ZkSyncChainChecker, Test {
    MerkleAirdrop public merkleAirdrop;
    AppleToken public appleToken;

    bytes32 public ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public AMOUNT_TO_CLAIM = 25 *1e18;
    uint256 public AMOUNT_TO_SEND = AMOUNT_TO_CLAIM * 4;
    bytes32 proofOne = 0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
    bytes32 proofTwo = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
    bytes32[] PROOF = [proofOne, proofTwo];
    address private user;
    address private gasPayer;
    uint256 private userPrivKey;

    function setUp() public {
        if (! isZkSyncChain()) {
            DeployMerkleAirdrop deployer = new DeployMerkleAirdrop();
            (merkleAirdrop, appleToken) = deployer.run();

        } else {
        appleToken = new AppleToken();
        merkleAirdrop = new MerkleAirdrop( ROOT,appleToken);
        appleToken.mint(appleToken.owner(), AMOUNT_TO_SEND);
        appleToken.transfer(address(merkleAirdrop), AMOUNT_TO_SEND);
        }

        (user, userPrivKey) = makeAddrAndKey("user");
        (gasPayer,) = makeAddrAndKey("gasPayer");
        
        
    }


    function testUsersCanClaim() public {
        uint256 startingBalance = appleToken.balanceOf(user);
        bytes32 digest = merkleAirdrop.getMessageHash(user, AMOUNT_TO_CLAIM);
         
        // sign a message
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivKey, digest);
        //gas payer calls claim using the signed message to pay for the gas
        
        vm.prank(gasPayer);
        merkleAirdrop.claim(user, AMOUNT_TO_CLAIM, PROOF,v, r ,s);

        uint256 endingBalance = appleToken.balanceOf(user);
        console.log("EndingBalance: ",endingBalance);

        assertEq(endingBalance, startingBalance + AMOUNT_TO_CLAIM);
        
    }
}