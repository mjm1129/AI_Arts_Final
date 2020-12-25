
float cameraX;
float cameraY;
int cameraWidth = 50;


void useWebcam(){  
  background(mint);
  
  cameraX = halfWidth - (cameraImage.width/2);
  cameraY = height - (cameraImage.height) - 10;
  
  if (screenBtnOn){
    camera.read();
    pushMatrix();
    scale(-1,1);
    image(camera, -width, 0);
    popMatrix();
  
    if (pmouseX > cameraX && pmouseX < (cameraX + cameraWidth) &&
      pmouseY > cameraY && pmouseY < (cameraY + camera.height)){
        cameraImage = loadImage("image/camera_hover.png");
      } else {
        cameraImage = loadImage("image/camera.png");
      }
      
    cameraImage.resize(cameraWidth, 0);
    image(cameraImage, cameraX, cameraY);
  } else if (!selected){
    pushMatrix();
    scale(-1,1);
    image(camera, -width, 0);
    popMatrix(); 
    saveFrame("image/result.png");
    selected = true;
    sendFrameToRunway();
  } else {
    resultImage = loadImage("image/result.png");
    image(resultImage, 0, 0);
    
    // Display captions
    drawCaptions();
    
    if (pmouseX > cameraX && pmouseX < (cameraX + cameraWidth) &&
      pmouseY > cameraY && pmouseY < (cameraY + camera.height)){
      retakeKey = loadImage("image/retake-hover.png");
    } else {
      retakeKey = loadImage("image/retake.png");
    }
    retakeKey.resize(cameraWidth, 0);
    image(retakeKey, cameraX, cameraY);
  }
  
  if (!camera_shutter.isPlaying()){
    camera_shutter.rewind();
  }
}
