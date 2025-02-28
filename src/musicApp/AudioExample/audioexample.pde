//File created entirely by Micah Tien.

import themidibus.*;
MidiBus myBus;
boolean debugMode;

//kidna unnecessary
boolean[] keysPressed;
String keyString;

//very unnecessary
float[] widths;
int[] blackKeys;

void setup() {
  size(1000, 300);
  background(0);

  myBus = new MidiBus();
  myBus.registerParent(this);
  String OS = platformNames[platform];
  if (OS.equals("windows")) {
    myBus.addInput(0);
    myBus.addOutput(3);
  } else if (OS.equals("macos")) {
    myBus.addInput(1);
    myBus.addOutput(2);
  } else {
    println("eww linux");
  }

  debugMode = false;

  keyString = "awsedftgyhujkolp;";
  keysPressed = new boolean[keyString.length()];
  
  widths = new float[17];
  float[] twidths = {50.0, 110, 140.0, 200, 230.0, 320.0, 380, 410.0, 470, 500.0, 560, 590.0, 680.0, 740, 770.0, 830, 860.0};
  widths = twidths;
  
  blackKeys = new int[17];
  int[] tblackKeys = {0,1,0,1,0,0,1,0,1,0,1,0,0,1,0,1,0};
  blackKeys = tblackKeys;
  
  for (int i=0; i<keysPressed.length; i++) {
    keysPressed[i] = false;
    myBus.sendNoteOff(i!=9 ? i : 18, 60+i, 127);
  } //for safety!
}

void draw() {
  background(127);
  for (int i=0; i<keysPressed.length; i++) {
    if(blackKeys[i] == 0) {    //white key
      fill(keysPressed[i] ? 200 : 255);
    } else {                   //black key
      fill(keysPressed[i] ? 80 : 0);
    }
    rect(widths[i], (height/2)-60, 80, blackKeys[i]==0 ? 120 : 80);
  }
  textSize(32);
  fill(0);
  text("A", 80, (height/2)+40);
  
  if (!keyPressed) {
    for (int i=0; i<keysPressed.length; i++) {
      keysPressed[i] = false;
      myBus.sendNoteOff(i!=9 ? i : 18, 60+i, 127);
    } //for safety!
  }
}

//keyboard goes awsedftgyhujkolp;

void keyPressed() {
  for (int i=0; i<keysPressed.length; i++) {
    if (key == keyString.charAt(i)) {
      keysPressed[i] = true;
      myBus.sendNoteOn(i!=9 ? i : 18, 60+i, 127); //channel, pitch, velocity
    }
  }
}

void keyReleased() {
  for (int i=0; i<keysPressed.length; i++) {
    if (key == keyString.charAt(i)) {
      keysPressed[i] = false;
      myBus.sendNoteOff(i!=9 ? i : 18, 60+i, 127);
    }
  }
}
