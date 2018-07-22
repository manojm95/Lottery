pragma solidity ^0.4.17; contract Lottery {
    
    address public manager;
    address[] public players;
  	constructor() public
    {
	    manager = msg.sender;
    }
    
    function enter() public payable {
        require( msg.value > 0.01 ether);
        
        players.push(msg.sender);
    }
    
    function getArray() public view returns (address[]) {
        return players;
    }
    
    function randomNum() public view returns (uint) {
         //we dont need any import for calling sha3. The aother alias for sha3() is keccak256();
         //block is a global variable
        //now is global variable for current timestamp
         //sha3(block.difficulty, now, players);----> this generates a hexadecimal number and we can cast it to uint like below
        return uint(keccak256(block.difficulty, now, players));
        
	}
    function pickWinner() public {
        uint random = randomNum();
        random = random % players.length;
        players[random].transfer(address(this).balance);
        
    }
    
  
}
