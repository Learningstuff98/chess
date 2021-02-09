import React, { useEffect } from 'react';
import axios from 'axios';

function PawnPromotionMenu(props) {

  useEffect(() => {
    findPromotionPiece();
  });

  const findPromotionPiece = () => {
    for(const piece of props.pieces) {
      if(piece.piece_type === "pawn") {
        if(piece.y === 8 || piece.y === 1) {
          props.setPromotionPiece(piece);
          return;
        }
      }
    }
    props.setPromotionPiece(null);
  };

  const handleSelection = (pieceType, icon) => {
    axios.patch(`${props.root_url}pieces/${props.promotionPiece.id}`, {
      piece_type: pieceType,
      icon: icon
    })
    .catch((err) => console.log(err.response.data));
  };

  const isCorrectPlayer = () => {
    if(props.promotionPiece.color === "white") {
      return props.current_user.username === props.game.as_white;
    }
    if(props.promotionPiece.color === "black") {
      return props.current_user.username === props.game.as_black;
    }
  };

  if(props.promotionPiece && isCorrectPlayer()) {
    return <div className="promotion-menu-container">
      <div className="promotion-menu promotion-menu-placement">
        <div className="promotion-options green">
          <div className="promotion-option cursor" onClick={() => handleSelection("queen", "♛")} data-dismiss="modal">♕</div>
          <div className="promotion-option cursor" onClick={() => handleSelection("rook", "♜")} data-dismiss="modal">♖</div>
          <div className="promotion-option cursor" onClick={() => handleSelection("bishop", "♝")} data-dismiss="modal">♗</div>
          <div className="promotion-option cursor" onClick={() => handleSelection("knight", "♞")} data-dismiss="modal">♘</div>
        </div>
      </div>
    </div>
  }

  return null;
}

export default PawnPromotionMenu;
