class Toggle {
  PVector pos, size, mid, end, poshide, posshow;
  String name;
  boolean state;
  int type = 0;
  int icon = 0;
  float textsize = 12;
  float scand = 1;
  color con = 200;
  color coff = 100;
  Toggle(PVector _pos, PVector _size, String _name, int _type) {
    pos=_pos;
    size=_size;
    calcpos();
    name = _name;
    type = _type;
    poshide = pos;
    posshow = pos;
  }
  void calcpos() {
    mid = new PVector(pos.x+size.x/2, pos.y+size.y/2);
    end = new PVector(pos.x+size.x, pos.y+size.y);
  }
  void calcposhide(PVector _posshow) {
    poshide = pos;
    posshow = _posshow;
  }
  void scaletoandroid(float _scand) {
    scand = _scand;
    pos  = new PVector (scand*pos.x, scand*pos.y);
    size  = new PVector (scand*size.x, scand*size.y);
    mid  = new PVector (scand*mid.x, scand*mid.y);
    end  = new PVector (scand*end.x, scand*end.y);
    poshide  = new PVector (scand*poshide.x, scand*poshide.y);
    posshow  = new PVector (scand*posshow.x, scand*posshow.y);
    textsize = textsize * scand;
  }
  void display() {
    pushStyle();
    textSize(textsize);
    rectMode(CORNER);


    if (type==10||type==11||type==12) {
      stroke(coff);
      fill(255);
      rect(pos.x, pos.y, size.x, size.y, size.y);
      strokeWeight(1*scand);
      if (isover()) strokeWeight(2*scand);
      if (!state) {
        stroke(coff);
        fill(255);
        ellipse(pos.x+(size.y*.5), mid.y, size.y*1.05, size.y*1.05);
      } else {
        noStroke();
        fill(con);
        rect(pos.x, pos.y, size.x, size.y, size.y); 
        fill(255);
        stroke(coff);
        ellipse(end.x-(size.y*.5), pos.y+(size.y*.5), size.y*1.05, size.y*1.05);
      }      
      fill(coff);
      noStroke();
      if (type==11)  textAlign(CENTER, CENTER);
      if (type==11)  text(name, mid.x, end.y+textsize*.8);
      if (type==12)  textAlign (LEFT, CENTER);
      if (type==12)  text(name, end.x+textsize*.8, mid.y );
    }
    if (type==20||type==21) {            //boton icono con texto
      stroke(coff);
      noFill();
      strokeWeight(1*scand);
      if (isover()) strokeWeight(2*scand);
      if (state) fill(con);
      if (state) noStroke();
      ellipse(mid.x, mid.y, size.x, size.y);
      fill(coff);
      if (state) fill(coff);
      if (state) noStroke();
      drawicon(icon, mid, size);
      textAlign(CENTER, CENTER);
      fill(coff);
      noStroke();
      if (type==20) textAlign(CENTER, CENTER);
      if (type==20) text(name, mid.x, end.y+textsize*.8);
      if (type==21) textAlign(LEFT, CENTER);
      if (type==21) text(name, end.x+textsize*.8, mid.y);
    }
    if (type==22) {
      stroke(coff);
      noFill();
      strokeWeight(1*scand);
      if (isover()) strokeWeight(2*scand);
      if (state) fill(con);
      if (state) noStroke();
      if (state) ellipse(pos.x+(size.y*.5), pos.y+(size.y*.5), size.x*1.05, size.y*1.05);
      fill(coff);
      if (state) fill(coff);
      if (state) noStroke();
      PVector a = new PVector (pos.x+(size.x*.5), pos.y+(size.y*.5));
      drawicon(icon, a, size);
      textAlign(CENTER, CENTER);
      if (state) fill(con);
      else fill(coff);
      noStroke();
      text(name, pos.x+(size.x*.5), end.y+textsize*.8);
    }
    if (type==30||type==31) {                       //show hide bar horizontal
      stroke(coff);
      fill(255);
      strokeWeight(1*scand);
      if (isover()) strokeWeight(2*scand);
      if (!state) {
        rect(poshide.x, poshide.y, size.x, size.y);
        if (type==30)line(pos.x+size.x*.5-7*scand, pos.y+size.y*.5, pos.x+size.x*.5, pos.y+size.y*.5+7*scand);
        if (type==30) line(pos.x+size.x*.5+7*scand, pos.y+size.y*.5, pos.x+size.x*.5, pos.y+size.y*.5+7*scand);
        if (type==31)       line(pos.x+(size.x*.4), pos.y+size.y*.5-(7*scand), pos.x+(size.x*.7), pos.y+size.y*.5);
        if (type==31) line(pos.x+(size.x*.4), pos.y+size.y*.5+(7*scand), pos.x+(size.x*.7), pos.y+size.y*.5);
      }
      if (state) {
        rect(poshide.x, poshide.y, posshow.x-poshide.x+size.x, posshow.y-poshide.y+size.y);
        if (type==30) line(pos.x+size.x*.5-7*scand, pos.y+size.y*.5+7*scand, pos.x+size.x*.5, pos.y+size.y*.5);
        if (type==30) line(pos.x+size.x*.5+7*scand, pos.y+size.y*.5+7*scand, pos.x+size.x*.5, pos.y+size.y*.5);
        if (type==31) line(pos.x+(size.x*.7), pos.y+size.y*.5-(7*scand), pos.x+(size.x*.4), pos.y+size.y*.5);
        if (type==31) line(pos.x+(size.x*.7), pos.y+size.y*.5+(7*scand), pos.x+(size.x*.4), pos.y+size.y*.5);
      }
    }

    if (type==40) {
      stroke(coff);
      fill(coff);
      strokeWeight(1*scand);
      if (isover()) strokeWeight(2*scand);
      if (state) fill(con);
      if (state) stroke(con);
      line(pos.x, end.y, end.x, end.y);
      textAlign(CENTER, CENTER);
      noStroke();
      text(name, pos.x+(size.x*.5), pos.y+(size.y*.5));
    }
    if (type==50) { //candado
      noStroke();      
      fill(con);
      if (state) fill(coff);
      PVector a = new PVector (pos.x+(size.x*.5), pos.y+(size.y*.5));
      if (state) drawicon(17, a, size);
      else drawicon(16, a, size);
    }
    popStyle();
  }
  void turnon() {
    state = true;
    if (type==30||type==31) {
      pos  = new PVector (posshow.x, posshow.y);
      calcpos();
    }
  }
  void turnoff() {
    state = false;
    if (type==30||type==31) {
      pos  = new PVector (poshide.x, poshide.y);
      calcpos();
    }
  }
  void press() {
    if (type!=30&&type!=31) if (isover()) state = !state;
    if (type==30||type==31) if (isover()) if (!state) turnon();
    if (type==30||type==31) if (isover()) if (state) turnoff();
  }
  boolean isover() {
    if (mouseX>pos.x&&mouseX<end.x&&mouseY>pos.y&&mouseY<end.y) return true;
    else return false;
  }
}
