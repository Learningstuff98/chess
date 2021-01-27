import React from 'react';
import TripleDot from './TripleDot';

function Lobby(props) {

  const buildUrl = (game) => {
    return `${props.root_url}games/${game.id}`;
  };

  const getHostingColor = (game) => {
    if(game.host_as_white) {
      return 'white';
    }
    return 'black';
  };

  const getHostUserName = (game) => {
    if(game.as_white) {
      return game.as_white;
    }
    return game.as_black;
  };

  if(props.games.length === 0) {
    return <h4 className="green">
      <TripleDot
        message={"Waiting for someone to host a match"}
      />
    </h4>
  }

  return props.games.map((game) => {
    if(game.open) {
      return <h4 key={game.id}>
        <a className="green" href={buildUrl(game)}>
          {`${getHostUserName(game)} is hosting as ${getHostingColor(game)}.`}
          <br/>
          Click to join.
        </a>
      </h4>
    } else {
      return <h4 className="green">Closed</h4>
    }
  });
}

export default Lobby;
