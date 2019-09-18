//references: https://processing.org/examples/tree.html, openprocessing.org trees

class Pathfinder {
  
  PVector location;
  PVector velocity;
  float diameter;
  
  Pathfinder() {
    location = new PVector(random(10, width), height);
    velocity = new PVector(0, -1);
    diameter = 20;
  }
  
  Pathfinder(Pathfinder parent) {
    location = parent.location.get();
    velocity = parent.velocity.get();
    float area = PI*sq(parent.diameter/2); // just used in the new diameter calculation
    float newDiam = sqrt(area/2/PI)*2;
    diameter = newDiam;
    parent.diameter = newDiam;
  }
  
  void update() {
    if (diameter>0.5) {
      location.add(velocity);
      PVector bump = new PVector(random(-1, 1), random(-1, 1));
      bump.mult(0.1);
      velocity.add(bump);
      velocity.normalize();
      if (random(0, 1)<0.02) {
        paths = (Pathfinder[]) append(paths, new Pathfinder(this));
      }
    }
  }
  
}

Pathfinder[] paths;

void setup() {
  fullScreen();
  background(255, 255, 251);
  ellipseMode(CENTER);
  fill(0);
  noStroke();
  smooth();
  paths = new Pathfinder[1];
  paths[0] = new Pathfinder();
}

void draw() {
    for (int i=0;i<paths.length; i++) {
    PVector loc = paths[i].location;  
    float diam = paths[i].diameter;
    ellipse(loc.x, loc.y, diam, diam);
    paths[i ].update();
  }
  if (frameCount % 1020 == 0){
  paths = new Pathfinder[1];
  paths[0] = new Pathfinder();
  }
  //clear the screen at a random interval
  
  if (frameCount % 61200 == 0){
    background(255, 255, 251, 5);
  }
  
}
