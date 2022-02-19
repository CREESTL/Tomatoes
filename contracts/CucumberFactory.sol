// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./ICucumberFactory.sol";
import "./Cucumber.sol";


// TODO it was made from OpenSea Creature Factory - but we I dont need OpenSea anymore
// TODO reformat code
contract CucumberFactory is FactoryERC721, Ownable {
    using Strings for string;

    event Transfer(
        address indexed from,
        address indexed to
    );

    // this is a mapping(address => OwnableDelegateProxy)
    address public proxyRegistryAddress;
    address public nftAddress;
    string public baseURI = "https://api.raid.party/metadata/hero/";

    // Only 1000 cucumbers can exist
    uint256 CUCUMBER_SUPPLY = 1000;

    // Just initialize addresses - no need to create an contract here
    constructor(address _proxyRegistryAddress, address _nftAddress) {
        proxyRegistryAddress = _proxyRegistryAddress;
        nftAddress = _nftAddress;

        emit Transfer(address(0), owner());
    }

    function name() override external pure returns (string memory) {
        return "CucumberFactory";
    }

    function symbol() override external pure returns (string memory) {
        return "CCMBRFCTR";
    }

    function supportsFactoryInterface() override public pure returns (bool) {
        return true;
    }

    function transferOwnership(address newOwner) override public onlyOwner {
        address _prevOwner = owner();
        super.transferOwnership(newOwner);
        emit Transfer(_prevOwner, newOwner);
    }

    function mint(address _toAddress) public {
        // ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
        // assert(
        //     address(proxyRegistry.proxies(owner())) == _msgSender() ||
        //         owner() == _msgSender()
        // );

        Cucumber cucumber = Cucumber(nftAddress);
        cucumber.safeMint(_toAddress);
    }


    function baseTokenURI(uint256 _optionId) external view returns (string memory) {
        return string(abi.encodePacked(baseURI, Strings.toString(_optionId)));
    }

    /**
     * Hack to get things to work automatically on OpenSea.
     * Use transferFrom so the frontend doesn't have to worry about different method names.
     */
    function transferFrom(
        address,
        address _to
    ) public {
        mint(_to);
    }

}
