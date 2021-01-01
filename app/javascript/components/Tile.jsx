import React from 'react';

function Tile(props) {

  const handleColor = () => {
    if(props.y % 2 !== 0 && props.x % 2 !== 0) {
      return "dark";
    }
    if(props.y % 2 === 0 && props.x % 2 === 0) {
      return "dark";
    }
    return "light";
  };

  return <div className={`tile tile-dimensions ${handleColor()}`}>

  </div>
}

export default Tile;
