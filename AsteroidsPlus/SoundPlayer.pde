/* This source code is copyrighted materials owned by the UT system and cannot be placed 
into any public site or public GitHub repository. Placing this material, or any material 
derived from it, in a publically accessible site or repository is facilitating cheating 
and subjects the student to penalities as defined by the UT code of ethics. */

import processing.sound.*;

class SoundPlayer 
{
  SoundFile boomPlayer, popPlayer, gameOverPlayer;
  SoundFile explosionLargeAsteroid, explosionShip, explosionSmallAsteroid;
  SoundFile ohYea, missileLaunch;
  
  SoundPlayer(PApplet app) 
  {
    boomPlayer = new SoundFile(app, "explode.wav"); 
    gameOverPlayer = new SoundFile(app, "ThatsAllFolks.wav"); 
    popPlayer = new SoundFile(app, "pop.wav");
    explosionLargeAsteroid = new SoundFile(app, "LargAsteroidExplosion.wav");
    //explosionLargeAsteroid.amp(0.3);
    explosionSmallAsteroid = new SoundFile(app, "SmallAsteroidExplosion.wav");
    explosionShip = new SoundFile(app, "ExplosionShip.wav");
    ohYea = new SoundFile(app, "OhYea.wav");
    missileLaunch = new SoundFile(app, "MissileLaunch.wav");
  }

  void playExplosion() 
  {
    boomPlayer.play();
  }

  void playPop() 
  {
    popPlayer.play();
  }

  void playGameOver() 
  {
    gameOverPlayer.play();
  }
  
  void playExplosionLargeAsteroid() 
  {
    explosionLargeAsteroid.play();
  }

  void playExplosionSmallAsteroid() 
  {
    explosionSmallAsteroid.play();
  }
  
  void playExplosionShip() 
  {
    explosionShip.play();
  }

  void playOhYea() 
  {
    ohYea.play();
  }

  void playMissileLaunch() 
  {
    missileLaunch.play();
  }
}
