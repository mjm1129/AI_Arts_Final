String[] note = {"C", "D", "E", "F", "G", "A", "B", 
                "C", "D", "E", "F", "G", "A", "B", 
                "C", "D", "E", "F", "G", "A", "B", "C"};
int[] musicArray = new int[0];
int notePointer = 0;

int num_of_infos = 3;

// user info
//String[] userInfo = new String[num_of_infos];
String[] userInfo = {"", "", ""};
int cp5Pointer = 0;
// name, age, gender, email(username), password

// setPositions
String[] guidesName = {"Name:", "Age:", "Gender:"};
int[] guidesY = new int[num_of_infos];
int[] inputFieldY = new int[num_of_infos];

float userInfoX = 0;
float guidesNameX = 0;
float cp5X = 0;
float cp5Y = 0;

float photoX = 15;
float photoY = 62;

float logoY = 10;

float boxX;
float boxY;
float boxWidth;
float boxHeight;

PImage profileImage;

int profileX;
int profileY;
int profileW;
int profileH;

int checkBoxWidth = 20;
float checkBox1X;
float checkBox2X;
float checkBoxY;
float checkBoxTextY;

int imageGap = 15;

int genderMode = -1; // male = 1 | female = 2

// button
  int playBtnMode = 1; // 1 -> play | 2 -> pause

void initializeProfile(){
  cp5Pointer = 0;
  
  for(int i = 0; i < num_of_infos; i++){
    userInfo[i] = "";
  }
}

void makeProfile(){
  screenBtnOn = true;
  drawProfilePage();
  playNote();
  
  if (genderMode != -1){
    playButton();
  }
  
  if (cp5Pointer > 0 || cp5.get(Textfield.class,"textValue").getText() != ""){
    drawResetBtn();
  }
  
  if (notePointer > 0 && playBtnMode == 1){
    drawRewindBtn();
  }
}

void drawProfilePage(){
  // behind part
    background(mint);
    
    image(logo, halfWidth - (logo.width + 0 + textWidth("Profile"))/2, logoY);
    
    fill(255);
    textFont(all_caps);
    textAlign(LEFT, TOP);
    textSize(32);
    text("Profile", halfWidth - (logo.width + 0 + textWidth("Profile"))/2 + logo.width + 0, logoY + (logo.height/2) - 16);
  
  // white box part
    boxWidth = width - 10;
    boxHeight = height - (logoY + logo.height + logoY) - 5;
    boxX = halfWidth - boxWidth/2;
    boxY = logoY + logo.height + logoY;
    
    fill(255);
    rect(boxX, boxY, boxWidth, boxHeight);
    
  drawProfileImage();
  
  fill(0);
  textFont(all_caps);
  textAlign(LEFT, TOP);
  for(int i = 0; i < guidesName.length; i++){
    textSize(20);
    text(guidesName[i], guidesNameX, guidesY[i]);
    text(userInfo[i], userInfoX, guidesY[i]);
  }
  
  // display the text we are writing to the screen
  if (cp5Pointer < num_of_infos - 1){
    cp5.show();
    cp5.setPosition(round(cp5X), round(inputFieldY[cp5Pointer]));
    userInfo[cp5Pointer] = cp5.get(Textfield.class,"textValue").getText();
  } else {
    checkBox();
  }
  
  //if (userInfo[2].toLowerCase() == ""){
  //  genderMode = 1;
  //} else 
}

int checkBoxHover(){
  if (pmouseY > checkBoxY && pmouseY < checkBoxY + checkBoxWidth){
    if (pmouseX > checkBox1X && pmouseX < checkBox1X + checkBoxWidth){
      return 1;
    } else if (pmouseX > checkBox2X && pmouseX < checkBox2X + checkBoxWidth){
      return 2;
    } else {
      return -1;
    }
  } else {
    return -1;
  }
}

void checkBox(){
  if (!profile_done){
    if (checkBoxHover() == 1){
      // option 1
      fill(dark_mint);
      rect(checkBox1X, checkBoxY, checkBoxWidth, checkBoxWidth);
      
      // option 2
      fill(mint);
      rect(checkBox2X, checkBoxY, checkBoxWidth, checkBoxWidth);
      
      image(checkSign, checkBox1X, checkBoxY);
    } else if (checkBoxHover() == 2){
      // option 1
      fill(mint);
      rect(checkBox1X, checkBoxY, checkBoxWidth, checkBoxWidth);
      
      // option 2
      fill(dark_mint);
      rect(checkBox2X, checkBoxY, checkBoxWidth, checkBoxWidth);
      image(checkSign, checkBox2X, checkBoxY);
    } else {
      fill(mint);
      // option 1
      rect(checkBox1X, checkBoxY, checkBoxWidth, checkBoxWidth);
      
      // option 2
      rect(checkBox2X, checkBoxY, checkBoxWidth, checkBoxWidth);
    }
  } else {
    if (genderMode == 1){
      // option 1
      fill(dark_mint);
      rect(checkBox1X, checkBoxY, checkBoxWidth, checkBoxWidth);
      
      // option 2
      fill(mint);
      rect(checkBox2X, checkBoxY, checkBoxWidth, checkBoxWidth);
      
      image(checkSign, checkBox1X, checkBoxY);
    } else if (genderMode == 2){
      // option 1
      fill(mint);
      rect(checkBox1X, checkBoxY, checkBoxWidth, checkBoxWidth);
      
      // option 2
      fill(dark_mint);
      rect(checkBox2X, checkBoxY, checkBoxWidth, checkBoxWidth);
      image(checkSign, checkBox2X, checkBoxY);
    } else {
      fill(mint);
      // option 1
      rect(checkBox1X, checkBoxY, checkBoxWidth, checkBoxWidth);
      
      // option 2
      rect(checkBox2X, checkBoxY, checkBoxWidth, checkBoxWidth);
    }
  }
  
  fill(0);
  text("Male", checkBox1X, checkBoxTextY);
  text("Female", checkBox2X, checkBoxTextY);
  fill(0);
}

void autoSetPos(){
  guidesY[0] = round(photoY + imageGap);
  inputFieldY[0] = round(photoY + imageGap) - 47;
  for (int i = 1; i < num_of_infos; i++){
    guidesY[i] = guidesY[i-1] + 45;
    inputFieldY[i] = inputFieldY[i-1] + 44;
  }
  guidesNameX = round(boxX + profileImage.width + (imageGap * 3));
  userInfoX = guidesNameX + 100;
  cp5X = userInfoX - 22;
  
  play_buttonX = halfWidth - (play_button_width/2);
  play_buttonY = photoY + profileImage.height + (imageGap * 3);
  
  checkBox1X = userInfoX;
  checkBox2X = userInfoX + imageGap + textWidth("Male");
  
  checkBoxY = guidesY[2];
  checkBoxTextY = guidesY[2] + checkBoxWidth + imageGap/2;
}

void drawProfileImage(){
  if (!profileImageAdjusted){
    profileX = round(faceXArray[whichFace]);
    profileY = round(faceYArray[whichFace]);
    profileW = round(faceWArray[whichFace]);
    profileH = round(faceHArray[whichFace]);
    
    
    profileImage = resultImage.get(profileX, profileY, profileW, profileH);
    profileImage.resize(200, 0);
    
    photoX = boxX + imageGap;
    photoY = boxY + imageGap;
    
    autoSetPos();
    profileImageAdjusted = true;
  }
  
  //image(profileImage, photoX, photoY);
  int index = 0;
  textSize(10);
  
  for(int y = 0; y <= profileImage.height-1; y+=8){
    for(int x = 0; x<= profileImage.width-1; x+=8){
      int b = round(brightness(profileImage.get(x, y)));
      
      if (!musicArrayFilled){
        musicArray = append(musicArray, round(b/32));
      }
      
      if ((index-1) == notePointer && notePointer != 0 && playBtnMode == 2){
        fill(red);
      } else {
        fill(profileImage.get(x, y));
      }
      
      text(note[musicArray[index]], photoX + x, photoY + y);
      index++;
    }
  }
  
  musicArrayFilled = true;
  
}

Boolean playBtnHover(){
  if (pmouseX > play_buttonX && pmouseX < (play_buttonX + play_button_width) &&
      pmouseY > play_buttonY && pmouseY < (play_buttonY + options_height)){
    return true;
  } else {
    return false;
  }
}

void playButton(){
  noStroke();
  // current mode = paused
  if (playBtnMode == 1){
    if (playBtnHover()){ // if hovered
      fill(red);
      rect(play_buttonX, play_buttonY, play_button_width, options_height, 7);
      
      fill(255);
      textAlign(CENTER);
      text("Play Music", halfWidth, play_buttonY + optionText_diff);
      fill(255);
      
    } else {            // if not hovered
      fill(light_gray);
      rect(play_buttonX, play_buttonY, play_button_width, options_height, 7);
      
      fill(0);
      textAlign(CENTER);
      text("Play Music", halfWidth, play_buttonY + optionText_diff);
      fill(255);
    }
  }
  
  // current mode = playing
  else {
    if (playBtnHover()){ // if hovered
      fill(red);
      rect(play_buttonX, play_buttonY, play_button_width, options_height, 7);
      
      fill(255);
      textAlign(CENTER);
      text("Pause Music", halfWidth, play_buttonY + optionText_diff);
      fill(255);
      
    } else {            // if not hovered
      fill(light_gray);
      rect(play_buttonX, play_buttonY, play_button_width, options_height, 7);
      
      fill(0);
      textAlign(CENTER);
      text("Pause Music", halfWidth, play_buttonY + optionText_diff);
      fill(255);
    }
  }
}

void playNote(){
  int addingIndex = 0;
  if (genderMode == 2){
    addingIndex = 8;
  }
  
  // if the music finished
  if (notePointer >= musicArray.length - 1){
    if (!soundFile[musicArray[notePointer]+addingIndex].isPlaying()){
      soundFile[musicArray[notePointer]+addingIndex].pause();
    }
    musicRewind();
    //println(notePointer);
  }
  
  if (playBtnMode == 2){
    frameRate(5);
    //print(note[musicArray[notePointer]+addingIndex] + " ");
    // if the note is the same with the prev note 
    if (notePointer == 0 || musicArray[notePointer] == musicArray[notePointer-1]){
      //print("if");
      if (!soundFile[musicArray[notePointer]+addingIndex].isPlaying()){
         //print("-1");
         soundFile[musicArray[notePointer]+addingIndex].rewind();
         soundFile[musicArray[notePointer]+addingIndex].play();
       } 
      
      //// 
      else {
        //print("-2");
        
        soundFile[musicArray[notePointer]+addingIndex].play();
      }
        
    } else {
      //print("else");
      //prevNoteIndex = musicArray[notePointer-1];
      if (soundFile[musicArray[notePointer-1]+addingIndex].isPlaying()){
        print("-1");
        soundFile[musicArray[notePointer-1]+addingIndex].pause();
        soundFile[musicArray[notePointer-1]+addingIndex].rewind();
      }
      soundFile[musicArray[notePointer]+addingIndex].play();
    }
    
    //println(note[musicArray[notePointer]+addingIndex]);
    //delay(500);
    notePointer++;
  } else {
    frameRate(100);
  }
  //println();
}
 
