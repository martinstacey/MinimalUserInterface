class Click {
  PVector pos, size, mid, end;
  String name;
  boolean state, displaystate;
  int type = 0;
  int icon = 0;
  float textsize = 12;
  float scand = 1;
  color con = 200;
  color coff = 100;
  Click(PVector _pos, PVector _size, String _name, int _type) {
    pos=_pos;
    size=_size;
    calcpos();
    name = _name;
    type = _type;
  }
  void calcpos() {
    mid = new PVector(pos.x+size.x/2, pos.y+size.y/2);
    end = new PVector(pos.x+size.x, pos.y+size.y);
  }
  void scaletoandroid(float _scand) {
    scand = _scand;
    pos  = new PVector (scand*pos.x, scand*pos.y);
    size  = new PVector (scand*size.x, scand*size.y);
    mid  = new PVector (scand*mid.x, scand*mid.y);
    end  = new PVector (scand*end.x, scand*end.y);
    textsize = textsize * scand;
  }
  void display() {
    pushStyle();
    rectMode(CORNER);
    textAlign(CENTER, CENTER);
    textSize(textsize);
    stroke(coff);
    strokeWeight(1*scand);
    noFill();
    if (frameCount%30==0) displaystate = false;
    if (isover()) strokeWeight(2*scand);
    if (type==10||type==11) {                              //boton vacio texto afuera derecha = 0 abajo =1
      if (displaystate)  noStroke();
      if (displaystate)  fill(con);
      ellipse(mid.x, mid.y, size.x, size.y);
      fill(coff);
      noStroke();
      if (type==10) textAlign(LEFT, CENTER);
      if (type==10) text(name, end.x+(size.x*.3), mid.y);
      if (type==11) textAlign(CENTER, CENTER);
      if (type==11) text(name, mid.x, end.y+(textsize*.8));
      stroke(coff);
    }

    if (type==20||type==21) {                            // //boton redondeado =20 redondeado cuadrado =21 vacio texto adentro
      stroke(coff);
      if (displaystate)  noStroke();
      if (displaystate)  fill(con);
      if (type==20) rect(pos.x, pos.y, size.x, size.y, size.y/2);
      if (type==21) rect(pos.x, pos.y, size.x, size.y, size.y/4);
      textAlign(CENTER, CENTER);
      if (displaystate)  fill(255);
      else fill(coff);
      noStroke();
      text(name, mid.x, mid.y);
    }
    if (type==30||type==31) {                            //boton icono texto abajo
      if (displaystate)  noStroke();
      if (displaystate)  fill(con);
      ellipse(mid.x, mid.y, size.x, size.y);
      if (displaystate) fill(255);
      if (!displaystate) fill(coff);
      drawicon(icon, mid, size);
      fill(coff);
      if (displaystate) fill(con);
      if (type==30) textAlign(CENTER, CENTER);
      noStroke();
      if (type==30)text(name, mid.x, end.y+size.y*.15);
      if (type==31) textAlign(LEFT, CENTER);
      if (type==31) if (isover())text(name, end.x+size.x*.2, mid.y);
    }
    if (type==32) {                              //boton solo icono
      if (displaystate)  noStroke();
      if (displaystate)  fill(con);
      if (!displaystate) fill(coff);
      drawicon(icon, mid, size);
    }
    if (type==40) {                             //solo texto aparece boton
      stroke(coff);
      if (displaystate)  noStroke();
      if (displaystate)  fill(con);
      if (displaystate) rect(pos.x, pos.y, size.x, size.y, size.y/4);
      textAlign(CENTER, CENTER);
      if (displaystate)  fill(255);
      else fill(coff);
      noStroke();
      text(name, mid.x, mid.y);
    }
    if (type==41) {                                  //texto sobre linea
      textAlign(CENTER, CENTER);
      if (displaystate)  fill(con);
      else fill(coff);
      if (isover()) strokeWeight(2*scand);
      else strokeWeight(1*scand);
      noStroke();
      text(name, mid.x, mid.y); 
      line(pos.x, end.y, end.x, end.y);
    }
    strokeWeight(1*scand);
    popStyle();
  }

  boolean isover() {
    return  (mouseX > pos.x && mouseX < end.x  &&mouseY >pos.y && mouseY < end.y);
  }
  boolean isoverandpressed() {
    return  (isover()&&mousePressed == true);
  }
  void presson() {
    if (isover()) state = true;
    if (isover()) displaystate = true;
  }
  void pressoff() {
    if (isover()) state = false;
  }
}
