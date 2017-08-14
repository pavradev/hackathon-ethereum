pragma solidity ^0.4.0;

contract MovieRegistry {
    function getMovieOwner(string) returns (address){
    }

    function getMoviePrice(string) returns (uint) {
    }
}


contract OnlineCinema {

    address owner;
    address movieRegistryAddress;

    mapping (address => mapping(string => bool)) usersToPayedMovies;
    
    function OnlineCinema(address _movieRegistryAddress) {
        owner = msg.sender;
        movieRegistryAddress = _movieRegistryAddress;  
    }
    
    function kill() {
        if (msg.sender == owner) {
            selfdestruct(owner);
        }
    }

    function payForMovie(string _url) returns (bool) {
        MovieRegistry movieRegistry = MovieRegistry(movieRegistryAddress);

        if (usersToPayedMovies[msg.sender][_url]) {
            return true;
        }

        address movieOwner = movieRegistry.getMovieOwner(_url);

        if (movieOwner != address(0)) {
            uint moviePrice = movieRegistry.getMoviePrice(_url);
            if (msg.sender.balance >= moviePrice) {
                movieOwner.transfer(moviePrice);
                usersToPayedMovies[msg.sender][_url] = true;
                return true;
            }
        }
        return false;
    }
    
    function getMovieOwner(string _url) constant returns (address) {
        MovieRegistry movieRegistry = MovieRegistry(movieRegistryAddress);
        return movieRegistry.getMovieOwner(_url);
    }

    function canWatchMovie(string _url, address _address) constant returns (bool) {
        return usersToPayedMovies[_address][_url];
    }
    
}

