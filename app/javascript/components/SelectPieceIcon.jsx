function SelectPieceIcon(props) {
  let icon = "";
  switch (props.piece_type) {
    case "pawn":
      icon = "♙";
      break;
    case "knight":
      icon = "♞";
      break;
    case "bishop":
      icon = "♝";
      break;
    case "rook":
      icon = "♜";
      break;
    case "queen":
      icon = "♛";
      break;
    case "king":
      icon = "♚";
      break;
  }
  return icon;
}

export default SelectPieceIcon;
