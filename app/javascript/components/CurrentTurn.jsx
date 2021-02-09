import React from 'react';

function CurrentTurn(props) {

  const turnHolder = () => {
    if(props.game.whites_turn) {
      return props.game.as_white;
    }
    return props.game.as_black;
  };

  return <div className="green container">
    <div className="turn-info">
      {`It's currently ${turnHolder()}'s turn`}
    </div>
  </div>
}

export default CurrentTurn;
