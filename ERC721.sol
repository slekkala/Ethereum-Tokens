pragma solidity ^0.4.24;

contract ERC721 {
    
    address owner;
    mapping (uint => address) assets;
    uint current_asset;
    
    // Intialize first 100 Assets to the owner
    constructor () public{
        owner = msg.sender;
        for(uint idx=0;idx<100;idx++){
            assets[idx] = owner;
        }
        current_asset = 100;
    }
    
    //Allow users to transfer assets to each other
    function transferAsset(uint256 asset, address to) public {
        require( assets[asset] == msg.sender);
        assets[asset] = to;
    }
    
    function getOwner(uint256 asset) public view returns (address){
        return assets[asset];
    }
    
    // Purchase Unique Assets
    function purchaseUniqueAsset() public payable returns (uint256 id){
         require( msg.value == 1 ether );
         assets[current_asset] = msg.sender;
         current_asset++;
         return current_asset-1;
    }
    
}

