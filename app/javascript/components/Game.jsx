import React, { useState, useEffect } from 'react';
import consumer from "channels/consumer";
import Board from './Board';

function Game(props) {
  const [game, setGame] = useState(props.game);
  const [pieces, setPieces] = useState(props.pieces);
  const [selectedPiece, setSelectedPiece] = useState(null);

  useEffect(() => {
    handleWebSocketUpdates();
  });

  const handleWebSocketUpdates = () => {
    consumer.subscriptions.create({channel: "GameChannel"}, {
      received(data) {
        if(game.id === data.game.id) {
          setPieces(data.pieces);
        }
      }
    });
  };

  const board = <Board
    pieces={pieces}
    selectedPiece={selectedPiece}
    setSelectedPiece={setSelectedPiece}
    root_url={props.root_url}
  />

  return <div>
    {board}
  </div>  
}

export default Game;
