/* This source code is copyrighted materials owned by the UT system and cannot be placed 
into any public site or public GitHub repository. Placing this material, or any material 
derived from it, in a publically accessible site or repository is facilitating cheating 
and subjects the student to penalities as defined by the UT code of ethics. */

class ExplosionLarge extends GameObject
{
  ExplosionLarge(PApplet applet, int xpos, int ypos) 
  {
    super(applet, "explosion.png", 8, 1, 60);

    setXY(xpos, ypos);
    setVelXY(0, 0);
    setScale(1.0);
    setFrameSequence(0, 7, 0.3, 1);
    
    soundPlayer.playExplosionShip();
  }

  void update() 
  {
    if(!isImageAnimating()) {
      setDead();
    }
  }
}


/*****************************************/


class ExplosionSmall extends GameObject
{
  ExplosionSmall(PApplet applet, int xpos, int ypos) 
  {
    super(applet, "explosion.png", 8, 1, 60);

    setXY(xpos, ypos);
    setVelXY(0, 0);
    setScale(.3);
    setFrameSequence(0, 7, 0.1, 1);
  }

  void update() 
  {
    if(!isImageAnimating()) {
      setDead(true);
    }
  }
}
