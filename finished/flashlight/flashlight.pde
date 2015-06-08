PShader shader;
PImage img;

void setup(){
  size(1280,640, P2D);
  img = loadImage("img.jpg");
  
  shader = loadShader("flashlight.glsl");
  shader.set("res", float(width), float(height));
  shader.set("tex", img);
  noStroke();
}

void draw(){
  shader.set("mouse", map(mouseX, 0, width, 0 , 1), map(mouseY, 0 , height, 0 , 1) );
  shader(shader);
  
  rect(0,0,width, height);
}