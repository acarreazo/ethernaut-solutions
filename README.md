# ethernaut-solutions
Solutions for the Ethernaut (Web3/Solidity based wargame)

## Fallback 
This contract has two methods when we can use in order to solve the challenge: contribute and receive.
```solidity 
 function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;
    if(contributions[msg.sender] > contributions[owner]) {
      owner = msg.sender;
    }
  }
```
```solidity 
receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
  }
```

## Telephone
In the contract Telephone the function changeOwner is public and can be invoked fron any contrac

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
