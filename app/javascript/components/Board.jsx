import React from 'react';
import Tile from './Tile';
import LetterTile from './LetterTile';
import NumberTiles from './NumberTiles';

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

  const column = (x) => {
    return yValues.map((yValue) => {
      return buildTile(yValue, x);
    });
  };

  const buildLetterTile = (x) => {
    return <LetterTile
      x={x}
      letterValues={letterValues}
    />
  };

  const columns = xValues.map(x => {
    return <div key={x}>
      {buildLetterTile(x)}
      {column(x)}
      {buildLetterTile(x)}
    </div>
  });

  const buildNumberTiles = <NumberTiles
    yValues={yValues}
  />

  return <div className="container">
    {buildNumberTiles}
    {columns}
    {buildNumberTiles}
  </div>
}

export default Board;
