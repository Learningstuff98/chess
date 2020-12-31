import React from 'react';
import Tile from './Tile';

function Board() {

  const letterValues = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  const xValues = [1, 2, 3, 4, 5, 6, 7, 8];

  const yValues = [8, 7, 6, 5, 4, 3, 2, 1];

  const buildTile = (xValue, index, y) => {
    return <div key={xValue}>
      <Tile
        x={xValue}
        y={y}
        letter={letterValues[index]}
      />
    </div>
  };

  const row = (y) => {
    return xValues.map((xValue, index) => {
      return buildTile(xValue, index, y);
    });
  };

  const rows = yValues.map(y => {
    return <div key={y} className="board-row">
      {row(y)}
    </div>
  });

  return rows;
}

export default Board;
