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

void setup() 
{
  size(1000, 700);
  // BG Image must be same size as window. 
  background = loadImage("bg.jpg");
  kbController = new KeyboardController(this);
  soundPlayer = new SoundPlayer(this);  

  // register the function (pre) that will be called
  // by Processing before the draw() function. 
  registerMethod("pre", this);

  gameLevel = new StartLevel(this);
  gameLevel.start();
}

// Executed before each next frame is drawn. 
void pre() 
{
  gameLevel.update();
  nextLevelStateMachine();
}

// Determine the next GameLevel to play
void nextLevelStateMachine()
{
  GameState state = gameLevel.getGameState();

  if (gameLevel instanceof StartLevel) {
    if (state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new AsteroidsLevel1(this);
      gameLevel.start();
    }
  }
  else if(gameLevel instanceof AsteroidsLevel1) {
    if(state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new AsteroidsLevel2(this);
      //gameLevel = new WinLevel(this);
      gameLevel.start();
    }
    else if(state == GameState.Lost) {
      gameLevel.stop();
      gameLevel = new LoseLevel(this);
      gameLevel.start();
    }
  }
  else if(gameLevel instanceof AsteroidsLevel2) {
    if(state == GameState.Finished) {
      gameLevel.stop();
      gameLevel = new WinLevel(this);
      gameLevel.start();
    }
    else if(state == GameState.Lost) {
      gameLevel.stop();
      gameLevel = new LoseLevel(this);
      gameLevel.start();
    }
  }
}

void keyPressed() 
{
  gameLevel.keyPressed();
}

void draw() 
{
  // Background image must be same size as window. 
  background(background);

  S4P.updateSprites(stopWatch.getElapsedTime());

  S4P.drawSprites();
  gameLevel.drawOnScreen();
}
