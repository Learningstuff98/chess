import React from 'react';
import Tile from './Tile';

function Board() {

  const letterValues = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  const xValues = [1, 2, 3, 4, 5, 6, 7, 8];

  const yValues = [8, 7, 6, 5, 4, 3, 2, 1];

  const buildTile = (yValue, x) => {
    return <div key={yValue}>
      <Tile
        x={x}
        y={yValue}
        letter={letterValues[x - 1]}
      />
    </div>
  };

  const row = (x) => {
    return yValues.map((yValue) => {
      return buildTile(yValue, x);
    });
  };

  const rows = xValues.map(x => { // fix it. It's all backwards
    return <div key={x} className="board-row">
      {row(x)}
    </div>
  });

  return rows;
}

export default Board;
