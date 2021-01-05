import React, { useState } from 'react';
import Board from './Board';

function Game(props) {
  const [selectedPiece, setSelectedPiece] = useState(null);

  const board = <Board
    pieces={props.pieces}
    selectedPiece={selectedPiece}
    setSelectedPiece={setSelectedPiece}
    root_url={props.root_url}
  />

  return <div>
    {board}
  </div>  
}

export default Game;
