import processing.video.*;

PShader shader;
Capture cam;

void setup(){
  size(640,360, P2D);
  shader = loadShader("pixelate.glsl");
  
  String[] cameras = Capture.list(); 
  cam = new Capture(this, cameras[0]);
  cam.start();
  
  noStroke();
}

void draw(){
  if(cam.available() == true){
     cam.read();
     shader.set("step", 1.0/float(width), 1.0/float(height));
     shader.set("srcTex", cam);
     
     shader(shader);
     rect(0,0,width, height);
  }
}

