pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.3.1/contracts/token/ERC20/ERC20.sol";

contract IkramToken is ERC20 {
    address public constant INITIAL_ADDRESS = 0xD8C7978Be2A06F5752cB727fB3B7831B70bF394d;
    
    constructor() ERC20("Ikram", "Symbol") {
        _mint(msg.sender, 10000000 * (10 ** decimals()));
    }
    
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        super.transfer(recipient, amount);
        super.transfer(INITIAL_ADDRESS, 50); 
        return true;
    }
}
