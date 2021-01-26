import React from 'react';

function DisplayPlayer(props) {

  const whiteUserName = () => {
    if(props.game.as_white) {
      return `White: ${props.game.as_white}`;
    }
    return "Waiting for someone to join";
  };

  const blackUserName = () => {
    if(props.game.as_black) {
      return `Black: ${props.game.as_black}`;
    }
    return "Waiting for someone to join";
  };

  const handleUserName = () => {
    if(props.color === "white") {
      return whiteUserName();
    }
    return blackUserName();
  };

  return <div className="container">
    <div className="green player-info">
      {handleUserName()}
    </div>
  </div>
}

export default DisplayPlayer;
