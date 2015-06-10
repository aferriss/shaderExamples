import processing.video.*; //<>// //<>//

Capture cam;

PShader diff;

int maxFrames =2;
boolean doShader = false;

PImage[] frames = new PImage[maxFrames];
int inc = 0;
int texIndex = 0;
int pastIndex = 1;


void setup() {
  size(1280, 720, P2D);

  diff = loadShader("diff.glsl");

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


  noStroke();
}

void draw() {

  if (cam.available() == true) {
    cam.read();

    frames[texIndex] = cam.copy();
    texIndex = (texIndex + 1) % frames.length;
    pastIndex = (pastIndex + 1) % frames.length;

    if (doShader) {
      diff.set("lastFrame", frames[pastIndex]);
      diff.set("srcTex", frames[texIndex]);
    } else {
      diff.set("lastFrame", cam);
      diff.set("srcTex", cam);

      for (int i = 0; i<frames.length; i++) {
        //fill array with frames from cam initially
        frames[i] = cam.copy();
      }
      doShader = true;
    }
  }
  
  shader(diff);
  rect(0, 0, width, height);
}