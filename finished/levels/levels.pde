// photoshop style levels controls
// levels shader from:
// https://mouaif.wordpress.com/2009/01/28/levels-control-shader/
// + and - change gamma
// mouseX and mouseY control inputMin and inputMax

PShader levelsShader;
PImage img;
PGraphics shaderLayer;

float gamma;
float inputMin;
float inputMax;

void setup(){
 //P2D renderer required for shaders
 size(640,360, P2D);
 //load shader file from data folder
 img = loadImage("img.jpg");
 
 shaderLayer = createGraphics(width, height, P2D);
 
 levelsShader = loadShader("levels.glsl"); 
 levelsShader.set("srcTex", img);
 
 inputMin = 0;
 gamma = 0.43;
 inputMax = 255;
}

void draw(){
  //anything drawn after the shader call will be affected by it
  inputMin = map(mouseX, 0, width, 0, 255);
  inputMax = map(mouseY, 0, height, 0, 255);
  levelsShader.set("levels", inputMin, gamma, inputMax); 
  
  shaderLayer.beginDraw();
    shaderLayer.shader(levelsShader);
    shaderLayer.rect(0,0,width, height);
  shaderLayer.endDraw();
  
  image(shaderLayer, 0, 0);
  
  //draw the parameters
  fill(0);
  rect(0,0,160, 80);
  fill(255);
  text("Input Min = "+inputMin, 10, 20);
  text("Gamma = "+ gamma, 10, 40);
  text("Input Max = "+ inputMax, 10, 60);
}

void keyPressed(){
 if(key == '=' || key == '+'){
   gamma += 0.01;
 }
 
 if(key == '-' || key == '_'){
   gamma -= 0.01;
 }
}