import processing.video.*;

PShader shader;
Capture cam;
float stepVal = 1.0;
float time = 0.0;

void setup(){
  size(640,360, P2D);
  shader = loadShader("glow.glsl");
    
  
  
  String[] cameras = Capture.list(); 
  cam = new Capture(this, cameras[0]);
  cam.start();
  
  noStroke();
}

void draw(){
  if(cam.available() == true){
     cam.read();
     shader.set("step", stepVal/width, stepVal/height);
     shader.set("time", time);
     shader.set("srcTex", cam);
     
     shader(shader);
     rect(0,0,width, height);
  }
  time += 0.01;
  
  //sine wave on the glow thickness
  stepVal = (1+sin(frameCount*0.0125)/2)*2;
}

