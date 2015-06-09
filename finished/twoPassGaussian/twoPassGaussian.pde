import processing.video.*;

PShader gaussH;
PShader gaussV;
PGraphics layer1;

Capture cam;

void setup(){
  size(640,360, P2D);
  layer1 = createGraphics(width, height, P2D);
  layer1.noStroke();
  
  gaussH = loadShader("gaussianH.glsl");
  gaussV = loadShader("gaussianV.glsl");
  
  String[] cameras = Capture.list(); 
  cam = new Capture(this, cameras[0]);
  cam.start();
  
  noStroke();
}

void draw(){
  if(cam.available() == true){
     cam.read();
     gaussH.set("step", 1.0/float(width), 1.0/float(height));
     gaussH.set("srcTex", cam);
     
     layer1.beginDraw();
     layer1.shader(gaussH);
     layer1.rect(0,0,width, height);
     layer1.endDraw();
          
     gaussV.set("step", 1.0/float(width), 1.0/float(height));
     gaussV.set("srcTex", layer1);
     shader(gaussV);
     rect(0,0,width, height);
  }
}

