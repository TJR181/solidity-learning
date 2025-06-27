// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage{
    uint256 public favoriteNumber = 817;

    function store(uint256 _favoriteNumber) public{
        favoriteNumber = _favoriteNumber;
    }
    // viev means not alter the content of var , just know how much is it
    // pure means it can't use any vars inside the function body
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    function add(uint256 _num1 , uint256 _num2) public pure returns(uint256){
        return (_num1 + _num2);
    }

}