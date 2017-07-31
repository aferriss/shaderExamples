import processing.video.*;  //<>//

Capture cam;

PShader diff;
PGraphics lastFrame;


void setup() {
  size(1280, 720, P2D);

  // load the frag shader from file
  diff = loadShader("diff.glsl");
  
  // set up our PGraphics last frame
  lastFrame = createGraphics(width, height, P2D);
  
  // get the camera
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

  // check if the camera is ready
  if (cam.available() == true) {
    cam.read();
      // set the uniforms
      diff.set("lastFrame", lastFrame);
      diff.set("srcTex", cam);
  }
  
  // use the shader
  shader(diff);
  rect(0, 0, width, height);
  
  // reset shader is required to make this work
  // otherwise lastFrame tries to use our diff shader
  // assuming that this is just unbinding the currently bound shader
  resetShader();
  
  // draw the current frame into PGraphics to be used as the prev frame next go round
  lastFrame.beginDraw();
    lastFrame.image(cam, 0,0);
  lastFrame.endDraw();
}