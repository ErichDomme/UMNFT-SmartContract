// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LCNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

   // Contract version as bytes32
    bytes32 public immutable version;

    // Token Names
    mapping(uint256 => string) private _tokenNames;

    // Base IPFS URL
    string private baseTokenURI;

    // Mapping from token ID to IPFS URL
    mapping(uint256 => string) private _tokenURIs;

    // Mapping from token ID to IPFS Hash History
    mapping(uint256 => string[]) private _ipfsHashHistory;

    // Mapping from token ID to a whitelist of addresses
    mapping(uint256 => mapping(address => bool)) private _updateWhitelist;

    // Additional mapping to keep track of whitelisted addresses for each token
    mapping(uint256 => address[]) private _whitelistedAddresses;

    constructor() ERC721("UrbanMiningNFT", "UMNFT") Ownable(msg.sender) {
        baseTokenURI = "ipfs://";
        version = "1.0.0";
    }

    function mintNFT(address nftOwner, string memory name, string memory ipfsHash) public onlyOwner returns (uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(nftOwner, newItemId);
        _setTokenURI(newItemId, ipfsHash);
        _tokenNames[newItemId] = name;

        // Automatically add the nftOwner to the whitelist for this token
        _updateWhitelist[newItemId][nftOwner] = true;

        // Also add the contract owner to the whitelist
        _updateWhitelist[newItemId][owner()] = true;

        // Add all IPFS Hash to History
        _ipfsHashHistory[newItemId].push(ipfsHash);

        return newItemId;
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(ownerOf(tokenId) != address(0), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = string(abi.encodePacked(baseTokenURI, _tokenURI));
    }

    function getTokenName(uint256 tokenId) public view returns (string memory) {
        require(ownerOf(tokenId) != address(0), "ERC721Metadata: Name query for nonexistent token");
        return _tokenNames[tokenId];
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        require(ownerOf(tokenId) != address(0), "ERC721Metadata: URI query for nonexistent token");
        return _tokenURIs[tokenId];
    }

    function updateTokenURI(uint256 tokenId, string memory newIpfsHash) public {
        require(ownerOf(tokenId) == _msgSender() || getApproved(tokenId) == _msgSender() || isApprovedForAll(ownerOf(tokenId), _msgSender()) || _updateWhitelist[tokenId][_msgSender()],
                "Not owner, approved, or whitelisted");
        _setTokenURI(tokenId, newIpfsHash);
        _ipfsHashHistory[tokenId].push(newIpfsHash);
    }

    function getTokenURIHistory(uint256 tokenId) public view returns (string[] memory) {
        require(ownerOf(tokenId) != address(0), "Query for nonexistent token");

        //uint256 historyLength = _ipfsHashHistory[tokenId].length;
        //string[] memory uriHistory = new string[](historyLength);

        //for (uint256 i = 0; i < historyLength; i++) {
            //uriHistory[i] = string(abi.encodePacked(baseTokenURI, _ipfsHashHistory[tokenId][i]));
        //}

        return _ipfsHashHistory[tokenId];
    }

    function addToWhitelist(uint256 tokenId, address user) public onlyOwner {
        require(!_updateWhitelist[tokenId][user], "User already whitelisted");
        _updateWhitelist[tokenId][user] = true;
        _whitelistedAddresses[tokenId].push(user);
    }

    function removeFromWhitelist(uint256 tokenId, address user) public onlyOwner {
        require(_updateWhitelist[tokenId][user], "User not whitelisted");

        // Remove user from the update whitelist mapping
        _updateWhitelist[tokenId][user] = false;

        // Remove user from the whitelisted addresses array
        uint256 length = _whitelistedAddresses[tokenId].length;
        for (uint256 i = 0; i < length; i++) {
            if (_whitelistedAddresses[tokenId][i] == user) {
                _whitelistedAddresses[tokenId][i] = _whitelistedAddresses[tokenId][length - 1];
                _whitelistedAddresses[tokenId].pop();
                break;
            }
        }
    }

    function getAllWhitelisted(uint256 tokenId) public view returns (address[] memory) {
        return _whitelistedAddresses[tokenId];
    }
}