//File created entirely by Micah Tien.

import themidibus.*;
MidiBus myBus;
boolean debugMode;

void setup() {
  size(400, 400);
  background(0); //will be gray until startup, turns black once on
  
  //MidiBus.list(); //for debugging only!
  
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
}

void draw() {
  //could show something fun but idc
}
void mousePressed() {
  int channel = 0;
  int pitch = 60;
  int velocity = 127;

  //simple C3 C chord
  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  myBus.sendNoteOn(channel+1, pitch+4, velocity);
  myBus.sendNoteOn(channel+2, pitch+7, velocity);
  myBus.sendNoteOn(channel+2, pitch+12, velocity);
}
void mouseReleased() {
  int channel = 0;
  int pitch = 60;
  int velocity = 127;
  
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
  myBus.sendNoteOff(channel+1, pitch+4, velocity);
  myBus.sendNoteOff(channel+2, pitch+7, velocity);
  myBus.sendNoteOff(channel+2, pitch+12, velocity);
  //delay(2000);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  if (debugMode) {
    println();
    println("Note On:");
    println("--------");
    println("Channel:"+channel);
    println("Pitch:"+pitch);
    println("Velocity:"+velocity);
  }
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  if (debugMode) {
    println();
    println("Note Off:");
    println("--------");
    println("Channel:"+channel);
    println("Pitch:"+pitch);
    println("Velocity:"+velocity);
  }
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  if (debugMode) {
    println();
    println("Controller Change:");
    println("--------");
    println("Channel:"+channel);
    println("Number:"+number);
    println("Value:"+value);
  }
}
