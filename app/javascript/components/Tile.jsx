import React from 'react';

function Tile(props) {
  return <div className="green tile">
    {props.rowNumber}
    {props.columnNumber}
  </div>
}

export default Tile;
