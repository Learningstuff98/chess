import React from 'react';
import Tile from './Tile';

function Board() {

  const tileNumbers = [0, 1, 2, 3, 4, 5, 6, 7];

  const row = (rowNumber) => {
    return <div className="board-row">
      {tileNumbers.map((columnNumber) => {
        return <Tile
          rowNumber={rowNumber}
          columnNumber={columnNumber}
        />
      })}
    </div>
  };

  const rows = tileNumbers.map((rowNumber) => {
    return row(rowNumber);
  });

  return rows;
}

export default Board;
