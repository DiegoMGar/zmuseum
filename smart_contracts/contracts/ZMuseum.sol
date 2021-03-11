// contracts/ZMuseum.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ZMuseum is Ownable {
    uint exhibitionCost = 1;

    struct Art {
        string hash;
        string kb;
        string owner;
        uint price;
    }
    // uuid art id => pieza de arte
    mapping(string => Art) public artCollection;
    // address => amount of exhibitions
    mapping(address => uint8) public artExhibitions;

    function buyExhibition() public {
        artExhibitions[msg.sender]++;
    }

    function addArtPiece(string memory uuid, string memory hash, string memory kb, uint price) public {
        Art memory artPiece = artCollection[uuid];
        require(keccak256(bytes(artPiece.hash)) == keccak256(bytes("")));
        artCollection[uuid] = Art(hash, kb, price);
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
