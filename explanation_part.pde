
void projectExplanation(){
  background(mint);
  
  String explanation = "Welcome to my project!\nIn this project,\nyou can convert a face image to music.";
  float overallHeight = (20 * 3) + 30 + options_height;
  
  next_buttonX = halfWidth - options_width/4;
  next_buttonY = halfHeight - overallHeight/2 + 60 + 30;
  
  textFont(cheri);
  textSize(20);
  textAlign(CENTER);
  noStroke();
  text(explanation, halfWidth, halfHeight - overallHeight/2);
  
  if (pmouseX > next_buttonX && pmouseX < (next_buttonX + next_button_width) &&
    pmouseY > next_buttonY && pmouseY < (next_buttonY + options_height)){      // within the button area
      fill(dark_mint);
      rect(next_buttonX, next_buttonY, options_width/2, options_height, 7);
      
      fill(255);
      textSize(25);
      text("NEXT", halfWidth, halfHeight - overallHeight/2 + 60 + 30 + (2 * options_height/3)); 
      if (!prevBtnSound){
        buttonEffect(true);
        otherOptionSound = true;
      }
  } else {
    // next button
    rect(next_buttonX, next_buttonY, options_width/2, options_height, 7);
    fill(mint);
  
    textSize(25);
    text("NEXT", halfWidth, next_buttonY + optionText_diff);
    fill(255);
    
    if (!prevBtnSound){
      buttonEffect(false);
      otherOptionSound = false;
    }
  }
}
