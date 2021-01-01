import React from 'react';

function LetterTile(props) {
  return <div className="letter-tile letter-tile-dimensions">
    {props.letterValues[props.x - 1]}
  </div> 
}

export default LetterTile;
