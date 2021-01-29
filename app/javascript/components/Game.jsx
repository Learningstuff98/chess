import React, { useState, useEffect } from 'react';
import consumer from "channels/consumer";
import Board from './Board';
import CapturedPieces from './CapturedPieces';
import PawnPromotionMenu from './PawnPromotionMenu';
import DisplayPlayer from './DisplayPlayer';
import VictoryStatement from './VictoryStatement';
import CurrentTurn from './CurrentTurn';

function Game(props) {
  const [game, setGame] = useState(props.game);
  const [pieces, setPieces] = useState(props.pieces);
  const [selectedPiece, setSelectedPiece] = useState(null);
  const [promotionPiece, setPromotionPiece] = useState(null);

  useEffect(() => {
    handleWebSocketUpdates();
  });

  const handleWebSocketUpdates = () => {
    consumer.subscriptions.create({channel: "GameChannel"}, {
      received(data) {
        if(game.id === data.game.id) {
          setPieces(data.pieces);
          setGame(data.game);
        }
      }
    });
  };

  const board = <Board
    pieces={pieces}
    selectedPiece={selectedPiece}
    setSelectedPiece={setSelectedPiece}
    root_url={props.root_url}
    promotionPiece={promotionPiece}
    game={game}
  />

  const capturedBlackPieces = <CapturedPieces
    pieces={pieces}
    color={"black"}
  />

  const capturedWhitePieces = <CapturedPieces
    pieces={pieces}
    color={"white"}
  />

  const pawnPromotionMenu = <PawnPromotionMenu
    pieces={pieces}
    root_url={props.root_url}
    promotionPiece={promotionPiece}
    setPromotionPiece={setPromotionPiece}
  />

  const asBlack = <DisplayPlayer
    current_user={props.current_user}
    game={game}
    color={"black"}
  />

  const asWhite = <DisplayPlayer
    current_user={props.current_user}
    game={game}
    color={"white"}
  />

  const victoryStatement = <VictoryStatement
    game={game}
  />

  const currentTurn = <CurrentTurn
    game={game}
  />

  return <div>
    {pawnPromotionMenu}
    {victoryStatement}
    {capturedWhitePieces}
    <br/>
    {asBlack}
    <br/>
    {currentTurn}
    <br/>
    {board}
    <br/>
    {currentTurn}
    <br/>
    {asWhite}
    <br/>
    {capturedBlackPieces}
  </div>  
}

export default Game;
