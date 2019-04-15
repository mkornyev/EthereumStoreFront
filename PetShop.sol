pragma solidity ^0.5.0;

contract PetShop {
  //Pets hash:
  mapping (uint=>address) public petOwners;
  uint public numPets;
  address public shopOwner;

  constructor() public {
    numPets = 4;
    shopOwner = msg.sender;
  }

  modifier ownerOnly()
  {
    // Only Contract owner can send a Tx 
    require(msg.sender == shopOwner);
    _;
  }

  //A pet costs 1 ether
  function adopt(uint petId) public payable {
      assert(1 <= petId); 
      assert(petId <= numPets); 
      assert(petOwners[petId] == address(0x0)); //Pet cannot be adopted 
      assert(msg.value == 1e18); //Assert buyer paying at least 1ETH 
      address(this).transfer(msg.value); //Transfer 1ETH to contract from buyer
      petOwners[petId] = msg.sender;
  }

  function getOwner(uint petId) public view returns(address) {
      assert(1 <= petId); //Pet id range valid 
      assert(petId <= numPets); //Pet id range valid 
      return petOwners[petId]; //return Owner for given pet
  }

  function addPets(uint numAdditionalPets) public 
    ownerOnly
  { 
    numPets = numPets + numAdditionalPets; //Add additional pets to store 
  }
  
  function () external payable {
  } 
}
