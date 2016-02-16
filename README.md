# Solitaire Chess 
*Strategic Skill Building Game*


## The Goal

Solitaire Chess is a single-player game where the objective is to capture the chess pieces until only one piece remains on the board.  The purpose of this program is to allow the computer to have a chance at being the player.  Given a setup of a chess board, defined by the board's dimension size and pieces, the computer will provide a solution to the setup (if one exists).


## Rules of the Game

1. Every move must result in a capture.
2. Pawns can be placed anywhere on the board. They may only move up the board by diagonally capturing another piece.
3. Pawns are not promoted when they reach the top rank (top row).
4. There is no "check" rule for the King.


## Setup

In your Mac OS X Terminal, navigate to a suitable location for cloning this repository (i.e. your workspace).

   ```
   git clone https://github.com/sshariff01/solitaire-chess.git
   ```


## Usage

1. In your Mac OS X Terminal, navigate to `<your_workspace>/solitaire-chess/bin`

2. Run the `solitaire-solver.rb` script to define a set up for the board by assigning a board dimension size (i.e. dimension size **4** for a **4x4** chess board) using the `-d` option, and assigning chess pieces to locations on the board using the available options for different piece types.
    * For help on how to define the types and positions of different pieces on the chess board, run `./solitaire-solver.rb --help`

3. After running the `solitaire-solver.rb` script, the program will either output a sequence of steps to arrive at a solution, or notify you if there is no solution for the provided setup.


## Example


## More About Solitaire Chess

Solitaire Chess was invented by Vesa Timonen, a software engineer living in Finland. His interests include puzzles, magic, programming, and woodworking. This is Vesa's second ThinkFun product; the first being the Aha Brainteaser, Rec-Tangle.