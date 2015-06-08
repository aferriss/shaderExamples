//Press Spacebar to cycle convolution filters
int mode = 0;
String filterType = "emboss";
PShader shader;
PImage img;
PGraphics layer;
PGraphics layer2;
float[] values = {
 0.0,  0.5001,  0.0,
 0.0, -0.25,  0.0,
 0.0, -0.25, 0.0
};


void setup(){
  size(640,360, P2D);
  layer = createGraphics(width, height, P3D);
  layer2 = createGraphics(width, height, P2D);
  shader = loadShader("feedback.glsl");
  img = loadImage("img.jpg");
  
  shader.set("srcTex", img);
  shader.set("step", 2/width, 2/height);
  
  noStroke();
}

void draw(){
  shader.set("values", values);
  
  layer.beginDraw();
  layer.shader(shader);
  //layer.translate(width, height, 0.5);
  layer.translate(width/2, height/2, 0.75);
  layer.scale(1,-1);
  layer.rect(-width/2,-height/2,width, height);
  layer.endDraw();
  
  layer2.beginDraw();
    layer2.image(layer,0,0);
  layer2.endDraw();
  
  image(layer2, 0,0);
  
  //send the pgraphics layer back to the shader as a new texture
  shader.set("srcTex", layer);
  
  pushStyle();
  fill(255);
  stroke(255);
  text(filterType, 10,20);
  popStyle();
  
  if(frameCount %2 == 0){
    mode = 3;
    shader.set("step", 1.5/width, 1.5/height);
  } else{
    
    mode = 0;
    shader.set("step", 10.5/width, 10.5/height);
  }
  
  if(mode == 0){
   filterType = "Emboss";
   values[0] = 0.0;  values[1] = 0.0501;  values[2] = 0.0;
   values[3] = 0.0;  values[4] = -0.025;  values[5] = 0.0;
   values[6] = 0.0;  values[7] = -0.025;  values[8] = 0.0;
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

void keyPressed(){
 if(key == ' '){
   mode++;
 }
 if(mode > 3){
   mode = 0;
 }
 
 
 

}