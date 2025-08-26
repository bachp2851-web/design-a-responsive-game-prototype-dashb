pragma solidity ^0.8.0;

contract ResponsiveGamePrototypeDashboard {
    // Mapping of game prototype IDs to their corresponding data
    mapping(uint256 => GamePrototype) public gamePrototypes;

    // Game prototype struct
    struct GamePrototype {
        uint256 id;
        string name;
        string description;
        uint256[] scores;
        address[] players;
        uint256 gameMode; // 0: single player, 1: multi player
        uint256 difficultyLevel; // 0: easy, 1: medium, 2: hard
    }

    // Event emitted when a new game prototype is added
    event NewGamePrototype(uint256 id, string name, string description);

    // Event emitted when a player submits a score
    event ScoreSubmitted(uint256 gameId, address player, uint256 score);

    // Add a new game prototype
    function addGamePrototype(string memory _name, string memory _description, uint256 _gameMode, uint256 _difficultyLevel) public {
        uint256 newId = uint256(keccak256(abi.encodePacked(_name, _description)));
        gamePrototypes[newId] = GamePrototype(newId, _name, _description, new uint256[](0), new address[](0), _gameMode, _difficultyLevel);
        emit NewGamePrototype(newId, _name, _description);
    }

    // Submit a score for a game prototype
    function submitScore(uint256 _gameId, uint256 _score) public {
        GamePrototype storage game = gamePrototypes[_gameId];
        game.scores.push(_score);
        game.players.push(msg.sender);
        emit ScoreSubmitted(_gameId, msg.sender, _score);
    }

    // Get a game prototype by ID
    function getGamePrototype(uint256 _id) public view returns (GamePrototype memory) {
        return gamePrototypes[_id];
    }

    // Get all game prototypes
    function getAllGamePrototypes() public view returns (GamePrototype[] memory) {
        GamePrototype[] memory games = new GamePrototype[](gamePrototypes.length);
        for (uint256 i = 0; i < gamePrototypes.length; i++) {
            games[i] = gamePrototypes[i];
        }
        return games;
    }
}