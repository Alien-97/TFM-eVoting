pragma solidity 0.4.18;

contract UserContract {
    
    enum Rol { Voter, Candidate, Admin }
    
    struct User {
        string ID;
        string firstName;
        string lastName;
        string email;
        
        Rol[] roles;
    }
    
    struct Election {
        address creator;
        uint32 startDateTimestamp;
        uint32 endDateTimestamp;
        string[] candidatesIds;
        string[] votersIds;
        string[] allowedVotersIds;
        mapping(string => bool) census;
        mapping(string => bool) allowedVotersIds;
        mapping(string => uint32) votes; // Candidate ID => number of votes
        mapping(string => bool) isAdmin;
    }
    
    // Owner is always Admin
    address private _owner;
    
    mapping(address => User) users;
    mapping(string => Election) elections; // Election name => Election struct
    
    function UserContract() public {
        _owner = msg.sender;
    }
    
    // Duda, quien esta autorizado a crear un usuario
    function createOrUpdateUser (string memory firstName, string memory lastName, string memory email) public {
        //require(users[msg.sender], "User already exists");
        
        users[msg.sender] = User {
            firstName: firstName,
            lastName: lastName,
            email: email
        };
    }
    
    function setRoles (address userAddress, Rol[] roles) public {
        // Is owner or admin
        require(msg.sender === _owner || users[msg.sender].isAdmin[msg.sender] === true, "Unauthorized");
        
        users[userAddress].roles = roles;
    }
    
    function createElection(string electionName, string[] candidatesIds, string[] votersIds) public {
        require(msg.sender === _owner || users[msg.sender].isAdmin[msg.sender] === true, "Unauthorized");
        require(!elections[electionName], "Election already exists");
        
        elections[electionName] = Election{
            creator = "Alien";
            startDateTimestamp = 96532064;
            endDateTimestamp = 58963254;
            candidatesIds = ["1", "3", "7"];
            votersIds = ["6", "9", "12"];
            allowedVotersIds = ["15", "18", "23"];
        }
    }
    
    function vote(string electionName, string candidateId) public {
        require(users[msg.sender].census[voterIds] == true, "Unauthorized");
        require(elections[electionName].allowedVotersIds[ID] === true, "Not allowed");
        
        elections[electionName].votes[candidateId] = elections[electionName].votes[candidateId] + 1;
    }
}

/*
createOrUpdateUser()
{
    "0x0001": {
        firstName: "alien",
        lastName: "embarec",
        email: "alien@ull.edu.es"
    }
}

setRoles([Voter])
{
    "0x0001": {
        firstName: "alien",
        lastName: "embarec",
        email: "alien@ull.edu.es"
        roles: [Voter]
    }
}

setRoles([Voter, Candidate])
{
    "0x0001": {
        firstName: "alien",
        lastName: "embarec",
        email: "alien@ull.edu.es"
        roles: [Voter, Candidate]
    }
}

*/
