// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage{
    uint256 myFavoriteNumber = 817;
    uint256[] public listOfFacoriteNumbers = [1,2,3,4,5];
    
    struct Person{
        uint256 favoriteNumber;
        string name;
    }
    
    Person public myFriend = Person(9,"River");

    Person public anotherFriend = Person({
        favoriteNumber: 6,
        name: "John"
    });

    mapping(string => uint256) public nameToFavoriteNumber;

    // dynamic array
    Person[] public listOfPeople;

    function store(uint256 _favoriteNumber) public{
        myFavoriteNumber = _favoriteNumber;
    }
    // viev means not alter the content of var , just know how much is it
    // pure means it can't use any vars inside the function body
    function retrieve() public view returns(uint256){
        return myFavoriteNumber;
    }
    // memory , stroge and calldata
    // Memory and calldata are both temporary variables
    // The main difference between memory and calldata is that you can modify the memory variable inside the function
    // but the calldata variable cannot be manipulated
    // Storage is a permanent variable that can be modified.
    function addPerson(uint256 _favoriteNumber , string memory _name) public{
        Person memory newPerson = Person({
            favoriteNumber: _favoriteNumber,
            name: _name
        });
        listOfPeople.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}