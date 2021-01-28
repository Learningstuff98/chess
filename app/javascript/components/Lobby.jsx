import React, { useState, useEffect } from 'react';
import consumer from "channels/consumer";
import TripleDot from './TripleDot';

function Lobby(props) {
  const [lobbytokens, setLobbyTokens] = useState(props.lobbytokens);

  useEffect(() => {
    handleWebSocketUpdates();
  });

  const handleWebSocketUpdates = () => {
    consumer.subscriptions.create({channel: "LobbyChannel"}, {
      received(data) {
        setLobbyTokens(data.lobby_tokens);
      }
    });
  };

  const buildUrl = (lobbytoken) => {
    return `${props.root_url}games/${lobbytoken.game_id}`;
  };

  if(lobbytokens.length === 0) {
    return <h4 className="green">
      <TripleDot
        message={"Waiting for someone to host a match"}
      />
    </h4>
  }

  return lobbytokens.map((lobbytoken) => {
    return <h4 key={lobbytoken.id}>
      <a className="green" href={buildUrl(lobbytoken)}>
        {`Hosted by ${lobbytoken.host_username} as ${lobbytoken.host_color}.`}
        <br/>
        Click to join.
      </a>
    </h4>
  });
}

export default Lobby;
