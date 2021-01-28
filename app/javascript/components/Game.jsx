import React, { useState, useEffect } from 'react';
import consumer from "channels/consumer";
import Board from './Board';
import CapturedPieces from './CapturedPieces';
import PawnPromotionMenu from './PawnPromotionMenu';
import DisplayPlayer from './DisplayPlayer';

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

  return <div>
    {pawnPromotionMenu}
    {capturedWhitePieces}
    <br/>
    {asBlack}
    <br/>
    {board}
    <br/>
    {asWhite}
    <br/>
    {capturedBlackPieces}
  </div>  
}

export default Game;
