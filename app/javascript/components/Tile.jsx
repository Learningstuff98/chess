import React from 'react';

function Tile(props) {
  return <div className="green tile">
    {`x: ${props.x}`}
    <br/>
    {`y: ${props.y}`}
  </div>
}

export default Tile;
