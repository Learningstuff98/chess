import React from 'react';

function CurrentTurn(props) {

  const turnHolder = () => {
    if(props.game.whites_turn) {
      if(props.game.as_white) {
        return props.game.as_white;
      }
      return "white";
    }
    if(props.game.as_black) {
      return props.game.as_black;
    }
    return "black";
  };

  return <div className="green container">
    <div className="turn-info">
      {`It's currently ${turnHolder()}'s turn`}
    </div>
  </div>
}

export default CurrentTurn;
