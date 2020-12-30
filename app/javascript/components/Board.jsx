import React from 'react';
import Tile from './Tile';

function Board() {

  const tileNumbers = [1, 2, 3, 4, 5, 6, 7, 8];

  const row = <div className="board-row">
    {tileNumbers.map(() => {
      return <Tile/>
    })}
  </div>

  const rows = tileNumbers.map(() => {
    return row;
  });

  return rows;
}

export default Board;
