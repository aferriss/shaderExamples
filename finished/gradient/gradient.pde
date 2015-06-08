PShader gradientShader;

void setup(){
 //P2D renderer required for shaders
 size(640,360, P2D);
 //load shader file from data folder
 redShader = loadShader("gradient.glsl"); 
}

void draw(){
  //anything drawn after the shader call will be affected by it
  shader(redShader);
  rect(0,0,width, height);
}
