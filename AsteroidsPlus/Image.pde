/* This source code is copyrighted materials owned by the UT system and cannot be placed 
 into any public site or public GitHub repository. Placing this material, or any material 
 derived from it, in a publically accessible site or repository is facilitating cheating 
 and subjects the student to penalities as defined by the UT code of ethics. */

class Image extends GameObject
{
  PApplet game;

  public Image(PApplet game, String imageName, int xpos, int ypos)
  {
    super(game, imageName, 2, 1, 50);
    setXY(xpos, ypos);
    setVelXY(0, 0);
    setFrame(0);
    setScale(.25);
  }

  void update() {}

  void setInactive()
  {
    super.setInactive();
  }
  
  void drawOnScreen() {}
}
