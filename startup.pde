

void startup(){
  background(mint);
  float overallHeight = character.height + 50 + 32; // 32 = textHeight - because textSize = 32
  image(character, halfWidth - (character.width/2), halfHeight - (overallHeight/2));
  
  textFont(cheri);
  textSize(32);
  textAlign(CENTER);
  text("Press to start!", halfWidth, halfHeight - (overallHeight/2) + character.height + 50);
}

Boolean prevBtnHover(){
  if (currentMode == 0){
    return false;
  }
  
  if (pmouseX > prev_buttonX && pmouseX < (prev_buttonX + prev_button_width) &&
      pmouseY > prev_buttonY && pmouseY < (prev_buttonY + options_height)){
    return true;
  } else {
    return false;
  }
  
}

void drawPrevBtn(){
  
  prev_buttonX = 8;
  prev_buttonY = height - 8 - options_height;
  
  if (prevBtnHover()){
    fill(dark_mint);
    rect(prev_buttonX, prev_buttonY, prev_button_width, options_height, 7); 
        
    textAlign(CENTER);
    fill(255);
    text("PREV", prev_buttonX + (prev_button_width/2), prev_buttonY + optionText_diff);
    
    if (!otherOptionSound){
      buttonEffect(true);
      prevBtnSound = true;
    }
        
  } else {
    
    fill(255);
    
    // || (currentMode == 4 && !sampleSelected)
    if(currentMode >= 5){
      fill(mint);
    }
    rect(prev_buttonX, prev_buttonY, prev_button_width, options_height, 7); 
        
    textAlign(CENTER);
    fill(mint);
    if(currentMode >= 5){
      fill(255);
    }
    text("PREV", prev_buttonX + (prev_button_width/2), prev_buttonY + optionText_diff);
    
    if (!otherOptionSound){
      buttonEffect(false);
      prevBtnSound = false;
    }
  }
  fill(255);
}

void previousBtn(){
  if (currentMode == 1){
    println("prevBtn to 0");
    currentMode = 0;
  } else if (currentMode == 2){
    println("prevBtn to 1");
    currentMode = 1;
  } else if (currentMode >= 3){
    println("prevBtn to 2");
    currentMode = 2;
    profile_done = false;
    selected = false;
    faceClicked = false;
    imageInputted = false;
    profileImageAdjusted = false;
    cp5Pointer = 0;
    notePointer = 0;
    sampleSelected = false;
    fileX = 0;
    fileY = 0;
    genderMode = -1; 
    for(int i = 0; i < userInfo.length; i++){
      userInfo[i] = "";
    }
  }
}

Boolean resetBtnHover(){
  if (pmouseX > reset_buttonX && pmouseX < (reset_buttonX + next_button_width) &&
      pmouseY > reset_buttonY && pmouseY < (reset_buttonY + options_height)){
    return true;
  } else {
    return false;
  }
  
}

void drawResetBtn(){
  reset_buttonX = prev_buttonX + prev_button_width + (prev_buttonX - boxX);
  reset_buttonY = height - 8 - options_height;
  
  if (resetBtnHover()){
    fill(dark_mint);
    rect(reset_buttonX, reset_buttonY, next_button_width, options_height, 7); 
        
    textAlign(CENTER);
    fill(255);
    text("Re-set Info", reset_buttonX + (next_button_width/2), reset_buttonY + optionText_diff);
        
  } else {
    
    fill(mint);
    rect(reset_buttonX, reset_buttonY, next_button_width, options_height, 7); 
        
    textAlign(CENTER);
    fill(mint);
    if(currentMode >= 5){
      fill(255);
    }
    text("Re-set Info", reset_buttonX + (next_button_width/2), reset_buttonY + optionText_diff);

  }
  fill(255);
}

Boolean rewindBtnHover(){
  if (pmouseX > rewind_buttonX && pmouseX < (rewind_buttonX + next_button_width) &&
      pmouseY > rewind_buttonY && pmouseY < (rewind_buttonY + options_height)){
    return true;
  } else {
    return false;
  }
}

void drawRewindBtn(){
  rewind_buttonX = reset_buttonX + next_button_width + (prev_buttonX - boxX);
  rewind_buttonY = height - 8 - options_height;
  
  if (rewindBtnHover()){
    fill(dark_mint);
    rect(rewind_buttonX, rewind_buttonY, next_button_width, options_height, 7); 
        
    textAlign(CENTER);
    fill(255);
    text("Rewind", rewind_buttonX + (next_button_width/2), rewind_buttonY + optionText_diff);
        
  } else {
    
    fill(mint);
    rect(rewind_buttonX, rewind_buttonY, next_button_width, options_height, 7); 
        
    textAlign(CENTER);
    fill(mint);
    if(currentMode >= 5){
      fill(255);
    }
    text("Rewind", rewind_buttonX + (next_button_width/2), rewind_buttonY + optionText_diff);

  }
  fill(255);
  
}

void musicRewind(){
  playBtnMode = 1;
  notePointer = 0;
  
  for (int i = 0; i < soundFile.length; i++){
    soundFile[i].rewind();
  }
}
