void drawicon(int icon, PVector pos, PVector size) {
  if (icon==0) { 
    pushMatrix();
    rect(pos.x-size.x*.35, pos.y, size.x*.7, size.y*.1, size.y*.1);
    translate(pos.x-size.x*.3, pos.y+size.y*.05);
    rotate(QUARTER_PI);
    translate(-pos.x+size.x*.3, -pos.y-size.y*.05);
    rect(pos.x-size.x*.3, pos.y, size.x*.4, size.y*.1, size.y*.1);
    translate(pos.x-size.x*.3, pos.y+size.y*.05);
    rotate(-2*QUARTER_PI);
    translate(-pos.x+size.x*.3, -pos.y-size.y*.05);
    rect(pos.x-size.x*.3, pos.y, size.x*.4, size.y*.1, size.y*.1);
    popMatrix();
  }
  if (icon==1) {  //INFORMATION
    rectMode(CENTER);
    ellipse(pos.x, pos.y-size.y*.3, size.y*.1, size.y*.1);
    rect(pos.x, pos.y+size.y*.1, size.x*.1, size.y*.5, size.y*.1);
    rect(pos.x-size.x*.1, pos.y-size.y*.1, size.x*.2, size.y*.1, size.y*.1);
    rectMode(CORNER);
  }
  if (icon==2) { //PLUS
    rect(pos.x-size.x*.4, pos.y-size.y*.05, size.x*.8, size.y*.1, size.y*.1);
    rect(pos.x-size.x*.05, pos.y-size.y*.4, size.x*.1, size.y*.8, size.y*.1);
  }
  if (icon==3) {  // SAVED MOUSE
    pushMatrix();
    rect(pos.x-size.x*.05, pos.y-size.y*.3, size.y*.1, size.y*.4, size.y*.1);
    rect(pos.x-size.x*.35, pos.y+size.y*.2, size.x*.7, size.y*.1, size.y*.1);
    translate(size.x*.3, -size.y*.4);
    translate(pos.x-size.x*.3, pos.y+size.y*.05);
    rotate(HALF_PI);
    rotate(QUARTER_PI);
    translate(-pos.x+size.x*.3, -pos.y-size.y*.05);
    rect(pos.x-size.x*.3, pos.y, size.x*.4, size.y*.1, size.y*.1);
    translate(pos.x-size.x*.3, pos.y+size.y*.05);
    rotate(-2*QUARTER_PI);
    translate(-pos.x+size.x*.3, -pos.y-size.y*.05);
    rect(pos.x-size.x*.35, pos.y, size.x*.4, size.y*.1, size.y*.1);
    popMatrix();
  }
  if (icon==4) {       //HOME
    pushMatrix();
    rect(pos.x-size.x*.3, pos.y-size.y*+.15, size.y*.1, size.y*.3, size.y*.1);
    rect(pos.x+size.x*.18, pos.y-size.y*+.15, size.y*.1, size.y*.3, size.y*.1);
    rect(pos.x-size.x*.35, pos.y+size.y*.2, size.x*.7, size.y*.1, size.y*.1);
    translate(size.x*.3, -size.y*.4);
    translate(pos.x-size.x*.3, pos.y+size.y*.05);
    rotate(HALF_PI);
    rotate(QUARTER_PI);
    translate(-pos.x+size.x*.3, -pos.y-size.y*.05);
    rect(pos.x-size.x*.3, pos.y, size.x*.4, size.y*.1, size.y*.1);
    translate(pos.x-size.x*.3, pos.y+size.y*.05);
    rotate(-2*QUARTER_PI);
    translate(-pos.x+size.x*.3, -pos.y-size.y*.03);
    rect(pos.x-size.x*.3, pos.y, size.x*.4, size.y*.1, size.y*.1);
    popMatrix();
  }

  if (icon==5) {  // SAVE
    pushMatrix();
    rect(pos.x-size.x*.05, pos.y-size.y*.4, size.y*.1, size.y*.5, size.y*.1);
    rect(pos.x-size.x*.35, pos.y+size.y*.2, size.x*.7, size.y*.1, size.y*.1);
    translate(size.x*.3, -size.y*.4);
    translate(pos.x-size.x*.3, pos.y+size.y*.50);
    rotate(PI*1.5);
    rotate( QUARTER_PI);
    translate(-pos.x+size.x*.3, -pos.y-size.y*.05);
    rect(pos.x-size.x*.3, pos.y, size.x*.4, size.y*.1, size.y*.1);
    translate(pos.x-size.x*.3, pos.y+size.y*.05);
    rotate( -2*QUARTER_PI);
    translate(-pos.x+size.x*.3, -pos.y-size.y*.05);
    rect(pos.x-size.x*.3, pos.y, size.x*.4, size.y*.1, size.y*.1);
    popMatrix();
  }

  if (icon==6) {  // PENCIL
    pushMatrix();
    translate(pos.x, pos.y);
    rotate( -QUARTER_PI);
    translate(-pos.x, -pos.y);
    rect(pos.x-size.y*.15, pos.y-size.y*.1, size.x*.5, size.y*.15, size.y*.1);
    rotate( QUARTER_PI);
    popMatrix();
    triangle(pos.x-size.x*.2, pos.y+size.x*.15, pos.x-size.x*.2, pos.y+size.x*.2, pos.x-size.x*.15, pos.y+size.x*.2);
  }
  if (icon==7) {  // DELETE HOMES
    pushMatrix();
    translate(pos.x, pos.y);
    rotate( -QUARTER_PI);
    translate(-pos.x, -pos.y);
    rect(pos.x-size.x*.4, pos.y-size.y*.05, size.x*.8, size.y*.1, size.y*.1);
    rect(pos.x-size.x*.05, pos.y-size.y*.4, size.x*.1, size.y*.8, size.y*.1);
    popMatrix();
  }
  if (icon==8) {  // BUY HOME
    pushMatrix();
    translate(pos.x, pos.y);
    rotate( -QUARTER_PI);
    translate(-pos.x, -pos.y);
    translate(-size.x*.1, size.y*.1);
    rect(pos.x-size.y*.15, pos.y-size.y*.05, size.x*.6, size.y*.15, size.y*.1);
    rect(pos.x-size.y*.15, pos.y-size.y*.3, size.x*.15, size.y*.4, size.y*.1);
    popMatrix();
  }

  if (icon==9) { //MINUS
    rect(pos.x-size.x*.4, pos.y-size.y*.05, size.x*.8, size.y*.1, size.y*.1);
    //rect(pos.x-size.x*.05, pos.y-size.y*.4, size.x*.1, size.y*.8, size.y*.1);
  }
  if (icon==10) {  //MORE 3 PUNTOS
    ellipse(pos.x-size.x*.3, pos.y, size.y*.2, size.y*.2);
    ellipse(pos.x, pos.y, size.y*.2, size.y*.2);
    ellipse(pos.x+size.x*.3, pos.y, size.y*.2, size.y*.2);
  }
  if (icon==11) { //ACCOUNT
    rect(pos.x-size.x*.35, pos.y+size.y*.2, size.x*.7, size.y*.1, size.y*.1);
  }
  if (icon==12) {  // GENERATE
    pushMatrix();
    rect(pos.x-size.x*.3, pos.y-size.y*+.15, size.y*.1, size.y*.3, size.y*.1);
    rect(pos.x+size.x*.18, pos.y-size.y*+.15, size.y*.1, size.y*.3, size.y*.1);

    rect(pos.x-size.x*.1, pos.y+size.y*.2, size.x*.3, size.y*.1, size.y*.1);
    rect(pos.x+size.x*.1-size.x*.1, pos.y+size.y*.1, size.x*.1, size.y*.3, size.y*.1);

    translate(size.x*.3, -size.y*.4);
    translate(pos.x-size.x*.3, pos.y+size.y*.05);
    rotate(HALF_PI);
    rotate(QUARTER_PI);
    translate(-pos.x+size.x*.3, -pos.y-size.y*.05);
    rect(pos.x-size.x*.3, pos.y, size.x*.4, size.y*.1, size.y*.1);
    translate(pos.x-size.x*.3, pos.y+size.y*.05);
    rotate(-2*QUARTER_PI);
    translate(-pos.x+size.x*.3, -pos.y-size.y*.03);
    rect(pos.x-size.x*.3, pos.y, size.x*.4, size.y*.1, size.y*.1);
    popMatrix();
  }
  if (icon==13) { //MINUS
    rect(pos.x-size.x*.2, pos.y-size.y*.025, size.x*.4, size.y*.05, size.y*.05);
    //rect(pos.x-size.x*.05, pos.y-size.y*.4, size.x*.1, size.y*.8, size.y*.1);
  }

  if (icon==14) { //PLUS
    rect(pos.x-size.x*.2, pos.y-size.y*.025, size.x*.4, size.y*.05, size.y*.05);
    rect(pos.x-size.x*.025, pos.y-size.y*.2, size.x*.05, size.y*.4, size.y*.05);
  }
  if (icon==15) { //MINUS
    rect(pos.x-size.x*.3, pos.y-size.y*.2, size.x*.6, size.y*.06, size.y*.03);
    rect(pos.x-size.x*.3, pos.y-size.y*.0, size.x*.6, size.y*.06, size.y*.03);
    rect(pos.x-size.x*.3, pos.y+size.y*.2, size.x*.6, size.y*.06, size.y*.03);
    //rect(pos.x-size.x*.05, pos.y-size.y*.4, size.x*.1, size.y*.8, size.y*.1);
  }
    if (icon==16) { //LOCK OPEN
    rect(pos.x-size.x*.25, pos.y-size.y*.1, size.x*.5, size.y*.1, size.y*.05);
    rect(pos.x-size.x*.25, pos.y+size.y*.2, size.x*.5, size.y*.1, size.y*.05);
    rect(pos.x-size.x*.25, pos.y-size.y*.3, size.x*.5, size.y*.1, size.y*.05);
    rect(pos.x-size.x*.25, pos.y-size.y*.3, size.y*.1, size.x*.55, size.y*.05);
    rect(pos.x+size.x*.25-size.x*.1, pos.y-size.y*.1, size.x*.1, size.x*.35, size.y*.05);
    rect(pos.x- size.x*.05, pos.y+size.y*.02, size.x*.1, size.y*.15, size.y*.05);
  }

  if (icon==17) { //LOCK CLOSE
    rect(pos.x-size.x*.25, pos.y-size.y*.1, size.x*.5, size.y*.1, size.y*.05);
    rect(pos.x-size.x*.25, pos.y+size.y*.2, size.x*.5, size.y*.1, size.y*.05);
    rect(pos.x-size.x*.25, pos.y-size.y*.3, size.x*.5, size.y*.1, size.y*.05);
    rect(pos.x-size.x*.25, pos.y-size.y*.3, size.y*.1, size.x*.55, size.y*.05);
    rect(pos.x+size.x*.25-size.x*.1, pos.y-size.y*.3, size.y*.1, size.x*.55, size.y*.05);
    rect(pos.x- size.x*.05, pos.y+size.y*.02, size.x*.1, size.y*.15, size.y*.05);
  }
}

void star5(PVector pos, PVector size) {
  PVector mid = new PVector(pos.x+size.x*.5,pos.y+size.y*.5);
  float angle = TWO_PI / 5;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = mid.x + cos(a) * size.x*.5;
    float sy = mid.y + sin(a) * size.x*.5;
    vertex(sx, sy);
    sx = mid.x + cos(a+halfAngle) * size.x*.25;
    sy = mid.y + sin(a+halfAngle) * size.x*.25;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void starsys(PVector pos, PVector size, int calif, color coff,color con){
  for (int i=0; i<5;i++){
    if (i<calif) fill(con);
    else fill(coff);
   star5(new PVector (pos.x+((size.x/5)*i),pos.y), new PVector (size.y,size.y));   
  }
}
