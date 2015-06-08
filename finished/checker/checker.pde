PShader shader;

void setup(){
  size(640,360, P2D);
  shader = loadShader("checker.glsl");
  
  noStroke();
}

void draw(){
  shader.set("resolution", float(width), float(height));
  shader.set("tileAmt", map(mouseX, 0,width, 2,40));
  shader(shader);
  rect(0,0,width, height);
}