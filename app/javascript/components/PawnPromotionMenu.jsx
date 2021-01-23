import React, { useState, useEffect } from 'react';
import axios from 'axios';

function PawnPromotionMenu(props) {
  const [menuShowStatus, setMenuShowStatus] = useState(false);
  const [piece, setPiece] = useState(null);

  useEffect(() => {
    detectPawn();
    if(menuShowStatus) {
      $('#staticBackdrop').modal('show')
    } else {
      $('#staticBackdrop').modal('hide')
    }
  });

  const detectPawn = () => {
    for(const piece of props.pieces) {
      if(piece.piece_type === "pawn") {
        if(piece.y === 8 || piece.y === 1) {
          if(piece.in_play) {
            setMenuShowStatus(true);
            setPiece(piece);
            return;
          }
        }
      }
    }
    setMenuShowStatus(false);
    setPiece(null);
  };

  const handleSelection = (pieceType, icon) => {
    axios.patch(`${props.root_url}pieces/${piece.id}`, {
      piece_type: pieceType,
      icon: icon
    })
    .catch((err) => console.log(err.response.data));
  };

  return <div>

    <div className="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabIndex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div className="modal-dialog">
        <div className="modal-content">
          <div className="modal-header">
            <h5 className="modal-title green" id="staticBackdropLabel">You have a pawn that's eligible for promotion. Please make a selection.</h5>
          </div>
          <div className="promotion-options green">
            <div className="promotion-option cursor" onClick={() => handleSelection("queen", "♛")} data-dismiss="modal">♕</div>
            <div className="promotion-option cursor" onClick={() => handleSelection("rook", "♜")} data-dismiss="modal">♖</div>
            <div className="promotion-option cursor" onClick={() => handleSelection("bishop", "♝")} data-dismiss="modal">♗</div>
            <div className="promotion-option cursor" onClick={() => handleSelection("knight", "♞")} data-dismiss="modal">♘</div>
          </div>
        </div>
      </div>
    </div>

  </div>
}

export default PawnPromotionMenu;
