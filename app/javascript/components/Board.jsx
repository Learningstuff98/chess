import React from 'react';
import Tile from './Tile';

function Board() {

  const row = (y) => {
    return <div className="board-row">
      {[1, 2, 3, 4, 5, 6, 7, 8].map(x => {
        return <Tile
          x={x}
          y={y}
        />
      })}
    </div>
  };

  const rows = [8, 7, 6, 5, 4, 3, 2, 1].map(y => {
    return row(y);
  });

  return rows;
}

export default Board;
