class Button {
  //m,
  int x, y, w, h, phase;
  String text;
  color c1, c2;
  boolean on; // whether or not the mouse is over it

  // Constructador
  Button(int x, int y, int w, int h, String text,  int phase) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    this.phase = phase;
    c1 = color(#DF928E);
    c2 = color(#C58882);
    on = false;
  }

  void display() {
    if (on) {
      fill(c2);
    } else {
      fill(c1);
    }
    rect(x, y, w, h, 8);
    fill(0);
   // textAlign(CENTER);
    //textSize();
    text(text, x+30, y+35);
    
  }

  void hover(int mx, int my) {
    on = (mx > x && mx < x+w && my > y && my < y+60);
  }
}
