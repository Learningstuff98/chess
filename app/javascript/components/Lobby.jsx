import React, { useState, useEffect } from 'react';
import consumer from "channels/consumer";
import TripleDot from './TripleDot';

function Lobby(props) {
  const [games, setGames] = useState(props.games);

  useEffect(() => {
    handleWebSocketUpdates();
  });

  const handleWebSocketUpdates = () => {
    consumer.subscriptions.create({channel: "LobbyChannel"}, {
      received(data) {
        setGames(data.games);
      }
    });
  };

  const buildUrl = (game) => {
    return `${props.root_url}games/${game.id}`;
  };

  if(games.length === 0) {
    return <h4 className="green lobby-message">
      <TripleDot
        message={"Waiting for someone to host a match"}
      />
    </h4>
  }

  const setLinkMessage = (game) => {
    if(game.host_as_white) {
      return `Hosted by ${game.as_white} as white. `
    } else {
      return `Hosted by ${game.as_black} as black. `
    }
  };

  return games.map((game) => {
    return <h4 key={game.id}>
      <a className="green" href={buildUrl(game)}>
        {setLinkMessage(game)}
        Click to join.
      </a>
    </h4>
  });
}

export default Lobby;
