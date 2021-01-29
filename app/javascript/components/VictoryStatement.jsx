import React from 'react';

function VictoryStatement(props) {
  if(props.game.winner_username) {
    return <div className="green victory-statement-container">
      <div className="victory-statement-box victory-statement-dimensions center-winner-username">
        {`${props.game.winner_username} won`}
      </div>
    </div>
  }

  return null;
}

export default VictoryStatement;
