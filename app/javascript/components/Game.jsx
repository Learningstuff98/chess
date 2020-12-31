import React from 'react';
import Board from './Board';

function Game() {

  const board = <Board/>

  return <div className="container">
    {board}
  </div>  
}

export default Game;
