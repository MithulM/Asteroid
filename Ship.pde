/* This source code is copyrighted materials owned by the UT system and cannot be placed 
 into any public site or public GitHub repository. Placing this material, or any material 
 derived from it, in a publically accessible site or repository is facilitating cheating 
 and subjects the student to penalities as defined by the UT code of ethics. */

class Ship extends GameObject
{
  float rotInc = .05;
  float rotation;
  float accel = 30;
  float energy, restore, deplete;

  int shieldTime;
  boolean isShielded;
  StopWatch shieldSW;
  
  int shipNum;

  Ship(PApplet game, int xpos, int ypos, int shipNum, String imageName) 
  {
    this(game, imageName, xpos, ypos);
    this.shipNum = shipNum;
    setScale(.5);
  }
  
  // The image file must contain two frames. See Ships2.png as example. 
  Ship(PApplet game, String imageFilename, int xpos, int ypos) 
  {
    super(game, imageFilename, 2, 1, 50);

    rotation = 0;
    energy = 1;
    restore = .005;
    deplete = .5;

    tag = this;
    setXY(xpos, ypos);
    setVelXY(0, 0);
    setFrame(0);

    isShielded = false;
    shieldSW = new StopWatch();

    // Domain keeps the moving sprite withing specific screen area 
    setDomain(0, 0, game.width, game.height, Sprite.REBOUND);
  }

  void update() 
  {
    processKeys();

    energy += restore;
    if (energy > 1) energy = 1;
    if (energy < 0) energy = 0;

    if (shieldSW.getRunTime() > shieldTime) {
      isShielded = false;
    }
  }

  void drawOnScreen()
  {
    // Draw a filled rectangle representing the ship's energy.
    float xpos = (float)getX() + 20;
    float ypos = (float)getY() - 40;
    if (this.isActive()) {
      drawBar(color(255, 255, 255), xpos, ypos, energy);

      if (isShielded) {
        // Draw a filled rectangle representing the ship's shild if any
        xpos = (float)getX() + 20;
        ypos = (float)getY() + 40;
        // Percentage of shield time remaining
        float pcnt = (float)((shieldTime - shieldSW.getRunTime())/shieldTime);
        drawBar(color(255, 0, 0), xpos, ypos, pcnt);
      
        // Draw a translucent circel around ship
        fill(255, 0, 0, 50);
        xpos = (float)getX() + 0;
        ypos = (float)getY() + 0;
        circle(xpos, ypos, 80);
      }
    }
  }

  void processKeys() 
  {
    
    if (focused) {
      if (shipNum == 1) {
        if (kbController.isW()) {
          setFrame(1);
          setAcceleration(accel, rotation - 1.5708);
        } else {
          setFrame(0);
          setAcceleration(0);
        }

        if (kbController.isD()) {
          rotation += rotInc;
          setRot(rotation);
        }

        if (kbController.isA()) {
          rotation -= rotInc;
          setRot(rotation);
        }
      }
      
      if (shipNum == 2) {
        if (kbController.isUp()) {
          setFrame(1);
          setAcceleration(accel, rotation - 1.5708);
        } else {
          setFrame(0);
          setAcceleration(0);
        }

        if (kbController.isRight()) {
          rotation += rotInc;
          setRot(rotation);
        }

        if (kbController.isLeft()) {
          rotation -= rotInc;
          setRot(rotation);
        }
      }
    }
  }

  void setShield(int time)
  {
    isShielded = true;
    shieldTime = time;
    shieldSW.reset();
  }

  boolean isShielded() 
  {
    return isShielded;
  }
}


/*************************************************/


class Missile extends GameObject
{
  StopWatch missileSW;
  public Ship ship;
  
  Missile(PApplet applet, int xpos, int ypos, Ship ship, String image) 
  {
    super(applet, image, 40);
    missileSW = new StopWatch();
    this.ship = ship;
    
    setXY(xpos, ypos);
    setVelXY(0, 0);
    setScale(.75);

    soundPlayer.playMissileLaunch();
  }

  void update() 
  {
    // Run missile for 3 seconds
    if (missileSW.getRunTime() > 3.0) {
      setDead(true);
    }
  }

  void drawOnScreen() {
  }
}
