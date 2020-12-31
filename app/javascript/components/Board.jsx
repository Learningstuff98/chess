import React from 'react';
import Tile from './Tile';

function Board() {

  const letterValues = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  const xValues = [1, 2, 3, 4, 5, 6, 7, 8];

  const yValues = [8, 7, 6, 5, 4, 3, 2, 1];

  const row = (y) => {
    let tiles = [];
    for(let valueIndex = 0; valueIndex < 8; valueIndex++) {
      tiles.push(<Tile
        x={xValues[valueIndex]}
        y={y}
        letter={letterValues[valueIndex]}
      />);
    }
    return tiles;
  };

  const rows = yValues.map(y => {
    return <div className="board-row">
      {row(y)}
    </div>
  });

  return rows;
}

export default Board;
