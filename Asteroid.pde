/* This source code is copyrighted materials owned by the UT system and cannot be placed 
into any public site or public GitHub repository. Placing this material, or any material 
derived from it, in a publically accessible site or repository is facilitating cheating 
and subjects the student to penalities as defined by the UT code of ethics. */

class BigAsteroid extends GameObject
{
  float rotInc = .1;
  PApplet game;
  float speed;
  float dir;
  BigAsteroid(PApplet applet, int xpos, int ypos, int frame, float rotInc, float speed, float direction) 
  {    
    super(applet, "largeAsteroids.png", 3, 1, 51);

    this.rotInc = rotInc;
    setXY(xpos, ypos);
    setVelXY(0, 0);
    setScale(.5);
    setFrame(frame);
    setSpeed(speed, direction);
    this.speed = speed;
    this.dir = direction;
    game = applet;

    // Domain keeps the moving sprite withing specific screen area 
    // setDomain(0, 0, applet.width, applet.height, Sprite.REBOUND );
  }

  void update()
  {
    if (!freeze)
      setRot(getRot() + rotInc);
    setXY((getX()+game.width)%(game.width), (getY()+game.height)%(game.height));
  }

  void setInactive()
  {
    super.setInactive();
    soundPlayer.playExplosionLargeAsteroid();
  }
  
  void setFreeze(boolean bool)
  {
    freeze = bool;
    if (bool)
      setSpeed(0, dir);
    else
      setSpeed(speed, dir);
  }
  
  void drawOnScreen() {}
}


/*****************************************/


class SmallAsteroid extends GameObject
{
  float rotInc = .1;
  float accel = 30;
  
  float speed;
  float dir;
  SmallAsteroid(PApplet applet, int xpos, int ypos, int frame, float rotInc, float speed, float direction) 
  {
    super(applet, "littleAsteroids.png", 3, 1, 51);

    this.rotInc = rotInc;
    
    setXY(xpos, ypos);
    setVelXY(0, 0);
    setScale(.5);
    setFrame(frame);
    setSpeed(speed, direction);
    this.speed = speed;
    this.dir = direction;

    // Domain keeps the moving sprite withing specific screen area 
    // setDomain(0, 0, applet.width, applet.height, Sprite.REBOUND );
  }

  void update() 
  {
    if (!freeze)
      setRot(getRot() + rotInc);
    setXY((getX()+game.width)%(game.width), (getY()+game.height)%(game.height));
  }
  
  void setFreeze(boolean bool)
  {
    freeze = bool;
    if (bool)
      setSpeed(0, dir);
    else
      setSpeed(speed, dir);
  }

  void setInactive()
  {
    super.setInactive();
    soundPlayer.playExplosionSmallAsteroid();
  }

  void drawOnScreen() {}
}
