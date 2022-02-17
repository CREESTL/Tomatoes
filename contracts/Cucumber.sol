// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";


contract Cucumber is Initializable, ERC721Upgradeable, OwnableUpgradeable, UUPSUpgradeable {
    using CountersUpgradeable for CountersUpgradeable.Counter;

    CountersUpgradeable.Counter private _tokenIdCounter;

    /**
     *@notice Do not leave contract uninitialized 
     */
    constructor() initializer {}

    /**
     * @notice Disable running costructor multiple times
     */
    function initialize() initializer public {
        // Call all parent initializers
        __ERC721_init("Cucumber", "CCMBR");
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    /**
     *@notice Get the URI of metadata
     */
    function baseTokenURI() internal pure returns (string memory) {
        return "https://api.raid.party/metadata/hero/";
    }

    /**
     * @notice Mints and transfers tokens to 'to'
     * @param to address for token to be transfered to
     */
    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function _authorizeUpgrade(address newImplementation) internal onlyOwner override {}

}