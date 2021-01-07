import React from 'react';

function CapturedPieces(props) {

  const getCapturedPieces = props.pieces.filter(piece =>
    !piece.in_play && piece.color === props.color
  );

  const icons = getCapturedPieces.map((piece) => {
    return <div className={`${props.color}-icon`} key={piece.id}>
      {piece.icon}
    </div>
  });

  return <div className="container capture-box capture-box-dimensions captured-pieces">
    {icons}
  </div>
}

export default CapturedPieces;
