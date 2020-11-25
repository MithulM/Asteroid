/* This source code is copyrighted materials owned by the UT system and cannot be placed 
 into any public site or public GitHub repository. Placing this material, or any material 
 derived from it, in a publically accessible site or repository is facilitating cheating 
 and subjects the student to penalities as defined by the UT code of ethics. */

class AsteroidsLevel1 extends AsteroidsGameLevel 
{
  float missileSpeed = 200;
  StopWatch powerupSW;
  int periodBetweenPU = 10;
  float asteroidSpeed;
  PApplet applet;

  AsteroidsLevel1(PApplet applet)
  {
    super(applet);
    this.applet = applet;
    powerupSW = new StopWatch();
    asteroidSpeed = 3;
  }

  void start()
  {
    super.start();

    ship1 = new Ship(game, width/2, height/2, 1, "ship1.png");
    ship2 = null;

    playerOneRemainingLives = 3;
    playerTwoRemainingLives = 0;

    for (GameObject lives : P1lives)
    {
      lives.setInactive();
      P1lives.remove(lives);
    }
    P1lives = new CopyOnWriteArrayList<Image>();
    for (int i = 0; i < playerOneRemainingLives; i++)
    {
      P1lives.add(new Image(game, "ship1.png", 50 * i + XLivesOffset, YLivesOffset));
    }
    for (GameObject lives : P2lives)
    {
      lives.setInactive();
      P2lives.remove(lives);
    }
    P2lives = new CopyOnWriteArrayList<Image>();
    for (int i = 0; i < playerTwoRemainingLives; i++)
    {
      P2lives.add(new Image(game, "ship2.png", width - (50 * i + XLivesOffset), YLivesOffset));
    }

    super.addAsteroids(2);
    gameState = GameState.Running;
  }

  void update() 
  {
    super.update();    
 

   if (powerupSW.getRunTime() > periodBetweenPU) {
      powerupSW.reset();
      int rand = (int)random(0, 4);
      switch(rand) {
      case 1:
        powerUps.add(new ShieldPowerup(game, (int)random(0, game.width), (int)random(0, game.height), 100));
        break;
      case 2:
        powerUps.add(new LifePowerup(game, (int)random(0, game.width), (int)random(0, game.height), 100));
        break;
      default:
        powerUps.add(new FreezePowerup(game, (int)random(0, game.width), (int)random(0, game.height), 100));
      }
    }
    }

    void drawOnScreen() 
    {    
      String msg;

      // TEAMS: Remove this text from your delivered games. 
      fill(255);
      textSize(20);
      msg = "Player Score";
      text(msg, (width/2) - 64, 20);
      textSize(40);
      msg = ":" + playerOneScore + ":";
      text(msg, (width/2) - 35, 60);     

      ship1.drawOnScreen(); // Draws Energy Bar
    }

    void keyPressed() 
    {
      if ( key == ' ') {
        if (ship1.isActive()) {
          launchMissile(missileSpeed);
        }
      }
    }

    private void launchMissile(float speed) 
    {
      if (ship1.energy >= .2) {
        int shipx = (int)ship1.getX();
        int shipy = (int)ship1.getY();
        Missile missile = new Missile(game, shipx, shipy, ship1, "playerMissleOne.png");
        missile.setRot(ship1.getRot() - PI*.5);
        missile.setSpeed(speed);
        missiles.add(missile);

        ship1.energy -= ship1.deplete;
      }
    }

    void mousePressed()
    {
    }
  }

  /*****************************************************/

  class AsteroidsLevel2 extends AsteroidsGameLevel 
  {
    float missileSpeed = 400;
    StopWatch powerupSW;
    int periodBetweenPU = 10;

    AsteroidsLevel2(PApplet applet)
    {
      super(applet);
      powerupSW = new StopWatch();
    }

    void start()
    {
      super.start();

      ship1 = new Ship(game, width * 7/16, height/2, 1, "ship1.png");
      ship2 = new Ship(game, width * 9/16, height/2, 2, "ship2.png");
      super.addAsteroids(4);
      playerOneRemainingLives = 3;
      playerTwoRemainingLives = 3;
      for (GameObject lives : P1lives)
      {
        lives.setInactive();
        P1lives.remove(lives);
      }
      for (int i = 0; i < playerOneRemainingLives; i++)
      {
        P1lives.add(new Image(game, "ship1.png", 50 * i + XLivesOffset, YLivesOffset));
      }
      for (GameObject lives : P2lives)
      {
        lives.setInactive();
        P2lives.remove(lives);
      }
      for (int i = 0; i < playerTwoRemainingLives; i++)
      {
        P2lives.add(new Image(game, "ship2.png", width - (50 * i + XLivesOffset), YLivesOffset));
      }
      gameState = GameState.Running;
    }

    void update() 
    {
      super.update();


      if (powerupSW.getRunTime() > periodBetweenPU) {
      powerupSW.reset();
      int rand = (int)random(1, 4);
      switch(rand) {
      case 1:
        powerUps.add(new ShieldPowerup(game, (int)random(0, game.width), (int)random(0, game.height), 100));
        break;
      case 2:
        powerUps.add(new LifePowerup(game, (int)random(0, game.width), (int)random(0, game.height), 100));
        break;
      default:
        powerUps.add(new FreezePowerup(game, (int)random(0, game.width), (int)random(0, game.height), 100));
      }
    }
    }

    void drawOnScreen() 
    {
      String msg;

      fill(255);
      textSize(20);
      msg = "Player 1 " + ": " + "Player 2";
      text(msg, (width/2) - 87, 20);
      textSize(40);
      msg = playerOneScore + " : " + playerTwoScore;
      text(msg, (width/2) - 45, 60);

      ship1.drawOnScreen();
      ship2.drawOnScreen();
    }

    void keyPressed() 
    {
      if ( key == ' ') {
        if (ship1.isActive()) {
          launchMissile(missileSpeed, ship1);
        }
      }
      if ( key == '\n') {
        if (ship2.isActive()) {
          launchMissile(missileSpeed, ship2);
        }
      }
    }

    private void launchMissile(float speed, Ship ship) 
    {
      if (ship.energy >= .2) {
        int shipx = (int)ship.getX();
        int shipy = (int)ship.getY();
        String missleImage;
        if (ship == ship1) {
          missleImage = "playerMissleOne.png";
        } else {
          missleImage = "playerMissleTwo.png";
        }
        Missile missile = new Missile(game, shipx, shipy, ship, missleImage);
        missile.setRot(ship.getRot() - PI/2);
        missile.setSpeed(speed);
        missiles.add(missile);

        ship.energy -= ship.deplete;
      }
    }

    void mousePressed()
    {
    }
  }
