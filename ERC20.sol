pragma solidity ^0.4.24;

contract ERC20
{
    string public name;
    string public symbol;
    mapping (address => uint) public tokenOwner;
    address public creator;
    uint public avail;
    
    constructor (string _name, uint _avail, string _symbol) public
    {
        name = _name;
        avail = _avail;
        tokenOwner[msg.sender] = _avail;
        symbol = _symbol;
        creator = msg.sender;
    }
    
    function tokenAddress() public view returns (address) 
    {
        return address(this);
    }
    modifier onlyOwner 
    {
        require(msg.sender == creator);
        _;
    }
    function withdrawAllEth() onlyOwner external payable
    {
        //cast current contract to an address
        //then call the .balance method to return the contract balance
        require(address(this).balance > 0);
        //use .transfer so that we throw an error if we fail to send
        msg.sender.transfer(address(this).balance);
    }
    //for external and non ICO transfers
    function transfer(address sendto, uint amt) public
    {
        require(tokenOwner[msg.sender] >= amt);
        tokenOwner[msg.sender] -= amt;
        tokenOwner[sendto] += amt;
    }
    //has to be internal
    function transferTokens(address sendfrom, address sendto, uint amt) internal
    {
        require(tokenOwner[sendfrom] >= amt);
        tokenOwner[sendfrom] -= amt;
        tokenOwner[sendto] += amt;
        avail -= amt;
    }
    function buyTokens() public payable
    {
        //need to guard against division by 0
        require(msg.value >= 1000000000000000);
        uint256 amt = msg.value / 1000000000000000;
        require(tokenOwner[creator] >= amt && amt <= avail);
        transferTokens(creator, msg.sender, amt);
    }
    function getBalance() view public returns (uint)
    {
        return (tokenOwner[msg.sender]);
    }
    
    function getCreator() view public returns (address)
    {
        return (creator);
    }
    
}


