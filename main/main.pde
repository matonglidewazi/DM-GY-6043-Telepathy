/*
Telepathy project by Tongda Xu
Dependency: 
#Processing Sound
#Processing oscP5
#Emotiv MindOSC
#Emotiv EmotiveBCI
#Emotiv Xavier Composer
*/

/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
import processing.sound.*;

float happiness = 0;
float sadiness = 0;

SoundFile happyTTS;
SoundFile sadTTS;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,7400);
  //happyTTS = new SoundFile(this, "Happy_TTS.mp3");
  //sadTTS = new SoundFile(this, "Sad_TTS.mp3");

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
}


void draw() {
  background(0);  
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  
  String aPat = theOscMessage.addrPattern();
  
  //Update emotion state
  if (aPat.equals("/EXP/SMILE")){
      happiness = theOscMessage.get(0).floatValue();
      println ("Happiness parameter = " + happiness);
  } else if (aPat.equals("/EXP/FURROW")){
      sadiness = theOscMessage.get(0).floatValue();
      println ("Sadiness parameter = " + sadiness);
  } else {
  //pass
  }
  
  if (happiness >= sadiness){
    //happyTTS.play();
  } else {
    //sadTTS.play();
  }
  
  
}
