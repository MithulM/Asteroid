/* This source code is copyrighted materials owned by the UT system and cannot be placed 
into any public site or public GitHub repository. Placing this material, or any material 
derived from it, in a publically accessible site or repository is facilitating cheating 
and subjects the student to penalities as defined by the UT code of ethics. */

import org.gamecontrolplus.*;
import net.java.games.input.*;

class KeyboardController 
{
  ControlIO controllIO;
  ControlDevice keyboard;
  ControlButton spaceBtn, leftArrow, rightArrow, upArrow, downArrow, W, A, D;

  KeyboardController(PApplet applet) 
  {
    controllIO = ControlIO.getInstance(applet);
    keyboard = controllIO.getDevice("Keyboard");
    spaceBtn = keyboard.getButton("Space");   
    leftArrow = keyboard.getButton("Left");   
    rightArrow = keyboard.getButton("Right");
    upArrow = keyboard.getButton("Up");
    downArrow = keyboard.getButton("Down");
    W = keyboard.getButton("W");
    A = keyboard.getButton("A");
    D = keyboard.getButton("D");
  }

  boolean isUp() 
  {
    return upArrow.pressed();
  }

  boolean isDown() 
  {
    return downArrow.pressed();
  }

  boolean isLeft() 
  {
    return leftArrow.pressed();
  }

  boolean isRight() 
  {
    return rightArrow.pressed();
  }

  boolean isW() 
  {
    return W.pressed();
  }

  boolean isA() 
  {
    return A.pressed();
  }

  boolean isD() 
  {
    return D.pressed();
  }
  
  boolean isSpace() 
  {
    return spaceBtn.pressed();
  }
}
