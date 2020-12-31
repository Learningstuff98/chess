import React from 'react';
import Tile from './Tile';

function Board() {

  const letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  const xValues = [1, 2, 3, 4, 5, 6, 7, 8];

  const yValues = [8, 7, 6, 5, 4, 3, 2, 1];

  const handleTile  = (y) => {
    let tiles = [];
    for(let i = 0; i < xValues.length; i++) {
      tiles.push(
        <Tile
          x={xValues[i]}
          y={y}
          letter={letters[i]}
        />
      );
    }
    return tiles;
  };

  const row = (y) => {
    return <div className="board-row">
      {handleTile(y)}
    </div>
  };

  const rows = yValues.map(y => {
    return row(y);
  });

  return rows;
}

export default Board;
