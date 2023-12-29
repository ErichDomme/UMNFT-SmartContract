<h1 align="center">
  <a name="logo"><img src="img\icon_nft.svg" alt="UMNFT" width="300"></a>
  <br>
  Urban Mining NFT 
  - UMNFT - <br>
  PART 02 <br>
  Smart Contract
</h1>

<div align="center"></div>

<p><font size="3">
This project was developed during my Master Thesis at RWTH Aachen University. This Extension is one . </p>

## General Information
The second phase of this work focuses on the Smart Contract, which can be seen as the core and most significant part of the entire project, yet in the final product, it functions as an invisible, back-end mechanism, akin to a black box. A Smart Contract is a self-executing contract with terms of the agreement written in code. Once these terms are met, the corresponding actions are executed automatically.

In this phase, it is decided what functions the Smart Contract should have and how they should be used. It is important to consider the requirements of the next section, the website, as that is where user interaction with the Smart Contract will occur. A key aspect is the Non-Fungible Token (NFT) itself. Along with typical queries such as the NFT name, abbreviation, and IPFS referencing, the NFT is equipped with additional functions. This is to ensure that it serves as a reliable and sole source of certain information in the future.

The UMNFT Smart Contract is written in Solidity, a language for Ethereum Smart Contracts, and uses OpenZeppelin's ERC721 standard implementation, making it an NFT Smart Contract. The contract includes several functions and structures, which are explained below.

### Constructor and Basic Properties
Constructor:<br>
Upon deployment of the Smart Contract, the constructor is called. Here, the NFT's name is set as "UrbanMiningNFT" and the symbol as "UMNFT". The contract owner is defined as the person who deploys the contract.<br>
Version:<br>
The Smart Contract has a fixed version, set here as "1.0.0".<br>
Base Token URI:<br>
The base URL for the tokens, set here to "ipfs://", indicating that the NFT metadata is stored on the InterPlanetary File System (IPFS).<br>

### Mappings and Variables
_tokenIds:<br>
A counter for the token IDs to uniquely identify each NFT.<br>
_tokenNames:<br>
A mapping of token ID to the name of the token.<br>
_tokenURIs:<br>
A mapping of token ID to its IPFS URL.<br>
_ipfsHashHistory:<br>
Stores the history of IPFS hashes for each token.<br>
_updateWhitelist:<br>
A two-tier mapping structure that specifies which addresses are authorized to update the token URI.<br>
_whitelistedAddresses:<br>
A list of addresses that have been added to the update whitelist for each token.<br>

### Functions
mintNFT:<br>
This function allows the contract owner to create (mint) a new NFT. A new token ID is generated, the token is minted, its URI is set, and both the NFT owner and the contract owner are automatically added to the whitelist for this token.<br>
_setTokenURI:<br>
An internal function that sets the URI of a token.<br>
getTokenName, getTokenURI:<br>
Public functions to query the name or URI of a token.<br>
updateTokenURI:<br>
Allows the token owner or an authorized address to update the URI of a token.<br>
getTokenURIHistory:<br>
Returns the history of IPFS hashes for a specific token.<br>
addToWhitelist, removeFromWhitelist:<br>
Enable the contract owner to add or remove addresses from the whitelist.<br>
getAllWhitelisted:<br>
Returns all addresses that have been added to the whitelist for a specific token.<br>

### Internal Processes and Queries
Checks:<br>
Many functions contain security checks to ensure that only authorized users can perform certain actions.<br>
Automated Whitelist Update:<br>
When minting a new token, both the owner and the contract owner are automatically added to the whitelist for this token.<br>
IPFS Hash History:<br>
Every update of the token URI is stored in the IPFS hash history, ensuring transparency and traceability.<br>
In summary, this Smart Contract enables the creation, management, and tracking of NFTs that are based on the Ethereum blockchain and have their metadata stored on IPFS. It offers features for minting NFTs, updating their information, managing access rights, and tracking their history.<br>

## Project Status
<span style="color:green">**Version 0.0.1 published!**</span>
<!-- _complete_ / _no longer being worked on_. If you are no longer working on it, provide reasons why.-->

## Acknowledgements
Without these people and their projects, UMNFT would not have been possible:

## Contact
Created by [Erich Domme](mailto:erich.domme@rwth-aachen.de) - feel free to contact me!