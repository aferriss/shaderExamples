PShader shader;
PImage img;
float inc = 0;
float amplitude = 0.05;
float frequency = 20.0;

void setup(){
  size(640,360, P2D);
  shader = loadShader("sine.glsl");
  img = loadImage("img.jpg");
  shader.set("srcTex", img);
  shader.set("amplitude", amplitude);
  shader.set("frequency", frequency);
  noStroke();
}

void draw(){
  shader.set("time", inc);
  inc+= 0.05;
  
  shader(shader);
  rect(0,0,width, height);
}