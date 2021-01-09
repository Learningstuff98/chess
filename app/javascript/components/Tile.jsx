import React from 'react';
import axios from "axios";

function Tile(props) {

  const handlePiece = () => {
    if(props.piece && !props.selectedPiece) {
      props.setSelectedPiece(props.piece);
    }
    if(props.selectedPiece) {
      movePiece();
    }
  };

  const movePiece = () => {
    axios.patch(`${props.root_url}pieces/${props.selectedPiece.id}`, {
      destination_x: props.x,
      destination_y: props.y
    })
    .then(() => props.setSelectedPiece(null))
    .catch((err) => console.log(err.response.data));
  };

  const handlePieceIcon = () => {
    if(props.piece) {
      return <div className={`${props.piece.color}-icon icon-size cursor no-highlights`}>
        {props.piece.icon}
      </div>
    }
  };

  const handleColor = () => {
    if(props.selectedPiece) {
      if(props.selectedPiece.x === props.x) {
        if(props.selectedPiece.y === props.y) {
          return "has-selected-piece";
        }
      }
    }
    if(props.y % 2 !== 0 && props.x % 2 !== 0) {
      return "dark";
    }
    if(props.y % 2 === 0 && props.x % 2 === 0) {
      return "dark";
    }
    return "light";
  };

  return <div onClick={() => handlePiece()} className={`tile tile-dimensions ${handleColor()}`}>
    {handlePieceIcon()}
  </div>
}

export default Tile;
