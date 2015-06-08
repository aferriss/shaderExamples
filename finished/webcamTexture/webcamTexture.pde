import processing.video.*;

PShader shader;

Capture cam;

void setup(){
 size(640,360, P2D);
 shader = loadShader("webcamExample.glsl");
String[] cameras = Capture.list(); 
 cam = new Capture(this, cameras[0]);
 cam.start();
 noStroke();
}

void draw(){
  if (cam.available() == true) {
    cam.read();
    //set the uniform srcTex equal to the webcam texture
    shader.set("srcTex", cam);
  
    shader(shader);
    rect(0,0,width, height);
  }
  

}
