pragma solidity ^0.4.0;
contract MovieRegistry {

    address owner;
    
    struct Movie {
        string url;
        uint price;
        address owner;
    }

    mapping(string => Movie) movieRegistry;

    function MovieRegistry() {
        owner = msg.sender;
    }

    function kill() {
        if(msg.sender == owner) {
            selfdestruct(owner);
        }
    }

    function publishMovie(uint _price, string _url){
        if(movieRegistry[_url].owner == address(0)) {
            movieRegistry[_url].owner = msg.sender;
            movieRegistry[_url].price = _price;
            movieRegistry[_url].url = _url;
        }
    }

    function getMovieOwner(string _url) returns (address){
        return movieRegistry[_url].owner;
    }

    function getMoviePrice(string _url) returns (uint) {
        return movieRegistry[_url].price;
    }

    function removeMovie(string _url) {
        if(movieRegistry[_url].owner == msg.sender) {
            delete movieRegistry[_url];
        }
    }
}
