// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title SupplyChainContract
 * @dev Manages the supply chain of items with secure ownership and state management.
 */
contract SupplyChainContract is Ownable {
    uint256 private itemCount;

    struct Item {
        uint256 id;
        string name;
        string description;
        string status;
        uint256 timestamp;
    }

    mapping(uint256 => Item) private items;

    event ItemAdded(uint256 itemId, string name, string description);
    event ItemUpdated(uint256 itemId, string status);
    event OwnershipTransferred(address newOwner);

    /**
     * @dev Adds a new item to the supply chain.
     * @param name Name of the item.
     * @param description Description of the item.
     */
    function addItem(string memory name, string memory description) public onlyOwner {
        uint256 newItemId = itemCount++;
        items[newItemId] = Item(newItemId, name, description, "Created", block.timestamp);
        emit ItemAdded(newItemId, name, description);
    }

    /**
     * @dev Updates the status of an existing item.
     * @param itemId ID of the item to update.
     * @param status New status of the item.
     */
    function updateItem(uint256 itemId, string memory status) public onlyOwner {
        require(itemId < itemCount, "Item does not exist.");
        items[itemId].status = status;
        emit ItemUpdated(itemId, status);
    }

    /**
     * @dev Retrieves an item by its ID.
     * @param itemId ID of the item to retrieve.
     * @return Item The requested item.
     */
    function getItem(uint256 itemId) public view returns (Item memory) {
        require(itemId < itemCount, "Item does not exist.");
        return items[itemId];
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public override onlyOwner {
        super.transferOwnership(newOwner);
        emit OwnershipTransferred(newOwner);
    }
}
