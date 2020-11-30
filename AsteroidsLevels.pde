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
  int time1;
  int time2;
  
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
    enemyShip1 = new Ship(game, 50, height/2, 1, "ship3.png");
    enemyShip2 = new Ship(game, width/2, 50, 1, "ship3.png");
    
    time1 = millis();
    time2 = millis();
    
    playerOneRemainingLives = startLives;
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
    enemyShip1.setRotation((float)(ship1.x() - enemyShip1.x()), (float)(enemyShip1.y() - ship1.y()));
    enemyShip2.setRotation((float)(ship1.x() - enemyShip2.x()), (float)(enemyShip2.y() - ship1.y()));
    if ((millis() - time1)/1000 > 7) {
      launchMissile(missileSpeed, enemyShip1);
      time1 = millis();
    }
    if ((millis() - time2)/1000 > 11) {
      launchMissile(missileSpeed, enemyShip2);
      time2 = millis();
    }
    if (powerupSW.getRunTime() > periodBetweenPU) {
      powerupSW.reset();
      int rand = (int)random(0, 3);
      switch(rand) {
      case 0:
        powerUps.add(new ShieldPowerup(game, (int)random(0, game.width), (int)random(0, game.height), 100));
        break;
      case 1:
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
          launchMissile(missileSpeed, ship1);
        }
      }
    }

    private void launchMissile(float speed, Ship ship) 
    {
      if (ship1.energy >= .2) {
        
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
      playerOneRemainingLives = startLives;
      playerTwoRemainingLives = startLives;
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
      int rand = (int)random(0, 3);
      switch(rand) {
      case 0:
        powerUps.add(new ShieldPowerup(game, (int)random(0, game.width), (int)random(0, game.height), 100));
        break;
      case 1:
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
      msg = "Player 1 : Player 2";
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
