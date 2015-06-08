PShader shader;
PImage img;

void setup(){
  size(1280,640, P2D);
  img = loadImage("img.jpg");
  
  shader = loadShader("bump.glsl");
  shader.set("res", float(width), float(height));
  shader.set("tex", img);
  noStroke();
}
 //<>//
void draw(){
  shader.set("mouse", float(mouseX), float(mouseY) );
  shader(shader);
  
  rect(0,0,width, height);
}