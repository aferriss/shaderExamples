PShader shader;
PImage img;

void setup(){
 size(640,360, P2D);
 shader = loadShader("textureExample.glsl"); 
 img = loadImage("plants.png");
 noStroke();
}

void draw(){
  //set the uniform srcTex equal to the img file
  shader.set("srcTex", img);

  shader(shader);
  rect(0,0,width, height);
}
