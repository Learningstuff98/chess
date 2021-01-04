import React from 'react';
import Board from './Board';

function Game(props) {

  const board = <Board
    pieces={props.pieces}
  />

  return <div>
    {board}
  </div>  
}

export default Game;
