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
Both `tx.origin` and `msg.sender` are global variables
tx.origin refers to address of the Externally Owned Account that originally sent the call (or start the transaction).
msg.sender refers to the address that has called or initiated a function or created a transaction.
