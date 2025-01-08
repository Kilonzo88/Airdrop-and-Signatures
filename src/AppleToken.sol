//SPDX_License-Identifier: MIT  

pragma solidity ^0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract AppleToken is ERC20, Ownable{
   constructor() ERC20("AppleToken", "APPL") Ownable(msg.sender) {}

   function mint(address to, uint256 amount) external onlyOwner {
    _mint(to, amount);
   }
}