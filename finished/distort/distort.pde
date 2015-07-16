import processing.video.*;

Capture cam;

PShader shader;
PImage img;

void setup() {
  size(640, 360, P2D);
  shader = loadShader("distort.glsl"); 
  img = loadImage("plants.png");
  noStroke();

  String[] cameras = Capture.list(); 
  if (cameras == null) {
    cam = new Capture(this, 640, 360);
  } 
  if (cameras.length == 0) {
    exit();
  } else {
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    
    //set the uniform srcTex equal to the img file
    shader.set("srcTex", img);
    
    //disTex is the webcam
    shader.set("disTex", cam);
    
    //distortion amount
    shader.set("amt", map(mouseX, 0, width, -3, 3));

    shader(shader);
    rect(0, 0, width, height);
  }
}

