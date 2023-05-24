# ethernaut-solutions
Solutions for the Ethernaut (Web3/Solidity based wargame)


## Telephone
In the contract Telephone the function changeOwner is public and can be invoked fron any contract

```solidity 
function changeOwner(address _owner) public { ..}
```
In order to hack the contract we need to focus on this condition
```solidity 
   if (tx.origin != msg.sender) {
      owner = _owner;
   }
```
