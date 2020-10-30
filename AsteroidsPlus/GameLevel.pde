/* This source code is copyrighted materials owned by the UT system and cannot be placed 
into any public site or public GitHub repository. Placing this material, or any material 
derived from it, in a publically accessible site or repository is facilitating cheating 
and subjects the student to penalities as defined by the UT code of ethics. */

public enum GameState
{
  NotRunning, 
    Running, 
    Finished, 
    Lost;
}

/***********************************************/


abstract class GameLevel 
{
  PApplet game;
  GameState gameState; 
  int numOfPlayers = 0;

  GameLevel(PApplet applet)
  {
    this.game = applet;
    gameState = GameState.NotRunning;
  }

  GameState getGameState()
  {
    return gameState;
  }

  // Initialize all the resources needed by the level
  abstract void start();

  // Deallocate the resources maintained by the level
  abstract void stop();

  // Reinitialize the resources maintained by the level.
  abstract void restart();

  // Called every frame to update the resources maintained by the level.
  abstract void update();

  // Use raw Processing operations to draw on the screen.
  abstract void drawOnScreen();

  // Called when a key is pressed in the active level. 
  abstract void keyPressed();
  
  // Called when mouse button is pressed in the active level. 
  // Use Processing's builtin variables mouseX, mouseY, mouseButton
  abstract void mousePressed();
}


/*********************************************/


class StartLevel extends GameLevel
{
  StartButton singlePlayerButton;
  StartButton twoPlayerButton;
  Sprite logo;

  StartLevel(PApplet game)
  {
    super(game);
    gameState = GameState.NotRunning;
  }

  void start()
  {
    singlePlayerButton = new StartButton(game, width/2, height/2, 1, this, "onePlayerButton.png");
    twoPlayerButton = new StartButton(game, width/2, (height * 3)/4, 2, this, "twoPlayerButton.png");
    logo = new Sprite(game, "AsteroidsLogo.png", 70);
    logo.setXY(width/2, (height*3)/16);
    logo.setVelXY(0, 0);
    gameState = GameState.Running;
  }

  void stop()
  {
    logo.setDead(true);
    S4P.deregisterSprite(logo);
    singlePlayerButton.setDead();
    twoPlayerButton.setDead();
  }

  void restart()
  {
  }

  void update()
  {
  }

  GameState getGameState()
  {
    return gameState;
  }

  void drawOnScreen()
  {
  }

  void keyPressed()
  {
  }
  
  void mousePressed()
  {
    singlePlayerButton.activateIfPressed(mouseX, mouseY);
    twoPlayerButton.activateIfPressed(mouseX, mouseY);
    // Alternative method of activating a button...
    //if (startButton.isPressed(mouseX, mouseY)) {
    //  startButton.onPress();
    //}
  }
}

/*********************************************/


class LoseLevel extends GameLevel
{
  GameOver gameOver;
  StopWatch stopwatch;

  LoseLevel(PApplet applet)
  {
    super(applet);
  }

  void start()
  {
    gameOver = new GameOver(game, width/2, height/2);
    gameOver.setActive();
    stopwatch = new StopWatch();    
    soundPlayer.playGameOver();
    gameState = GameState.Running;
  }

  void stop()
  {
    gameOver.setInactive();
  }

  void restart()
  {
  }

  void update()
  {
    gameOver.update();
    if (stopwatch.getRunTime() < soundPlayer.gameOverPlayer.duration()) {
      gameState = GameState.Running;
    }
    else {
      gameState = GameState.Finished;
    }
  }

  void drawOnScreen()
  {
  }

  void keyPressed()
  {
  }
  
  void mousePressed()
  {
  }
}


/*********************************************/


class WinLevel extends GameLevel
{
  OhYea ohYea;
  Ship ship;
  float scale = 0;
  float scaleInc = .05;
  StopWatch stopwatch;

  WinLevel(PApplet applet)
  {
    super(applet);
  }

  void start()
  {
    stopwatch = new StopWatch();
    soundPlayer.playOhYea();

    ohYea = new OhYea(game, width/2, height/2);
    ohYea.setActive();
    
    if (winner == 1) {
      ship = new Ship(game, width/2, height/2, winner, "ship1.png");
    } else if (winner == 2) {
      ship = new Ship(game, width/2, height/2, winner, "ship2.png");
    }
    
    gameState = GameState.Running;
  }

  void stop()
  {
    ohYea.setInactive();
    ship.setInactive();
  }

  void restart()
  {
  }

  void update()
  {
    // Stop animation when sound ends.
    if (stopwatch.getRunTime() < soundPlayer.ohYea.duration()) {
      ohYea.update();

      // Manipulate the ship directly.
      scale += scaleInc;
      ship.setScale(abs(cos(scale)*1.5));
      ship.setX((cos(scale) * 100) + width/2);
      ship.setY((sin(scale) * 200) + height/2);
      ship.setRot((sin(scale) * PI));
      gameState = GameState.Running;
    } else {
      ohYea.setXY(width/2, height/2);
      ohYea.setRot(0);
      ship.setInactive();
      gameState = GameState.Finished;
    }
  }

  void drawOnScreen()
  {
  }

  void keyPressed()
  {
  }

  void mousePressed()
  {
  }
}
