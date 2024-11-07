//import statements for MIDI, scanners, etc. here

String globalPhase;
//could be much more options - options would be 
//the genre(?) or type of song (symphony etc.)
boolean pop; // pop
boolean classical; // classical
Button[] buttons = new Button[4];

//     TO DO : slider for chaos level and tempo, buttons for key and 
//             time signature and type of song (classical/pop for now) ;p
//          
void setup() {
  size(700,500);
  textSize(25); 
  globalPhase = "mainMenu";
  buttons[0] = new Button(350, 100, 100, 60, "test", "q1");
  buttons[1] = new Button(350, 200, 100, 60, "test #2", "q1");
  buttons[2] = new Button(100, 200, 200, 50, "Pop Song", "mainMenu");
  buttons[3] = new Button(350, 200, 200, 50, "Classical Song", "mainMenu");
  pop = false;  
  classical = false;
  stroke(#1D201F);
}


void draw() {
  background(#E5C3D1);
  fill(#EAD2AC); 
  rect(10,10,680,480,20);
  if (globalPhase == "mainMenu") {
  fill(0); 
  text("Welcome to Beatboxx, our procedural music generator!", 80, 150); 
  }
  
  //rendering buttons
    for (int i=0; i<buttons.length; i++) {
     if (globalPhase == buttons[i].localPhase) {
       buttons[i].display();
       buttons[i].hover(mouseX, mouseY);
     }
   }
  
  //1st question
  if (globalPhase == "q1") {
   fill(0);
   textSize(30);
   text("Choose your settings for the song you want to make", 25, 50); 
   textSize(12);
   text("How long would you like your song to be?", 25, 100);
   text("10 measures", 25, 120);
   text("20 measures", 100, 120);
   text("30 measures", 175, 120);
   text("40 measures", 250, 120);
   text("what tempo would you like your song to be?", 25, 160);
   text("80 bpm", 25, 180);
   text("100 bpm", 100, 180);
   text("120 bpm", 175, 180);
   text("140 bpm", 250, 180);
 
   //will NOT include other options as we develop 
   //we'll then take all the requirements and generate a song along these guidelines
   //then output that to the user
   
   
  }
}
void mousePressed() {
 if (mouseX>400 && mouseX <600 && mouseY>200 && mouseY<250) {
    globalPhase = "q1";
    classical = true; // classical
  }
  if (mouseX>100 && mouseX <300 && mouseY>200 && mouseY<250) {
    pop = true; // pop
    globalPhase = "q1";
   } 
  
}
