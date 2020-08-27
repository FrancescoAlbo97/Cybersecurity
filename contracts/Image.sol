pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;
//SPDX-License-Identifier: MIT

contract Image { 

  struct ImageStruct{
    uint[] confidences;
    string[] tags;
    //image json information
    string imageInfo;
    //gps json information
    string gpsInfo;
  }

  string[] public imagesAddress;
  mapping (string => ImageStruct) blocks;
  //ImageStruct[] public blocks;


  function set( 
    string memory _imagesAddress,
    uint[] memory _confidences,
    string[] memory _tags,
    string  memory _imageInfo,
    string memory _gpsInfo
  ) public {
    if(!contains(_imagesAddress)){
      ImageStruct storage newImage = blocks[_imagesAddress];
      newImage.confidences = _confidences;
      newImage.tags = _tags;
      newImage.imageInfo = _imageInfo;
      newImage.gpsInfo = _gpsInfo;
      imagesAddress.push(_imagesAddress);
    }
    else{
      blocks[_imagesAddress].confidences = _confidences;
      blocks[_imagesAddress].tags = _tags;
      blocks[_imagesAddress].imageInfo = _imageInfo;
      blocks[_imagesAddress].gpsInfo = _gpsInfo;
    }
  }

  function getAllAddress() public view returns (string[] memory){
    return imagesAddress;
  }

  function getByAddress(string memory _address) public view returns (
    uint[] memory,
    string[] memory,
    string  memory,
    string memory
  ){
    return (
      blocks[_address].confidences,
      blocks[_address].tags,
      blocks[_address].imageInfo,
      blocks[_address].gpsInfo
    );
  }

  function length() public view returns (uint){
    return imagesAddress.length;
  }

  function contains(string memory _address) public view returns (bool){
    for(uint i = 0; i < length(); i++){
      if(compareStringsbyBytes(imagesAddress[i], _address)) return true;
    }
    return false;
  }

  function compareStringsbyBytes(string memory s1, string memory s2) public pure returns(bool){
    return keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
  }

}
