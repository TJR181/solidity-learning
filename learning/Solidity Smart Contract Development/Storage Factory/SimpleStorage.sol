// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStorage{
    uint256 myFavoriteNumber;

    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    Person[] listOfPeople;
    mapping(string => uint256) public nameToFavoriteNumber;

    // keyword virtual means you can override this function by inherit
    function store(uint256 _favoriteNumber) public virtual{
        myFavoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256){
        return myFavoriteNumber;
    }

    function addPerson(string memory _name , uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}

contract SimpleStorage2{}
contract SimpleStorage3{}
contract SimpleStorage4{}