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
  PApplet applet;
  GameState gameState; 

  GameLevel(PApplet applet)
  {
    this.applet = applet;
    gameState = GameState.NotRunning;
  }

  // Initialize all the resources needed by the level
  abstract void start();

  // Deallocate the resources maintained by the level
  abstract void stop();

  // Reinitialize the resources maintained by the level.
  abstract void restart();

  // Called every frame to update the resources maintained by the level.
  abstract void update();

  abstract GameState getGameState();

  // Use raw Processing operations to draw on the screen.
  abstract void drawOnScreen();

  // Called when a key is pressed in the active level. 
  abstract void keyPressed();
}


/*********************************************/


class StartLevel extends GameLevel
{
  StartButton startButton;

  StartLevel(PApplet applet)
  {
    super(applet);
    gameState = GameState.NotRunning;
  }

  void start()
  {
    startButton = new StartButton(applet, width/2, height/2, this);
    gameState = GameState.Running;
  }

  void stop()
  {
    startButton.setDead();
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
}

/*********************************************/


class LoseLevel extends GameLevel
{
  GameOver gameOver;

  LoseLevel(PApplet applet)
  {
    super(applet);
  }

  void start()
  {
    gameOver = new GameOver(applet, width/2, height/2);
    gameOver.trigger();
    
    soundPlayer.playGameOver();

    gameState = GameState.Running;
  }

  void stop()
  {
  }

  void restart()
  {
  }

  void update()
  {
    gameOver.update();
  }

  GameState getGameState()
  {
    return GameState.Running;
  }

  void drawOnScreen()
  {
  }

  void keyPressed()
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
  long triggerTime;

  WinLevel(PApplet applet)
  {
    super(applet);
  }

  void start()
  {
    triggerTime = System.currentTimeMillis();

    soundPlayer.playOhYea();

    ohYea = new OhYea(applet, width/2, height/2);
    ohYea.trigger();

    ship = new Ship(applet, width/2, height/2);

    gameState = GameState.Running;
  }

  void stop()
  {
  }

  void restart()
  {
  }

  void update()
  {
    // Stop animation when sound ends.
    long currentTime = System.currentTimeMillis();
    if ((currentTime - triggerTime) < soundPlayer.ohYea.length()) {
      ohYea.update();
      
      // Manipulate the ship directly.
      scale += scaleInc;
      ship.setScale(abs(cos(scale)*1.5));
      ship.setX((cos(scale) * 100) + width/2);
      ship.setY((sin(scale) * 200) + height/2);
      ship.setRot((sin(scale) * PI));
    }
    else {
      ohYea.setDead();
      ship.setDead();
    }
  }

  GameState getGameState()
  {
    return GameState.Running;
  }

  void drawOnScreen()
  {
  }

  void keyPressed()
  {
  }
}
