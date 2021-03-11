pragma solidity ^0.4.19;

contract ZMuseum {
    uint exhibitionCost = 1;
    struct Art {
        string hash;
        string kb;
        uint price;
    }
    mapping (string => address) public ownership;            // uuid art id => address owner
    mapping (string => Art) public artCollection;            // uuid art id => pieza de arte
    mapping (address => uint) public artExhibitions;    // address => amount of exhibitions

    function buyExhibition() public {
        artExhibitions[msg.sender]++;
    }

    function addArtPiece(string uuid, string hash, string kb, uint price) public {
        require(artCollection[uuid] == null);
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
