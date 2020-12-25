float overallWidth;
float overallHeight;
float startX;

String hoverMode = "";

//Boolean hideKeys = false;
Boolean imageReady = false;

float fileX = 0;
float fileY = 0;

void inputImageSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("selected " + selection.getAbsolutePath());
    queryImage = loadImage(selection.getAbsolutePath());
    // resize image (adjust as needed)
    
    autoAdjustImage();
    imageInputted = true;

    //queryImage.resize(600,400);
  }
}

void autoAdjustImage(){
  runway.query(queryImage);
  
  println("dataAnalysis(0)[1]:", dataAnalysis(0)[1]);
  println("dataAnalysis(0)[3]", dataAnalysis(0)[3]);
  
  float original = queryImage.width;
  //println("QueryImage width & height", queryImage.width, queryImage.height);
  // if 
  if (queryImage.width > queryImage.height){
    queryImage.resize(0, height);
    //newWidth = queryImage.width;
    //fileY = halfHeight - (queryImage.height/2);
  } else {
    queryImage.resize(width, 0);
    //fileX = halfWidth - (queryImage.width/2);
  }
  
  if (queryImage.width < width){
    queryImage.resize(width, 0);
  } 
  
  else if (queryImage.height < height){
    queryImage.resize(0, height);
  }
  
  float scale = original/ (queryImage.width);
  
  println("dataAnalysis(0)[1]:", dataAnalysis(0)[1] * scale);
  println("dataAnalysis(0)[3]", dataAnalysis(0)[3] * scale);
  println("added:", (dataAnalysis(0)[1] + dataAnalysis(0)[3]));
  
  
  ////println("current width and height:", queryImage.width, queryImage.height);
  
  ////println(newHeight, originalHeight);
  ////float scale = newHeight/originalHeight;
  
  //println("resized:", ((dataAnalysis(0)[1] + dataAnalysis(0)[3]) * scale));
  
  //if (((dataAnalysis(0)[1] + dataAnalysis(0)[3]) * scale) > (height - 30)){
  ////  println("in if");
  //  fileY = height - ((dataAnalysis(0)[1] + dataAnalysis(0)[3]) - height) - 30;
  //}
}

void selectedQuery(){
  background(mint);
  
  overallWidth = (keys_width * 3) + 30 + enterKey.width;
  overallHeight = rightArrow.height * 2;
  startX = halfWidth - overallWidth/2;
  
  if (!imageInputted){
    //print("if-1");
    background(mint);
  }
  else if (screenBtnOn){
    //println("else-if1");
    // Display label image if loaded
    if(queryImage != null){
      //print("-1");
      image(queryImage, fileX, fileY);
    }
    
    hovers();
    
    image(upArrow,   startX + keys_width, height - 8 - overallHeight);
    image(leftArrow, startX, height - 8 - rightArrow.height);
    image(downArrow, startX + keys_width, height - 8 - rightArrow.height);
    image(rightArrow, startX + (keys_width*2), height - 8 - rightArrow.height);
      
    image(enterKey, startX + (keys_width*3) + 30, height - 8 - overallHeight);
  }

  else if (!selected){
    //println("else-if2");
    image(queryImage, fileX, fileY);
    saveFrame("image/result.png");
    selected = true;
    
    resultImage = loadImage("image/result.png");
    runway.query(resultImage);
    
  } else {
    //println("else");
    image(resultImage, 0, 0);
    
    // Display captions
    drawCaptions();
    
    cameraX = halfWidth - (redoKey.width/2);
    cameraY = height - (redoKey.height) - 10;
    
    if (pmouseX > cameraX && pmouseX < (cameraX + cameraWidth) &&
      pmouseY > cameraY && pmouseY < (cameraY + camera.height)){
        redoKey = loadImage("image/key/redoKey-hover.png");
      } else {
        redoKey = loadImage("image/key/redoKey.png");
      }
      
    redoKey.resize(cameraWidth, 0);
    image(redoKey, cameraX, cameraY);
  } 
}

String hovers(){
  initializeKeys();
  // left
  if (pmouseX > startX && pmouseX < startX + keys_width && pmouseY > height - 8 - leftArrow.height && pmouseY < height - 30){
    hoverMode = "left";
    leftArrow = loadImage("image/key/leftArrow-hover.png");
  } 
  
  else if (pmouseX > startX + keys_width && pmouseX < startX + (keys_width*2)){
    
  // up
    if (pmouseY > height - 8 - overallHeight && pmouseY  < height - 8 - upArrow.height){
      hoverMode = "up";
      upArrow = loadImage("image/key/upArrow-hover.png");
    } 
    
  // down
    else if (pmouseY  > height - 8 - upArrow.height && pmouseY < height - 8){
      hoverMode = "down";
      downArrow = loadImage("image/key/downArrow-hover.png");
    }
  } 
  
  // right
  else if (pmouseX > startX + (keys_width*2) && pmouseX < startX + (keys_width*3) && 
  pmouseY  > height - 8 - upArrow.height && pmouseY < height - 8){
    hoverMode = "right";
    rightArrow = loadImage("image/key/rightArrow-hover.png");
  } 
  
  // enter
  else if (pmouseX > startX + (keys_width*3) + 30 && pmouseX < startX + overallWidth && 
  pmouseY > height - 8 - overallHeight && pmouseY < height - 8){
    hoverMode = "enter";
    enterKey = loadImage("image/key/enterKey-hover.png");
  }
  
  keysResize();
  return hoverMode;
}

void initializeKeys(){
  upArrow = loadImage("image/key/upArrow.png");
  leftArrow = loadImage("image/key/leftArrow.png");
  downArrow = loadImage("image/key/downArrow.png");
  rightArrow = loadImage("image/key/rightArrow.png");
  enterKey = loadImage("image/key/enterKey.png");
    
  keysResize();
  
  hoverMode = "none";
}

void keysResize(){
  upArrow.resize(keys_width, 0);
  leftArrow.resize(keys_width, 0);
  downArrow.resize(keys_width, 0);
  rightArrow.resize(keys_width, 0);
  enterKey.resize(0, rightArrow.height * 2);
}
