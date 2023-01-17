Hello and welcome to my chess app!

Here I want to provide a tour of this app and give a bird's eye view of how it works.


Overview

This is a rails 6 app that uses devise for user functionality. Users can start games and choose which color that they want to play as, or they can join games in the lobby that are being hosted by other users. The rules of chess are enforced on the back end. The game is turn based, pieces can't jump over eachother except for knights and a victor can be declared. A real time chat box is included below the board.

![chessgif](https://user-images.githubusercontent.com/42154066/212790849-441d4765-a9e5-4642-9b13-ae0742c27cd5.gif)

![pawnpromotion](https://user-images.githubusercontent.com/42154066/212790878-9f03e3c8-cda3-4c58-8c8c-d34030e61c6c.gif)

Back end

Games belong to users. Pieces and comments belong to games. Games contain functionality for things like creating the pieces with their starting positions and determining the victor. Pieces contain logic for things like how a piece is allowed to move given what type of piece that it is, whether or not another piece is in the way and if a proposed capture is friendly/illegal.

When a piece is selected and a tile is clicked, this sends a patch request to the back end. Pieces have x and y attributes along with destination_x and destination_y attributes. The logic around piece movement is based on the starting point (x and y attributes) and the proposed destination (destination_x and destination_y attributes). If a proposed move is legal then the x and y attributes are updated and a broadcast is sent with action cable to the front end with the game and its pieces.

This project uses both Rspec and Factorybot for testing. I have tests written for both models and controllers. The controller tests can be found here. The model tests can be found here.


Front end

This app uses out of the box rails html.erb views along with React.js when necessary thanks to the react rails gem. The chess board, chat and the lobby all use react along with action cable to function. When a broadcast from the back end is recieved, the data is then loaded into state.

![lobbygif](https://user-images.githubusercontent.com/42154066/212790909-5d328d23-9a63-4ee7-bb31-5e8efad1a72f.gif)

The chess board and chat box work for different screen sizes.
