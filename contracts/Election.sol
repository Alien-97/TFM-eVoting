pragma solidity 0.7.0;

contract Election{
    
    // Informacion del candidato: identificador, nombre y numero de votos
    struct Candidate{
        uint id;
        string name;
        uint votecount;
    }
    
    mapping(address => bool) public votedornot;
    
    mapping(uint => Candidate) public candidates;
    
    event electionupdates(uint indexed _candidateId);
          
    uint public candidatesCount;
        
    constructor() { // aqui se inicia la eleccion declarando los nombres de los candidatos
        addCandidate("Donald Trump");
        addCandidate("Joe Biden");
    }
    
    // añadir un candidato
    function addCandidate(string memory name) private{
        
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, name, 0);
    }
    
    function vote (uint _candidateId) public {
        
        // require that they haven't voted before
        require(!votedornot[msg.sender]); // nombre -> hasVoted, no está 
        
        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        
        // update candidate votecount
        candidates[_candidateId].votecount++;
        
        // record that voter has voted
        votedornot[msg.sender] = true;
        
        //trigger voted event
        emit electionupdates(_candidateId);
    }
}