// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * This is a generic factory contract that can be used to mint tokens while they are being purchased
 * in order to avoid pre-minting.
 */
interface FactoryERC721 {
    /**
     * @notice Returns the name of this factory.
     * @return string
     */
    function name() external view returns (string memory);

    /**
     * @notice Returns the symbol for this factory.
     * @return string
     */
    function symbol() external view returns (string memory);


    /**
     * @notice Returns a URL specifying some metadata about the option. This metadata can be of the
     * same structure as the ERC721 metadata.
     * @return string
     */
    function baseTokenURI(uint256 _optionId) external view returns (string memory);

    /**
     * @notice Indicates that this is a factory contract.
     * @return bool
     */
    function supportsFactoryInterface() external view returns (bool);

    /**
     * @notice Mints asset(s) in accordance to a specific address. This should be
     * callable only by the contract owner or the owner's Wyvern Proxy (later universal login will solve this).
     * Options should also be delineated 0 - (numOptions() - 1) for convenient indexing.
     * @param _toAddress address of the future owner of the asset(s)
     */
    function mint(address _toAddress) external;
}
