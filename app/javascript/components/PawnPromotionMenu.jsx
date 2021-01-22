import React, { useState, useEffect } from 'react';
import axios from 'axios';

function PawnPromotionMenu(props) {
  const [menuShowStatus, setMenuShowStatus] = useState(false);
  const [piece, setPiece] = useState(null);

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

  useEffect(() => {
    detectPawn();
    if(menuShowStatus) {
      $('#staticBackdrop').modal('show')
    } else {
      $('#staticBackdrop').modal('hide')
    }
  });

  const handleSelection = () => {
    axios.patch(`${props.root_url}pieces/${piece.id}`, {
      piece_type: "queen",
      icon: "♛"
    })
    .catch((err) => console.log(err.response.data));
  };

  return <div>

    <div className="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabIndex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div className="modal-dialog">
        <div className="modal-content">
          <div className="modal-header">
            <h5 className="modal-title" id="staticBackdropLabel">Modal title</h5>
          </div>
          <div className="modal-body">
            ...
      </div>
          <div className="modal-footer">
            <button onClick={() => handleSelection()} type="button" className="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

  </div>
}

export default PawnPromotionMenu;

// https://getbootstrap.com/docs/4.5/components/modal/