//made my Micah Tien fr fr ong fr ong ong fr ong fr 
// slash j
class Scrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  String phase, parameter, txt;
  int rangeOne, rangeTwo; // range of values i want to display
  Scrollbar (float xp, float yp, int sw, int sh, String phase, String parameter, int rangeOne, int rangeTwo) {
    this.phase = phase;
    this.parameter = parameter;
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    this.rangeOne = rangeOne;
    this.rangeTwo = rangeTwo;
    this.txt = "";
  }
  
  void update() {
    if (hover()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos);
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean hover() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
      mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    txt = str(round(map(spos, xpos, xpos+swidth-sheight, rangeOne, rangeTwo)));
    if (this.parameter == "measures") {
      txt = str(round(float(txt)*4));
    }
    text(txt + " " + parameter, xpos+swidth/2, ypos-sheight);
    if (this.parameter != "measures") {
    text(rangeTwo, xpos+swidth+sheight, ypos+sheight*(.65));
    text(rangeOne, xpos-sheight, ypos+sheight*(.65));
    }
    noStroke();
    fill(#5f757a);
    rect(xpos, ypos, swidth, sheight,20);
    if (locked) {
      fill(#9ab0b5);
    } else {
      
      fill(#8da1a6);
      
    }
    
    circle(spos+sheight/2, ypos+sheight/2, sheight+sheight/2);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
