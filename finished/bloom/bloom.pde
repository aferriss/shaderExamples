import processing.video.*;

PShader gaussH;
PShader gaussV;
PShader bloom;

PGraphics layer1;
PGraphics layer2;

Capture cam;

void setup(){
  size(640,360, P2D);
  layer1 = createGraphics(width, height, P2D);
  layer1.noStroke();
  
  layer2 = createGraphics(width, height, P2D);
  layer2.noStroke();
  
  gaussH = loadShader("gaussianH.glsl");
  gaussV = loadShader("gaussianV.glsl");
  bloom = loadShader("bloom.glsl");
  
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
     layer1.rect(0,0, width, height);
     layer1.endDraw();
          
     gaussV.set("step", 1.0/float(width), 1.0/float(height));
     gaussV.set("srcTex", layer1);
     
     layer2.beginDraw();
     layer2.shader(gaussV);
     layer2.rect(0,0, width, height);
     layer2.endDraw();
     
     bloom.set("srcTex", cam);
     bloom.set("blurTex", layer2);
     shader(bloom);
     rect(0,0, width, height);
  }
}

