// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract DomainRegistry {
    mapping(string => DomainInfo) public domains;
    address public owner;

    struct DomainInfo {
        address owner; // Владелец домена
        uint creationTime; // Время создания домена
        uint price; // Цена регистрации домена
    }

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function register(string memory name) public payable {
        require(domains[name].owner == address(0), "Domain already registered");
        domains[name] = DomainInfo(msg.sender, block.timestamp, msg.value);
    }

    function getAddress(string memory name) public view returns (address) {
        return domains[name].owner;
    }

    function withdraw() public onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");
        payable(owner).transfer(balance);
    }
}