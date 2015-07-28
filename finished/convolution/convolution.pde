//Press Spacebar to cycle convolution filters
int mode = 0;

String filterType = "emboss";
PShader shader;
PImage img;
PGraphics layer;
float[] values = {
 3.0,  0.0,  0.0,
 0.0, -1.0,  0.0,
 0.0,  0.0, -1.0
};

void setup(){
  size(640,360, P2D);
  layer = createGraphics(width, height, P2D);
  
  shader = loadShader("convolution.glsl");
  img = loadImage("img.jpg");
  
  shader.set("srcTex", img);
  shader.set("step", 1.0/width, 1.0/height);
  
  noStroke();
  
  
}

void draw(){
  shader.set("values", values);
    
  layer.beginDraw();
    layer.shader(shader);
    layer.rect(0,0,width, height);
  layer.endDraw();
  
  image(layer, 0,0);
  
  pushStyle();
  fill(255);
  stroke(255);
  text(filterType, 10,20);
  popStyle();
}

void keyPressed(){
 if(key == ' '){
   mode++;
 }
 if(mode > 3){
   mode = 0;
 }
 
 if(mode == 0){
   filterType = "Emboss";
   values[0] = 3.0;  values[1] = 0.0;  values[2] = 0.0;
   values[3] = 0.0;  values[4] = -1.0;  values[5] = 0.0;
   values[6] = 0.0;  values[7] = 0.0;  values[8] = -1.0;
 } else if(mode == 1){
   filterType = "Sharpen";
   values[0] = -1.0;  values[1] = -1.0;  values[2] = -1.0;
   values[3] = -1.0;  values[4] = 9.0;  values[5] = -1.0;
   values[6] = -1.0;  values[7] = -1.0;  values[8] = -1.0;
 } else if(mode == 2){
   filterType = "Edge Detect";
   values[0] = -1.0;  values[1] = -1.0;  values[2] = -1.0;
   values[3] = -1.0;  values[4] = 8.0;  values[5] = -1.0;
   values[6] = -1.0;  values[7] = -1.0;  values[8] = -1.0;
 } else if(mode == 3){
   filterType = "Blur";
   values[0] = 0.111;  values[1] = 0.111;  values[2] = 0.111;
   values[3] = 0.111;  values[4] = 0.111;  values[5] = 0.111;
   values[6] = 0.111;  values[7] = 0.111;  values[8] = 0.111;
 }

}