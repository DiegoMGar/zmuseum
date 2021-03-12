// contracts/ZArt.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ZArt is Ownable, ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint256 private _mintCost = 1;

    struct Art {
        string hash;
        string kb;
        uint256 price;
    }
    // uuid art id => pieza de arte
    mapping(uint256 => Art) private _artPieces;
    // address => amount of exhibitions
    mapping(uint256 => address) private _tokenApprovals;

    constructor() public ERC721("Ziguart Art Piece", "ZART") {}

    function burn(uint256 tokenId) public {
        require(ERC721.ownerOf(tokenId) == _msgSender(), "ERC721: burn of token that is not own");
        _burn(tokenId);
        if (bytes(_artPieces[tokenId].hash).length != 0) {
            delete _artPieces[tokenId];
        }
    }

    function mint(string memory hash, string memory kb, uint256 price, string memory tokenURI)
    public payable returns (uint256) {
        require(msg.value >= _mintCost);
        require(bytes(hash).length > 0);
        require(bytes(kb).length > 0);
        require(price > 0);
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(_msgSender(), newItemId);
        _setTokenURI(newItemId, tokenURI);
        _artPieces[newItemId] = Art(hash, kb, price);
        return newItemId;
    }
}

//Funciones públicas
//- Pedir enviar fondos al dueño del contrato.
//- Abrir exposición de arte.
//- Cambiar precio de abrir exposición de arte.
//- Poner a la venta pieza de arte.
//- Modificar precio de pieza de arte.
//- Retirar pieza de arte.
//- Comprar pieza de arte.
