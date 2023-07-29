import React from 'react';
import SelectPieceIcon from './SelectPieceIcon';

function CapturedPieces(props) {

  const getCapturedPieces = props.pieces.filter(piece =>
    !piece.in_play && piece.color === props.color
  );

  const icons = getCapturedPieces.map((piece) => {
    return <div className={`${props.color}-icon`} key={piece.id}>
      {<SelectPieceIcon piece_type={piece.piece_type} />}
    </div>
  });

  return <div className="container capture-box capture-box-dimensions captured-pieces">
    {icons}
  </div>
}

export default CapturedPieces;
