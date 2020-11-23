/* This source code is copyrighted materials owned by the UT system and cannot be placed 
 into any public site or public GitHub repository. Placing this material, or any material 
 derived from it, in a publically accessible site or repository is facilitating cheating 
 and subjects the student to penalities as defined by the UT code of ethics. */

import sprites.*;
import sprites.utils.*;
import sprites.maths.*;
import java.util.*;
import java.util.concurrent.*;

GameLevel gameLevel;
PImage background;

KeyboardController kbController;
SoundPlayer soundPlayer;
StopWatch stopWatch = new StopWatch();

int playerOneRemainingLives;
int playerTwoRemainingLives;
CopyOnWriteArrayList<Image> P1lives = new CopyOnWriteArrayList<Image>();
CopyOnWriteArrayList<Image> P2lives = new CopyOnWriteArrayList<Image>();

final int YLivesOffset = 50;
final int XLivesOffset = 30;
final int space = 50;

int playerOneScore;
int playerTwoScore;

int winner;

void setup() {
  size(1000, 700);
  
  // BG Image must be same size as window. 
  background = loadImage("background.png");
  
  kbController = new KeyboardController(this);
  soundPlayer = new SoundPlayer(this);  
  // register the function (pre) that will be called
  // by Processing before the draw() function. 
  registerMethod("pre", this);
  
  playerOneRemainingLives = 3;
  playerTwoRemainingLives = 3;
  
  playerOneScore = 0;
  playerTwoScore = 0;
  
  gameLevel = new StartLevel(this);
  gameLevel.start();
}

// Executed before each next frame is drawn. 
void pre() {
  gameLevel.update();
  S4P.updateSprites(stopWatch.getElapsedTime()); 
  nextLevelStateMachine();
}

// Determine the next GameLevel to play
void nextLevelStateMachine(){
  GameState state = gameLevel.getGameState();

  if (gameLevel instanceof StartLevel) {
    int numOfPlayers = this.gameLevel.numOfPlayers;
    if (state == GameState.Finished) {
      gameLevel.stop();
      if (numOfPlayers == 1) {
        gameLevel = new AsteroidsLevel1(this);
      } else if (numOfPlayers == 2) {
        gameLevel = new AsteroidsLevel2(this);
      }
      gameLevel.start();
    }
  } else if (gameLevel instanceof AsteroidsLevel1) {
    if (state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new WinLevel(this);
      gameLevel.start();
    } else if (state == GameState.Lost) {
      gameLevel.stop();
      gameLevel = new LoseLevel(this);
      gameLevel.start();
    }
  } else if (gameLevel instanceof AsteroidsLevel2) {
    if (state == GameState.Finished) {
       gameLevel.stop();
       gameLevel = new WinLevel(this);
       gameLevel.start();
    } else if (state == GameState.Lost) {
       gameLevel.stop();
       gameLevel = new LoseLevel(this);
       gameLevel.start();
    }
  } else if (gameLevel instanceof WinLevel) {
    if (state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new StartLevel(this);
      gameLevel.start();
    }
  } else if (gameLevel instanceof LoseLevel) {
    if (state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new StartLevel(this);
      gameLevel.start();
    }
  }
}

void keyPressed() {
  gameLevel.keyPressed();
}

void mousePressed()
{
  gameLevel.mousePressed();
}

void draw() {
  // Background image must be same size as window. 
  background(background);
  S4P.drawSprites();
  gameLevel.drawOnScreen();
}
