pragma solidity ^0.5.11

contract NoteBlock {

    struct Page {
        uint timeCreated;
        bytes32 sha3sum;
    }

    struct Notebook {
        Page[] pages;
        bool exists;
    }


    // mapping from address to list of codenames
    mapping(address => string[]) codenames;

    // mapping from addresss, codename to notebook
    mapping(address => mapping(string => Notebook)) notebooks;


    function createNotebook(string codename) public {
        require(!notebooks[msg.sender][codename].exists, "A notebook with that codename already exists.");
        codenames[msg.sender].push(codename);
        notebooks[msg.sender][codename].exists = true;
    }

    function createPage(string codename, bytes32 sha3sum) public {
        require(notebooks[msg.sender][codename].exists, "No notebook with that codename exists.");
        Page page;
        page.timeCreated = now;
        page.sha3sum = sha3sum;
        notebooks[msg.sender][codename].pages.push(page);
    }

    function numNotebooks(address addr) public view returns(uint) {
        return codenames[addr].length;
    }

    function getCodename(address addr, uint index) public view returns(string) {
        require(index < codenames[addr].length, "Index doesn't exist.");
        return codenames[addr][index];
    }

    function numPages(address addr, string codename) public view returns(uint) {
        require(notebooks[addr][codename].exists, "Notebook not found.");
        return notebooks[addr][codename].pages.length;
    }

    function getPage(address addr, string codename, uint index) public view returns(bytes32) {
        require(notebooks[addr][codename].exists, "Notebook not found.");
        require(index < notebooks[addr][codename].pages.length, "Page not found.");
        return notebooks[addr][codename].pages[index];
    }

}
