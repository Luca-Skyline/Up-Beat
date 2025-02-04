//import statements for MIDI, scanners, etc. here

String globalPhase;
//could be much more options - options would be 
//the genre(?) or type of song (symphony etc.)
boolean pop; // pop
boolean classical; // classical
Button[] buttons = new Button[6];
PImage logo;
PFont pixel;


Song[] mySongs;


//     TO DO : slider for chaos level and tempo, buttons for key and 
//             time signature and type of song (classical/pop for now) ;p
//          
void setup() {
  size(1200,700);
  logo = loadImage("UpBeatLogo.png");
  logo.resize(350,350);
  pixel = createFont("pixel.ttf",30);
  textFont(pixel);
  textAlign(CENTER);
  imageMode(CENTER);
  textSize(25); 
  globalPhase = "mainMenu";
  //this list of buttons and later sliders and stuff is going to be SUPER long uhm ;-;
  buttons[0] = new Button(750, 200, 250, 70, "Generate New Song", "mainMenu", "q1", "newSong");
  buttons[1] = new Button(750, 350, 250, 70, "Load Old Song", "mainMenu", "old", "oldSong");
  buttons[2] = new Button(750, 500, 250, 70, "Settings", "mainMenu", "settings", "TEMP");
  
  buttons[3] = new Button(200, 350, 250, 70, "Classical Song", "q1", "q2", "classical");
  buttons[4] = new Button(500, 350, 250, 70, "Pop Song", "q1", "q2", "pop");
  buttons[5] = new Button(800, 350, 250, 70, "Mr. Skyline", "q1", "q2", "skyline");
  
  //buttons[6] = new Button(350, 100, 100, 60, "test", "q2", "q3", "tempo");
  //buttons[7] = new Button(350, 200, 100, 60, "test #2", "q2", "q3", "tempo");

  pop = false;  
  classical = false;
  stroke(#1D201F);
  //mySongs = new Song[2];
  //mySongs[0] = new ClassicalSong();
  //mySongs[1] = new PopSong();
  
  lucaTest();
}


void draw() {
  //gradients are complicated, apparently T-T
  //this makes fading transitions???? but like it doesnt completely disappear 
  //for some reason
  for (int i = 0; i <= width; i++) {
      float inter = map(i, 0, width, 0, 1);
      color c = lerpColor(color(0), color(160), inter);
      stroke(c);
      line(i, 0, i, height);
    }
  strokeWeight(0);
  fill(255,0,0); 
  quad(700,0,width,0,width,height,500,height);
  fill(155,0,0);
  quad(950,0,width,0,width,height,750,height);
  fill(255);
  quad(500,height,520,height,720,0,700,0);
  //case switch statement would be ideal for "phases" or screens
  if (globalPhase == "mainMenu") {
  textSize(80);
  text("Welcome to", 300, 150); 
  textSize(30);
  image(logo, 300,400);
  }
  
  //rendering buttons -z
    for (int i=0; i<buttons.length; i++) {
     if (globalPhase == buttons[i].localPhase) {
       buttons[i].display();
       buttons[i].hover(mouseX, mouseY);
     }
   }
  
  //1st question -z
  //make this a case switch statement
  if (globalPhase == "q1") {
    text("What genre of song would you like your song to be?", width/2, 200);
  }
  if (globalPhase == "q2") {
   fill(255);
   textSize(30);
   text("Choose your settings for the song you want to make", 425, 50); 
   textSize(18);
   text("How long would you like your song to be?", width/2, 80);
   text("10 measures", 100, 120);
   text("20 measures", 300, 120);
   text("30 measures", 500, 120);
   text("40 measures", 700, 120);
   text("what tempo would you like your song to be?", width/2, 180);
   text("80 bpm", 100, 250);
   text("100 bpm", 300, 250);
   text("120 bpm", 500, 250);
   text("140 bpm", 700, 250);
 
   //will NOT include other options as we develop 
   //we'll then take all the requirements and generate a song along these guidelines
   //then output that to the user
   
   
  }
}

//this is Luca's way to test his stuff in the console for rn so he can have an entry point.
void lucaTest(){
  Jingle j = new Jingle("A#", 4);
  j.printScale();
}

//makes it so clicking buttons does stuff!! :)
void mousePressed() {
 for (int i=0; i<buttons.length; i++) {
     if (globalPhase == buttons[i].localPhase) {
       globalPhase = buttons[i].inside();
     }
   }
  
}
