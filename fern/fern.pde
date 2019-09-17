//reference: https://processing.org/examples/tree.html

float theta;
float rando;

void setup() {
fullScreen();
}

void draw() {
  background(255);
  frameRate(.5);
  stroke(0);
  rando = random(90);
  float a = rando;
  theta = radians(a);
  translate(random(width), random(height));
  line(0,0,0,-120);
  translate(0,-120);
  branch(120);

}

void branch(float h) {

  h *= 0.66;
  
  if (h > 2) {
    pushMatrix();
    rotate(theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
    
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}
