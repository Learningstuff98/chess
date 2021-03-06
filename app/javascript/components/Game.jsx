import React, { useState, useEffect } from 'react';
import consumer from "channels/consumer";
import Board from './Board';
import CapturedPieces from './CapturedPieces';
import PawnPromotionMenu from './PawnPromotionMenu';
import DisplayPlayer from './DisplayPlayer';
import VictoryStatement from './VictoryStatement';
import CurrentTurn from './CurrentTurn';
import Chat from './Chat';

function Game(props) {
  const [game, setGame] = useState(props.game);
  const [pieces, setPieces] = useState(props.pieces);
  const [selectedPiece, setSelectedPiece] = useState(null);
  const [promotionPiece, setPromotionPiece] = useState(null);
  const [comments, setComments] = useState(props.comments);

  useEffect(() => {
    handleWebSocketUpdates();
  });

  const handleWebSocketUpdates = () => {
    consumer.subscriptions.create({channel: "GameChannel"}, {
      received(data) {
        if(game.id === data.game.id) {
          if(data.pieces) {
            setPieces(data.pieces);
          }
          if(data.game) {
            setGame(data.game);
          }
          if(data.comments) {
            setComments(data.comments);
          }
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
    game={game}
    current_user={props.current_user}
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

  const chat = <Chat
    game={game}
    comments={comments}
    root_url={props.root_url}
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
    <br/><br/>
    {chat}
  </div>  
}

export default Game;
