/* This source code is copyrighted materials owned by the UT system and cannot be placed 
into any public site or public GitHub repository. Placing this material, or any material 
derived from it, in a publically accessible site or repository is facilitating cheating 
and subjects the student to penalities as defined by the UT code of ethics. */

abstract class GameObject extends Sprite
{
  PApplet applet;
  
  public GameObject(PApplet applet, String imageName, int cols, int rows, int zorder)
  {
    super(applet, imageName, cols, rows, zorder);
    this.applet = applet;
  }
  
  public GameObject(PApplet applet, String imageName, int zorder)
  {
    super(applet, imageName, zorder);
    this.applet = applet;
  }

  boolean checkCollision(Sprite osprite) 
  {
    return cc_collision(osprite);
  }

  void setDead() 
  {
    setDead(true);
    S4P.deregisterSprite(this);
  }

  boolean isActive()
  {
    return !isDead();
  }
  
  void trigger()
  {
    setDead(false);
  }
  
  abstract void update();
}
