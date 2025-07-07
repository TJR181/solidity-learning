// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";


contract StorageFactory{

    SimpleStorage[] public listOfSimpleStorage;

    function createSimpleStorageContract() public {
        listOfSimpleStorage.push(new SimpleStorage());
    }

    function sfStore(uint256 _simpleStorageIndex , uint256 _simpleStorageNumber) public {
        SimpleStorage mySimpleStorage = listOfSimpleStorage[_simpleStorageIndex];
        mySimpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 __simpleStorageIndex) public view returns (uint256){
        SimpleStorage mySimpleStorage = listOfSimpleStorage[__simpleStorageIndex];
        return mySimpleStorage.retrieve();
    }
    
}