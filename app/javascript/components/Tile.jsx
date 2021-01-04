import React from 'react';

function Tile(props) {

  const handlePieceIcon = () => {
    if(props.piece) {
      return <div className={`${props.piece.color}-icon icon-size cursor`}>
        {props.piece.icon}
      </div>
    }
  };

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
    {handlePieceIcon()}
  </div>
}

export default Tile;
