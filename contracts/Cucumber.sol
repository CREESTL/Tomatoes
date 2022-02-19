// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// An Upgradable version of ERC721 contract
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
// A ERC721 token that can be irreversibly burned
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
// Allows each contract to have an owner. By default - the owe who deploys it. Ownership can be
// transfered later.
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
// Provides counters that can only be incremented, decremented or reset.
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
// A base contract for any other proxy-upgradeable contracts
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
// An upgradeability mechanism designed for UUPS proxies
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";



contract Cucumber is 
    Initializable, 
    ERC721Upgradeable,
    OwnableUpgradeable,
    UUPSUpgradeable,
    ERC721BurnableUpgradeable {

    // Creating a counter for tokens' ids
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
        __ERC721Burnable_init();
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    /**
     *@notice Get the base URI to generate tokenURI
     */
    function _baseURI() internal view override returns (string memory) {
        // TODO change this one for the correct API
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

    /**
     * @reverts if the msg.sender is not authorized to upgrade the contract
     */
    function _authorizeUpgrade(address newImplementation) internal onlyOwner override {
        require(_msgSender() == owner(), "Only the owner is authorized to upgrade the contract!");
    }

}