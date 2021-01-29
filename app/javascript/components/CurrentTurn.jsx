import React from 'react';

function CurrentTurn(props) {
  return <div className="green container">
    <div className="turn-info">
      {`It's currently ${props.game.as_white}'s turn`}
    </div>
  </div>
}

export default CurrentTurn;
