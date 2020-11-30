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
    explosionSmallAsteroid = new SoundFile(app, "SmallAsteroidExplosion.wav");
    explosionShip = new SoundFile(app, "ExplosionShip.wav");
    ohYea = new SoundFile(app, "OhYea.wav");
    missileLaunch = new SoundFile(app, "MissileLaunch.wav");
  }

  void playExplosion() 
  {
    stop();
    boomPlayer.play();
  }

  void playPop() 
  {
    stop();
    popPlayer.play();
  }

  void playGameOver() 
  {
    stop();
    gameOverPlayer.play();
  }
  
  void playExplosionLargeAsteroid() 
  {
    stop();
    explosionLargeAsteroid.play();
  }

  void playExplosionSmallAsteroid() 
  {
    stop();
    explosionSmallAsteroid.play();
  }
  
  void playExplosionShip() 
  {
    stop();
    explosionShip.play();
  }

  void playOhYea() 
  {
    stop();
    ohYea.play();
  }

  void playMissileLaunch() 
  {
    stop();
    missileLaunch.play();
  }
  
  void stop()
  {
    boomPlayer.stop();
    popPlayer.stop();
    gameOverPlayer.stop();
    explosionLargeAsteroid.stop();
    explosionSmallAsteroid.stop();
    explosionShip.stop();
    ohYea.stop();
    missileLaunch.stop();
  }

}
