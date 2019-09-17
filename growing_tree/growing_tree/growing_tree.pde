//references: https://processing.org/examples/tree.html, openprocessing.org trees

class pathfinder {
  
  PVector location;
  PVector velocity;
  float diameter;
  float opacity;
  
  pathfinder() {
    location = new PVector(random(10, width), height);
    velocity = new PVector(0, -1);
    diameter = 20;
    opacity = 255;
  }
  
  pathfinder(pathfinder parent) {
    location = parent.location.get();
    velocity = parent.velocity.get();
    float area = PI*sq(parent.diameter/2);
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
        paths = (pathfinder[]) append(paths, new pathfinder(this));
      }
    }
  }
}

pathfinder[] paths;

void setup() {
  fullScreen();
  background(255);
  ellipseMode(CENTER);
  fill(0);
  noStroke();
  smooth();
  paths = new pathfinder[1];
  paths[0] = new pathfinder();
}

void draw() {
    for (int i=0;i<paths.length;i++) {
    PVector loc = paths[i].location;
    float diam = paths[i].diameter;
    ellipse(loc.x, loc.y, diam, diam);
    paths[i].update();
  }
  if (frameCount % 1200 == 0){
   paths = new pathfinder[1];
  paths[0] = new pathfinder();
  }
}
