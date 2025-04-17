pragma solidity ^0.8.0;

contract MyFirstContract {
    struct DomainInfo {
        address owner;
        uint256 creationTime;
        uint256 price;
    }
    
    mapping(string => DomainInfo) public domains;

    function register(string memory name) public payable {
        require(domains[name].owner == address(0), "Domain alredy registered")
        domains[name] = DomainInfo(msg.sender, block.timestamp, msg.value);
    }
    
    constructor() {
        
    }
}