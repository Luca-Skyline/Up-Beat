//created by Micah Tien
class InfoBubble {
  private float xpos, ypos, radius;
  private String text, phase;
  
  public InfoBubble(float xpos, float ypos, float radius, String text, String phase) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.radius = radius;
    this.text = text;
    this.phase = phase;
  }
  
  public void display() {
    //display bubble
    push();
    noFill();
    strokeWeight(2);
    stroke(0);
    ellipseMode(RADIUS);
    circle(this.xpos, this.ypos, this.radius);
    fill(0);
    textSize(18);
    textAlign(CENTER);
    text("i", this.xpos, this.ypos+8);
    pop();
    
    //display text box
    if (dist(mouseX, mouseY, this.xpos, this.ypos) <= this.radius) {
      int margin = 10;    //how far the box is from the top of the bubble
      int boxHeight = 80; //how tall the box is
      int boxWidth = 230; //how wide the box is
      int cornerRounding = 10;
      push();
      fill(255);
      rect(this.xpos-this.radius, this.ypos-this.radius-margin-boxHeight, boxWidth, boxHeight, cornerRounding);
      fill(0);
      textSize(18);
      text(this.text, this.xpos+105, this.ypos-this.radius-boxHeight+15);
      pop();
    }
  }
}
