// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Product {
    uint public id;
    string public name;
    uint public price;
    address payable public owner;
    bool public purchased;

    event ProductPurchased(address buyer, uint price);

    constructor(string memory _name, uint _price, address _owner) {
        name = _name;
        price = _price;
        owner = payable(_owner);
        purchased = false;
    }

    function purchaseProduct() public payable {
        require(!purchased, "Product already purchased");
        require(msg.value >= price, "Not enough Ether");

        owner.transfer(msg.value);
        owner = payable(msg.sender);
        purchased = true;

        emit ProductPurchased(msg.sender, price);
    }
}
