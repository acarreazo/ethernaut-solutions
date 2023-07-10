# ethernaut-solutions
Solutions for the Ethernaut (Web3/Solidity based wargame)

### Fallback 
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
With <b>contribute()</b> only we need to pass this conditicion `if(contributions[msg.sender] > contributions[owner])`
But, this function only accept values < 0.001 ether and right now after the contract has deployed `contributions[owner]) has 1000 ether, so in this case it is not posible.


```solidity 
receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
  }
```
With <b>receive()</b> we need to pass this condition `require(msg.value > 0 && contributions[msg.sender] > 0);` For that is necesary to make a contribution > 0 and < 0.001.


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
