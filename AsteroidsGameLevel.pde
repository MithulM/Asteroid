/* This source code is copyrighted materials owned by the UT system and cannot be placed 
 into any public site or public GitHub repository. Placing this material, or any material 
 derived from it, in a publically accessible site or repository is facilitating cheating 
 and subjects the student to penalities as defined by the UT code of ethics. */

abstract class AsteroidsGameLevel extends GameLevel 
{
  CopyOnWriteArrayList<GameObject> asteroids;
  CopyOnWriteArrayList<GameObject> missiles;
  CopyOnWriteArrayList<GameObject> explosions;
  CopyOnWriteArrayList<GameObject> powerUps;
  int smallDestroyed;
  boolean frozen;
  Ship enemyShip1;
  Ship enemyShip2;
  
  AsteroidsGameLevel(PApplet game)
  {
    super(game);
    this.game = game;
    smallDestroyed = 0;
    missiles = new CopyOnWriteArrayList<GameObject>();
    explosions = new CopyOnWriteArrayList<GameObject>();
    powerUps = new CopyOnWriteArrayList<GameObject>();
    asteroids = new CopyOnWriteArrayList<GameObject>();
    frozen = false;
    for(GameObject lives: P1lives)
    {
      lives.setInactive();
      P1lives.remove(lives);
    }
    P1lives = new CopyOnWriteArrayList<Image>();
    for(int i = 0; i < playerOneRemainingLives; i++)
    {
      P1lives.add(new Image(game, "ship1.png", 50 * i + XLivesOffset, YLivesOffset));
    }
    for(GameObject lives: P2lives)
    {
      lives.setInactive();
      P2lives.remove(lives);
    }
    P2lives = new CopyOnWriteArrayList<Image>();
    for(int i = 0; i < playerTwoRemainingLives; i++)
    {
      P2lives.add(new Image(game, "ship2.png", width - (50 * i + XLivesOffset), YLivesOffset));
    }
    playerOneScore = 0;
    playerTwoScore = 0;
  }
  
  private void addAsteroids(int amount)
  {
    for(int i = 0; i < amount; i++)
    {
      int bound = 30;
      int xPicBounds = 180;
      int yPicBounds = 100;
      int xCoord = (int)random(bound,game.width-bound);
      int yCoord = (int)random(bound,game.height-bound);
      while (!(xCoord < (game.width/2 - xPicBounds) || xCoord > (game.width/2 + xPicBounds)))
      {
        xCoord = (int)random(bound,game.width-bound);
      }
      while (!(yCoord < (game.height/2 - yPicBounds) || yCoord > (game.height/2 + yPicBounds)))
      {
        yCoord = (int)random(bound,game.height-bound);
      }
      asteroids.add(new BigAsteroid(game, xCoord, yCoord, (int)random(1,3), random(-0.02,0.02), random(20,50), PI*random(0,2)));
    }
  }

  void start() {
  } 

  // Remove all GameObjects from the Level
  void stop()
  {
    ship1.setInactive();
    if (ship2 != null) {
      ship2.setInactive();
    }
    else {
      enemyShip1.setInactive();
      enemyShip2.setInactive();
    }
    for (GameObject missile : missiles) {
      missile.setInactive();
    }
    for (GameObject asteroid : asteroids) {
      asteroid.setInactive();
    }
    for (GameObject explosion : explosions) {
      explosion.setInactive();
    }
    for (GameObject powerup : powerUps) {
      powerup.setInactive();
    }
    for (GameObject lives : P1lives) {
      lives.setInactive();
    }
    for (GameObject lives : P2lives) {
      lives.setInactive();
    }

    sweepInactiveObjects();
  }

  void restart() {
    // Not Used
  } 

  void update() 
  {
    sweepInactiveObjects();
    updateObjects();
    
    if (isLevelOver()) {
      gameState = GameState.Finished;
    }
    checkShipCollisions(ship1);
    checkMissileCollisions(ship1);
    checkPowerUpCollisions(ship1);
    checkEnemyCollisions();
    
    if (ship2 != null) {
      checkShipCollisions(ship2);
      checkMissileCollisions(ship2);
      checkPowerUpCollisions(ship2);
    }
    if (freeze)
      if (freezeSW.getRunTime() < FreezeTime)
      {
        for (GameObject asteroid: asteroids)
          if (asteroid instanceof BigAsteroid)
            ((BigAsteroid)asteroid).setFreeze(true);
          else
            ((SmallAsteroid)asteroid).setFreeze(true);
      }
      else
      {
        freeze = false;
        for (GameObject asteroid: asteroids)
          if (asteroid instanceof BigAsteroid)
            ((BigAsteroid)asteroid).setFreeze(false);
          else
            ((SmallAsteroid)asteroid).setFreeze(false);
      }
  }

  // The game ends when there are no asteroids and the ship is active. 
  private boolean isLevelOver() 
  {
    //Adjust point values here
    if(ship2 != null){
      if (playerOneScore - playerTwoScore >= 5 && ship1.isActive()) {
        winner = 1;
        return true;
      }
      if (playerTwoScore - playerOneScore >= 5 && ship2.isActive()) {
        winner = 2;
        return true;
      }
      return false;
    }
    // Player 1 mode
    else
    {
      if (!ship1.isActive()) {
        winner = 0;
        return true;
      }
      if (playerOneScore > 9){
        winner = 1;
        return true;
      }
      return false;
    }
  }

  // Remove inactive GameObjects from their lists. 
  private void sweepInactiveObjects()
  {
    // Remove inactive missiles
    for (GameObject missile : missiles) {
      if (!missile.isActive()) {
        missiles.remove(missile);
      }
    }

    // Remove inactive asteroids
    for (GameObject asteroid : asteroids) {
      if (!asteroid.isActive()) {
        asteroids.remove(asteroid);
      }
    }

    // Remove inactive explosions
    for (GameObject explosion : explosions) {
      if (!explosion.isActive()) {
        explosions.remove(explosion);
      }
    }

    // Remove inactive PowerUps
    for (GameObject powerUp : powerUps) {
      if (!powerUp.isActive()) {
        powerUps.remove(powerUp);
      }
    }
    
    // Remove inactive lives sprite
    for (GameObject lives : P1lives) {
      if (!lives.isActive()) {
        powerUps.remove(lives);
      }
    }
    for (GameObject lives : P2lives) {
      if (!lives.isActive()) {
        powerUps.remove(lives);
      }
    }
  }

  // Cause each GameObject to update their state.
  private void updateObjects()
  {
    ship1.update();
    if (ship2 != null) {
      ship2.update();
    }
    
    for (GameObject asteroid : asteroids) {
      if (asteroid.isActive()) asteroid.update();
    }
    for (GameObject missile : missiles) {
      if (missile.isActive()) missile.update();
    }
    for (GameObject explosion : explosions) {
      if (explosion.isActive()) explosion.update();
    }
    for (GameObject powerUp : powerUps) {
      if (powerUp.isActive()) powerUp.update();
    }
    for (GameObject lives : P1lives) {
      if (lives.isActive()) lives.update();
    }
    for (GameObject lives : P2lives) {
      if (lives.isActive()) lives.update();
    }
  }

  // Check PowerUp to Missile collisions
  private void checkEnemyCollisions() {
    if (ship2 == null) {
      for (GameObject missile : missiles) {
        if (ship1.checkCollision(missile) && (((Missile)missile).ship == enemyShip1 || ((Missile)missile).ship == enemyShip2)) {
          int shipx = (int)ship1.getX();
          int shipy = (int)ship1.getY();
          explosions.add(new ExplosionLarge(game, shipx, shipy));
        
          ship1.setInactive();
          playerOneRemainingLives--;
          P1lives.get(playerOneRemainingLives).setInactive();
          P1lives.remove(playerOneRemainingLives);
          if (playerOneRemainingLives > 0) {
            ship1 = new Ship(game, width/2, height/2, 1 , "ship1.png");
          } else {
            ship1.drawOnScreen();
            gameState = GameState.Lost;
          }
          missile.setInactive();
        }
      }
    }
  }
  
  private void checkPowerUpCollisions(Ship ship) 
  {
    if (!ship.isActive()) return;

    for (GameObject powerUp : powerUps) {
      for (GameObject missile : missiles) {
        if (powerUp.checkCollision(missile) && ((Missile)missile).ship == ship) {
          ((PowerUp)powerUp).activate(ship);
          powerUp.setInactive();
          missile.setInactive();
        } else if (powerUp.checkCollision(missile) && ((Missile)missile).ship == ship2) {
          ((PowerUp)powerUp).activate(ship2);
          powerUp.setInactive();
          missile.setInactive();
        }
      }
    }
  }

  // Check missile to asteroid collisions
  private void checkMissileCollisions(Ship ship) 
  {
    if (!ship.isActive()) return;   

    // find and process missile - asteroid collisions
    for (GameObject missile : missiles) {
      for (GameObject asteroid : asteroids) {
        if (missile.checkCollision(asteroid) && ((Missile)missile).ship == ship) {
          if(asteroid instanceof SmallAsteroid)
            smallDestroyed++;
          if(smallDestroyed % 3 == 0 && smallDestroyed != 0 && asteroid instanceof SmallAsteroid)
            addAsteroids(1);
          missile.setInactive();
          asteroid.setInactive();
          int asteroidx = (int)asteroid.getX();
          int asteroidy = (int)asteroid.getY();          
          if (((Missile)missile).ship == ship1) {
            playerOneScore++;
          } else if (((Missile)missile).ship == ship2) {
            playerTwoScore++;
          }  
          explosions.add(new ExplosionSmall(game, asteroidx, asteroidy));
          if (asteroid instanceof BigAsteroid) {
            addSmallAsteroids(asteroid);
          }
        }
      }
    }
  }

  // Check ship to asteroid collisions
  private void checkShipCollisions(Ship ship) 
  {
    if (!ship.isActive()) return;

    // Dont collide with ship when created and placed at center 
    if (ship.getX() == width/2 && ship.getY() == height/2) return;

    for (GameObject asteroid : asteroids) {
      if (asteroid.isActive() && !ship.isShielded() && ship.checkCollision(asteroid)) {
        if(asteroid instanceof SmallAsteroid)
            smallDestroyed++;
        if(smallDestroyed % 3 == 0 && smallDestroyed != 0 && asteroid instanceof SmallAsteroid)
            addAsteroids(1);
        int shipx = (int)ship.getX();
        int shipy = (int)ship.getY();
        explosions.add(new ExplosionLarge(game, shipx, shipy));
        
        //Removes ships and sets conditions for life decrementation
        ship.setInactive();
        if (ship == ship1) {
          playerOneRemainingLives--;
          P1lives.get(playerOneRemainingLives).setInactive();
          P1lives.remove(playerOneRemainingLives);
          if (playerOneRemainingLives > 0) {
            ship1 = new Ship(game, width/2, height/2, 1 , "ship1.png");
          } else {
            ship.drawOnScreen();
            if (ship2 == null){
              gameState = GameState.Lost;
            } else if (ship2.isActive()){
              winner = 2;
              gameState = GameState.Finished;
            }
          }
        } else if (ship == ship2) {
          playerTwoRemainingLives--;
          P2lives.get(playerTwoRemainingLives).setInactive();
          P2lives.remove(playerTwoRemainingLives);
          if (playerTwoRemainingLives > 0) {
            ship2 = new Ship(game, width/2, height/2, 2, "ship2.png");
          } else {
            ship.drawOnScreen();
            if (ship1.isActive()){
              winner = 1;
              gameState = GameState.Finished;
            }
          }
        }
        
        if (playerOneRemainingLives == 0 && playerTwoRemainingLives == 0) {
          if (playerOneScore > playerTwoScore){
            winner = 1;
            gameState = GameState.Finished;
          }
          else if (playerOneScore < playerTwoScore){
            winner = 2;
            gameState = GameState.Finished;
          }
          else
          {
            gameState = GameState.Lost;
          }
        }

        asteroid.setInactive();
        if (asteroid instanceof BigAsteroid) {
          addSmallAsteroids(asteroid);
        }

        break; // only happens once
      }
    }
  }

  private void addSmallAsteroids(GameObject go)
  {
    int xpos = (int)go.getX();
    int ypos = (int)go.getY();
    asteroids.add(new SmallAsteroid(game, xpos, ypos, 0, 0.02, 44, PI*.5));
    asteroids.add(new SmallAsteroid(game, xpos, ypos, 1, -0.01, 44, PI*1));
    asteroids.add(new SmallAsteroid(game, xpos, ypos, 2, 0.01, 44, PI*1.7));
  }
}
