pragma experimental ABIEncoderV2;

contract patentContract {
    event Creation(
        address  from,
        string  vin
    );
    
    event Transfer(
        address  from,
        address  to,
        string  vin
    );
    
    struct Patent {
        string vin;
        address owner;
        string applicantsName;
        string inventor;
        string agentName;
        uint256 creationTime;
        string state;
        string addressPh;
        string inventionTitle;
        string website;
        string country;
        string patentNumberInCountry;
        string decisionDate;
        string patentNumberCertificate;
        string lawNumberState;
        string internationalClassification;
        string personResponsible;
        string detailsData;
        string isPrivate;
        

    }
    
    mapping (string => Patent) patents;
    string[] public inventors;
    address public owner = msg.sender;
    uint public creationTime = now;
    constructor() public {}
    
    
    modifier onlyBy(address _account) {
      require(
         msg.sender == _account,
         "Sender not authorized."
      );
      _;
    }
   
   function changeOwner(address _newOwner) public onlyBy(owner) {
      owner = _newOwner;
   }

    /**
     * Creates a track record of a new Patent. 
     * Transaction will fail (and burn gas!) if the Patent already exists.
     */
    function createPatent(string vin,string _applicantsName,string _agentName, string _inventor, string _state,string _addressPh, string _inventionTitle, string _website, string _country) public payable {
        require(msg.value >= 0.0095 * 10**18, "Minimal cost is 20 USD");
        assert(patents[vin].owner == 0x0);
        patents[vin] = Patent({
            vin: vin,
            owner: msg.sender,
            applicantsName:_applicantsName,
            agentName:_agentName,
            inventor:_inventor,
            creationTime:now,
            state:_state,
            addressPh:_addressPh,
            inventionTitle:_inventionTitle,
            website:_website,
            country:_country
        });
        inventors.push(vin);
        emit Creation(msg.sender, vin);
     
    }
    function creatpatentbyAdmin (string vin, address _owner,string _applicantsName,string _agentName, string _inventor, string _state,string _addressPh, string _inventionTitle, string _website, string _country) public onlyBy(owner) {
       assert(patents[vin].owner == 0x0);
        patents[vin] = Patent({
            vin: vin,
            owner: _owner,
            applicantsName:_applicantsName,
            agentName:_agentName,
            inventor:_inventor,
            creationTime:now,
            state:_state,
            addressPh:_addressPh,
            inventionTitle:_inventionTitle,
            website:_website,
            country:_country
        });
        inventors.push(vin);
        emit Creation(owner, vin);
    }

/**
    * Updates 
    */
    function updatePatentExtra(string vin, string _patentNumberInCountry, string _decisionDate, string _patentNumberCertificate, string _lawNumberState,string _internationalClassification,string _personResponsible) public {
        Patent storage patentObject = patents[vin];
        assert(patentObject.owner == msg.sender);
        patentObject.patentNumberInCountry =_patentNumberInCountry ;
        patentObject.decisionDate =_decisionDate ;
        patentObject.patentNumberCertificate =_patentNumberCertificate ;
        patentObject.lawNumberState =_lawNumberState ;
        patentObject.internationalClassification =_internationalClassification ;
        patentObject.personResponsible =_personResponsible ;
         
    }
    function updatePatentFiles(string vin, string _detailsData, string _isPrivate) public {
        Patent storage patentObject = patents[vin];
        assert(patentObject.owner == msg.sender);
        patentObject.detailsData =_detailsData;
        patentObject.isPrivate =_isPrivate;
         
    }
    
    function updatePatentinventor(string vin, string _inventor) public {
        Patent storage patentObject = patents[vin];
        assert(patentObject.owner == msg.sender);
        patentObject.inventor =_inventor ;
    }
    
    /**
     * Transfers the ownership of a Patent to a different address. 
     * Transaction fails and burns gas if the Patent is not owned by the caller or if the kilometers are 
     * less than the last known state. 
     */
    function transferOwnership(string vin, address _owner) public {
        Patent storage transferObject = patents[vin];
        assert(transferObject.owner == msg.sender); 
        transferObject.owner = _owner;
        emit Transfer(msg.sender, _owner, vin);
    }
    
    /**
     * Returns the current data of the given Patent
     */
    function getPatent(string vin) public view returns(Patent memory) {
        return patents[vin];
    }
    
    
    function getPatents() public view returns (Patent[] memory) {
        Patent[] memory patentss = new Patent[](inventors.length);
        for (uint256 i = 0; i < inventors.length; i++) {
            patentss[i] = patents[inventors[i]];
        }
        return patentss;
    }
    
     function getBalance() public view onlyBy(owner) returns (uint256)  {
        return address(this).balance;
    }
    
    function withdrawTo(address to, uint256 amount)  public  onlyBy(owner) returns (bool) {
        require(
            address(this).balance >= amount,
            "not enough funds to withdraw"
        );
        to.transfer(amount);
        return true;
    }
    
}