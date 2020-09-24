/* This source code is copyrighted materials owned by the UT system and cannot be placed 
 into any public site or public GitHub repository. Placing this material, or any material 
 derived from it, in a publically accessible site or repository is facilitating cheating 
 and subjects the student to penalities as defined by the UT code of ethics. */

class AsteroidsLevel2 extends GameLevel 
{
  Ship ship;
  CopyOnWriteArrayList<GameObject> asteroids;
  CopyOnWriteArrayList<GameObject> missiles;
  CopyOnWriteArrayList<GameObject> explosions;

  int numLives;
  int maxLives = 3;
  float missileSpeed = 200;

  AsteroidsLevel2(PApplet applet)
  {
    super(applet);
    this.applet = applet;
  }

  void start()
  {
    ship = new Ship(applet, width/2, height/2);
    missiles = new CopyOnWriteArrayList<GameObject>();
    explosions = new CopyOnWriteArrayList<GameObject>();

    asteroids = new CopyOnWriteArrayList<GameObject>();
    asteroids.add(new BigAsteroid(applet, 200, 500, 0, 0.02, 22, PI*.5));
    asteroids.add(new BigAsteroid(applet, 500, 200, 1, -0.01, 22, PI*1));
    asteroids.add(new BigAsteroid(applet, 100, 300, 2, 0.01, 22, PI*1.7));
    asteroids.add(new BigAsteroid(applet, 500, 600, 0, -0.02, 22, PI*1.3));

    gameState = GameState.Running;
  }

  void stop()
  {
    ship.setDead();

    // Remove all GameObjects
    for (GameObject missile : missiles) {
      missile.setDead();
      missiles.remove(missile);
    }

    for (GameObject asteroid : asteroids) {
      asteroid.setDead();
      asteroids.remove(asteroid);
    }

    for (GameObject explosion : explosions) {
      explosion.setDead();
      explosions.remove(explosion);
    }
  }

  void restart()
  {
    // Not Used / Implemented
  }

  void update() 
  {
    sweepDeadObject();
    updateObjects();

    if (isGameOver()) {
      gameState = GameState.Finished;
    } 
    checkShipCollisions();
    checkMissileCollisions();
  }

  private boolean isGameOver() 
  {
    if (asteroids.size() == 0 && !ship.isDead()) {
      return true;
    } else {
      return false;
    }
  }

  GameState getGameState()
  {
    return gameState;
  }

  void drawOnScreen() 
  {
    String msg;

    fill(255);
    textSize(20);
    msg = "Ship X: " + str((float)ship.getVelX());
    text(msg, 10, 20);
    msg = "Ship Y: " + str((float)ship.getVelY());
    text(msg, 10, 40);
    msg = "Ship Speed: " + str((float)ship.getSpeed());
    text(msg, 10, 60);

    ship.drawOnScreen();
  }

  void keyPressed() 
  {
    if ( key == ' ') {
      if (!ship.isDead()) {
        launchMissile(missileSpeed);
      }
    }
  }

  // Remove dead GameObjects from their lists. 
  private void sweepDeadObject()
  {
    // Remove expired missiles
    for (GameObject missile : missiles) {
      if (missile.isDead()) {
        missiles.remove(missile);
      }
    }

    // Remove expired asteroids
    for (GameObject asteroid : asteroids) {
      if (asteroid.isDead()) {
        asteroids.remove(asteroid);
      }
    }

    // Remove expired explosions
    for (GameObject explosion : explosions) {
      if (explosion.isDead()) {
        explosions.remove(explosion);
      }
    }
  }

  // Cause each GameObject to update their state.
  private void updateObjects()
  {
    ship.update();

    for (GameObject asteroid : asteroids) {
      asteroid.update();
    }
    for (GameObject missile : missiles) {
      missile.update();
    }
    for (GameObject explosion : explosions) {
      explosion.update();
    }
  }

  private void launchMissile(float speed) 
  {
    if (ship.energy >= .2) {
      int shipx = (int)ship.getX();
      int shipy = (int)ship.getY();
      Missile missile = new Missile(applet, shipx, shipy);
      missile.setRot(ship.getRot() - 1.5708);
      missile.setSpeed(speed);
      missiles.add(missile);

      ship.energy -= ship.deplete;
    }
  }

  // Check missile to asteroid collisions
  private void checkMissileCollisions() 
  {
    if (ship.isDead()) return;

    // find a process missile - asteroid collisions
    for (GameObject missile : missiles) {
      for (GameObject asteroid : asteroids) {
        if (missile.checkCollision(asteroid)) {
          missile.setDead();
          missiles.remove(missile);

          asteroid.setDead();
          int asteroidx = (int)asteroid.getX();
          int asteroidy = (int)asteroid.getY();
          explosions.add(new ExplosionSmall(applet, asteroidx, asteroidy));
          asteroids.remove(asteroid);
          if (asteroid instanceof BigAsteroid) {
            addSmallAsteroids(asteroid);
          }
        }
      }
    }
  }

  // Check ship to asteroid collisions
  private void checkShipCollisions() 
  {
    if (ship.isDead()) return;

    // Dont collide with ship when first created and not moved.
    if (ship.getX() == width/2 && ship.getY() == height/2) return;

    for (GameObject asteroid : asteroids) {
      if (!asteroid.isDead() && ship.checkCollision(asteroid)) {

        int shipx = (int)ship.getX();
        int shipy = (int)ship.getY();
        explosions.add(new ExplosionLarge(applet, shipx, shipy));

        ship.setDead();
        if (++numLives < maxLives) {
          ship = new Ship(applet, width/2, height/2);
        } else {
          gameState = GameState.Lost;
        }

        asteroid.setDead();
        asteroids.remove(asteroid);
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
    asteroids.add(new SmallAsteroid(applet, xpos, ypos, 0, 0.02, 44, PI*.5));
    asteroids.add(new SmallAsteroid(applet, xpos, ypos, 1, -0.01, 44, PI*1));
    asteroids.add(new SmallAsteroid(applet, xpos, ypos, 2, 0.01, 44, PI*1.7));
  }
}
