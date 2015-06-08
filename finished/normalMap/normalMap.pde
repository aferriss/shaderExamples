PShader shader;
PImage img;

void setup(){
  size(1280,640, P2D);
  img = loadImage("img.jpg");
  
  shader = loadShader("normal.glsl");
  shader.set("res", float(width), float(height));
  shader.set("tex", img);
  noStroke();
}

void draw(){
  shader.set("normalAmt", map(mouseX, 0, width, 1 , 150) );
  shader(shader);
  
  rect(0,0,width, height);
}