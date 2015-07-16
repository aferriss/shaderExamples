PShader shader;
PImage img;

void setup(){
  size(640,360, P2D);
  shader = loadShader("rgbShift.glsl");
  img = loadImage("img.jpg");
  shader.set("srcTex", img);

  noStroke();
}

void draw(){  
  shader.set("shift", map(mouseX, 0, width, -0.2,0.2));
  shader(shader);
  rect(0,0,width, height);

}
