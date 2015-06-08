PShader shader;
PImage img;
float inc = 0;

void setup(){
  size(640,360, P2D);
  shader = loadShader("colorShift.glsl");
  img = loadImage("img.jpg");
  shader.set("srcTex", img);

  noStroke();
}

void draw(){
  shader.set("time", inc);
  inc+= 0.01;
  
  shader(shader);
  rect(0,0,width, height);
}