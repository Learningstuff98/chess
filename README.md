Hello and welcome to my chess app!

Here I want to provide a tour of this app and give a bird's eye view of how it works along with some information about myself.

About me

I origionally graduated from a bootcamp that taught Ruby on Rails. Since I graduated I've continued learning and imporving my programming skills. I've also made open source contributions to both the Ruby for Good Casa and Human Essentials applications.

So about this chess app. It's the result of a large amount of self learning. For example when I graduated I had never heard of websocket protocal which this project uses for its real time functionality. I had to do quite a bit of reaearch to learn how to set this up with rails. Also I had to do a good deal of practice/research with React for the piece movement and chat.

Since I completed this project, I've continued programming which resulted in me gaining more skill so I recently did some refactoring for the backend. I gained an appreciation for the Rubocop gem when I made the before mentioned open source contributions to the Ruby for Good applications, so I added it to this project. I removed redundant self statements, made the code more declarative, and got far more comfortable letting the tests that I wrote guide me in the refactor process. [Here's](https://github.com/Learningstuff98/chess/pull/26/files) a merged pull request from the refactor.

In September of 2023 I merged a PR that moved the logic responsible for piece movement and detecting any pieces that are blocking a given path into their own modules for the sake of learning and maintainability. This was the first time that I've used modules with rails. [Here's the PR.](https://github.com/Learningstuff98/chess/pull/29/files)

In October of 2023 I merged a PR that adds event messages that render in real time above the board. These messages describe game events like piece movement, piece capturing and if an illegal jump over is attempted. [Here's the PR.](https://github.com/Learningstuff98/chess/pull/30/files)

Overview

This is a rails 6 app that uses devise for user functionality. Users can start games and choose which color that they want to play as, or they can join games in the lobby that are being hosted by other users. The rules of chess are enforced on the back end. The game is turn based, pieces can't jump over eachother except for knights and a victor can be declared.


![](https://github.com/Learningstuff98/chess/blob/master/app/assets/images/updatedchess.gif)


A real time chat box is included below the board.


![](https://github.com/Learningstuff98/chess/blob/master/app/assets/images/chat.gif)


Back end

Games belong to users. Pieces and comments belong to games. Games contain functionality for things like creating the pieces with their starting positions and determining the victor. Pieces call on modules which contain logic for things like how a piece is allowed to move and whether or not another piece is in the way.

When a piece is selected and a tile is clicked, this sends a patch request to the back end. Pieces have x and y attributes along with destination_x and destination_y attributes. The logic around piece movement is based on the starting point (x and y attributes) and the proposed destination (destination_x and destination_y attributes). If a proposed move is legal then the x and y attributes are updated and a broadcast is sent with action cable to the front end with the game and its pieces.

![pawnpromotion](https://user-images.githubusercontent.com/42154066/212790878-9f03e3c8-cda3-4c58-8c8c-d34030e61c6c.gif)

This project uses both Rspec and Factorybot for testing. I have tests written for models, modules and controllers, github links provided below:

[requests](https://github.com/Learningstuff98/chess/tree/master/spec/requests)

[models](https://github.com/Learningstuff98/chess/tree/master/spec/models)

[modules](https://github.com/Learningstuff98/chess/tree/master/spec/helpers)


Front end

This app uses out of the box rails html.erb views along with React.js when necessary thanks to the react rails gem. The chess board, chat and the lobby all use react along with action cable to function. When a broadcast from the back end is recieved, the data is then loaded into state.

![lobbygif](https://user-images.githubusercontent.com/42154066/212790909-5d328d23-9a63-4ee7-bb31-5e8efad1a72f.gif)

The chess board and chat box work for different screen sizes.

What I would do differently

I would break the piece model up into seperate models like rook, queen, pawn ect. I would move logic that would need to be shared by some of the models like rooks and queens to their own modules.
