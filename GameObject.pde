/* This source code is copyrighted materials owned by the UT system and cannot be placed 
 into any public site or public GitHub repository. Placing this material, or any material 
 derived from it, in a publically accessible site or repository is facilitating cheating 
 and subjects the student to penalities as defined by the UT code of ethics. */

abstract class GameObject extends Sprite
{
  PApplet game;

  public GameObject(PApplet game, String imageName, int cols, int rows, int zorder)
  {
    super(game, imageName, cols, rows, zorder);
    this.game = game;
  }

  public GameObject(PApplet game, String imageName, int zorder)
  {
    super(game, imageName, zorder);
    this.game = game;
  }

  boolean checkCollision(Sprite osprite) 
  {
    return cc_collision(osprite);
  }

  void setActive() 
  {
    setDead(false);
  }

  void setInactive() 
  {
    setDead(true);
    S4P.deregisterSprite(this);
  }

  boolean isActive()
  {
    return !isDead();
  }

  void drawBar(color fillCol, float xpos, float ypos, float pcnt)
  {    
    float h = 10;

    fill(0);
    stroke(255);
    rect( xpos, ypos, 40, h);

    float w = pcnt * 40;
    fill(fillCol);
    rect( xpos, ypos, w, h);
  }


  abstract void update();

  abstract void drawOnScreen();
}
