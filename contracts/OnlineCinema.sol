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

    function buyMovie(string _url) payable {
        MovieRegistry movieRegistry = MovieRegistry(movieRegistryAddress);
        address movieOwner = movieRegistry.getMovieOwner(_url);
        uint moviePrice = movieRegistry.getMoviePrice(_url);

        require(!usersToPayedMovies[msg.sender][_url]);
        require(movieOwner != address(0));
        require(msg.sender.balance >= moviePrice);

        usersToPayedMovies[msg.sender][_url] = true;

        movieOwner.transfer(moviePrice);
    }

    function canWatchMovie(string _url, address _address) constant returns (bool) {
        return usersToPayedMovies[_address][_url];
    }
    
}

