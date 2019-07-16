class Slider {
  PVector pos, size, mid, end, bupos, bupos2, busize, slsize, slstopb, slstope, clpos, clsize;
  String name;
  float value, value2, minstopv, maxstopv;
  boolean state, drag, drag2;
  float  minV=0;
  float maxV=1;
  float flt = 1;
  int type = 0;
  int icon = 0;
  float textsize = 12;
  float textdist = 90;
  float scand = 1;
  color con = 100;
  color coff = 200;
  Slider(PVector _pos, PVector _size, String _name, int _type, float _minV, float _value, float _maxV) {
    pos=_pos;
    size=_size;
    name = _name;
    type = _type;
    minV=_minV;
    value = _value;
    value2=value;
    maxV=_maxV;
    calcpos();
    nostops();
  }
  void calcpos() {
    mid = new PVector(pos.x+size.x*.5, pos.y+size.y*.5);
    end = new PVector(pos.x+size.x, pos.y+size.y);
    bupos  = new PVector (map(value, minV, maxV, pos.x, end.x), mid.y);
    bupos2 = new PVector (map(value2, minV, maxV, pos.x, end.x), mid.y);
    busize = new PVector (size.y, size.y);
    slsize = new PVector (size.x, 3*scand);
    clpos = new PVector (pos.x-busize.x, pos.y);
    clsize = new PVector (busize.x, busize.y*2);
    if (type==11) {
      bupos  = new PVector (mid.x, map(value, minV, maxV, pos.y, end.y));
      bupos2 = new PVector (mid.x, map(value2, minV, maxV, pos.y, end.y));
      busize = new PVector (size.x, size.x);
      slsize = new PVector (3*scand, size.y);
      clpos = new PVector (pos.x-busize.y*.5, pos.y-busize.y);
      clsize = new PVector (busize.x*2, busize.y);
    }
  }
  void nostops() {
    slstopb = new PVector (pos.x, pos.y);
    slstope = new PVector (end.x, end.y);
  }
  void scaletoandroid(float _scand) {
    scand = _scand;
    pos  = new PVector (scand*pos.x, scand*pos.y);
    size  = new PVector (scand*size.x, scand*size.y);
    calcpos();
    slstopb = new PVector (scand*slstopb.x, scand*slstopb.y);
    slstope = new PVector (scand*slstope.x, scand*slstope.y);
    textsize = textsize * scand;
  }
  void addstops(float _minstopV, float _maxstopV) {
    minstopv = _minstopV;
    maxstopv = _maxstopV;
    slstopb = new PVector (map(minstopv, minV, maxV, pos.x, end.x), map(minstopv, minV, maxV, pos.y, end.y));
    slstope = new PVector (map(maxstopv, minV, maxV, pos.x, end.x), map(maxstopv, minV, maxV, pos.y, end.y));
  }
  void addsecond(float _value2) {
    value2 = _value2;
    calcpos();
  }
  void display() {
    pushStyle();
    rectMode(CORNER);
    textSize(textsize);
    if (type==10) {                                   //Simple horizontal 
      value = rg(map(bupos.x, pos.x, end.x, minV, maxV), flt); 
      if (drag) bupos.x = constrain(mouseX, slstopb.x, slstope.x);
      println(pos.x);
      if (slstopb!=null)if (slstopb.x!=pos.x) line(slstopb.x, mid.y-(busize.y*.2), slstopb.x, mid.y+(busize.y*.2));
      if (slstope!=null)if (slstope.x!=end.x) line(slstope.x, mid.y-(busize.y*.2), slstope.x, mid.y+(busize.y*.2));
      noStroke();
      fill(coff);
      rect(pos.x, mid.y-slsize.y*.5, slsize.x, slsize.y, slsize.y*.5); 
      fill(con);
      rect(pos.x, mid.y-slsize.y*.5, bupos.x-pos.x, slsize.y, slsize.y/2); 
      strokeWeight(1*scand);
      if (isover()) strokeWeight(2*scand);
      stroke(con);
      fill(255);
      ellipse(bupos.x, mid.y, busize.x, busize.y);
      fill(con);
      noStroke();
      textAlign(CENTER, CENTER);
      if (flt>1) text( int(value), bupos.x, bupos.y-busize.y*.5-textsize*.8);
      else text( nfc(value, 2), bupos.x, bupos.y-busize.y*.5-textsize*.8); 
      fill(con);
      textAlign(LEFT, CENTER);
      noStroke();
      text(name, pos.x-textdist, mid.y);
      strokeWeight(1*scand);
    }     
    if (type==11) {                                   //Simple vertical sin nombre
      value = rg(map(bupos.y, pos.y, end.y, minV, maxV), flt); 
      if (drag) bupos.y = constrain(mouseY, slstopb.y, slstope.y);
      fill(255);
      stroke(coff);

      if (state) {
        rect(clpos.x, clpos.y, clsize.x, size.y+clsize.y, busize.y/4);
        if (slstopb!=null)if (slstopb.y!=pos.y) line(mid.x-busize.x*.2, slstopb.y, mid.x+busize.x*.2, slstopb.y);
        if (slstope!=null)if (slstope.y!=end.y) line(mid.x-busize.x*.2, slstope.y, mid.x+busize.x*.2, slstope.y);
        noStroke();
        fill(coff);
        rect( mid.x-slsize.x*.5, pos.y, slsize.x, slsize.y, slsize.x*.5); 
        fill(con);
        rect( mid.x-slsize.x*.5, pos.y, slsize.x, bupos.y-pos.y, slsize.x/2); 
        strokeWeight(1*scand);
        if (isover()) strokeWeight(2*scand);
        stroke(con);
        fill(255);
        ellipse(bupos.x, bupos.y, busize.x, busize.y);
        stroke(coff);
      }
      strokeWeight(1*scand);
      if (isovercl()) strokeWeight(2*scand);
      if (!state) {
        noStroke();
        rect(clpos.x, clpos.y, busize.x*2, busize.y, busize.y/4);
        stroke(con);
        line(clpos.x+busize.x, clpos.y+busize.y-scand*5, clpos.x+busize.x-scand*5, clpos.y+busize.y-scand*10);
        line(clpos.x+busize.x, clpos.y+busize.y-scand*5, clpos.x+busize.x+scand*5, clpos.y+busize.y-scand*10);
      }
      if (state) {
        line(clpos.x+busize.x, clpos.y+busize.y-scand*10, clpos.x+busize.x-scand*5, clpos.y+busize.y-scand*5);
        line(clpos.x+busize.x, clpos.y+busize.y-scand*10, clpos.x+busize.x+scand*5, clpos.y+busize.y-scand*5);
      }
      fill(con);
      textAlign(CENTER, CENTER);
noStroke();
      if (flt>=1) text( int(value), mid.x, pos.y-busize.y*.7);
      else text( nfc(value, 2), mid.x, pos.y-busize.y*.7); 
      fill(con);
      textAlign(CENTER, CENTER);
      //text(name,  mid.x,pos.y-textsize*2);
      strokeWeight(1*scand);
    }     
    if (type==20) {                        //Doble horizontal
      value = rg(map(bupos.x, pos.x, end.x, minV, maxV), flt);
      value2 = rg(map(bupos2.x, pos.x, end.x, minV, maxV), flt);

      if (drag) bupos.x = constrain(mouseX, slstopb.x, bupos2.x-busize.y);
      if (drag2) bupos2.x = constrain(mouseX, bupos.x+busize.y, slstope.x);
      if (slstopb!=null)if (slstopb.x!=pos.x) line(slstopb.x, slstopb.y-(busize.y*.2), slstopb.x, slstopb.y+slsize.y+(busize.y*.2));
      if (slstope!=null)if (slstope.x!=end.x) line(slstope.x, slstope.y-slsize.y-(busize.y*.2), slstope.x, slstope.y+(busize.y*.2));
      noStroke();
      fill(coff);
      rect(pos.x, mid.y-slsize.y*.5, slsize.x, slsize.y, slsize.y*.5); 
      fill(con);
      rect(bupos.x, mid.y-slsize.y*.5, bupos2.x-bupos.x, slsize.y, slsize.y/2); 
      strokeWeight(1*scand);
      stroke(con);
      fill(255);
      if (isover()) strokeWeight(2*scand);
      else  strokeWeight(1*scand);
      ellipse(bupos.x, mid.y, busize.x, busize.y);
      if (isover2()) strokeWeight(2*scand);
      else  strokeWeight(1*scand);
      ellipse(bupos2.x, mid.y, busize.x, busize.y);
      fill(con);
      textAlign(CENTER, CENTER);
      noStroke();
      if (flt>1) text(int(value), bupos.x, pos.y-busize.y*.5-textsize*.8);
      else text( nfc(value, 2), bupos.x, pos.y-busize.y*.5-textsize*.8); 
      if (flt>1) text( int(value2), bupos2.x, pos.y-busize.y*.5-textsize*.8);
      else text( nfc(value2, 2), bupos2.x, pos.y-busize.y*.5-textsize*.8); 
      fill(con);
      textAlign(LEFT, CENTER);
      noStroke();
      text(name, pos.x-textdist, mid.y);
      strokeWeight(1*scand);
    }
    popStyle();
  }
  boolean isover() {
    return (mouseX>bupos.x-busize.x*.5&&mouseX<bupos.x+busize.x*.5&&mouseY>bupos.y-busize.y*.5&&mouseY<bupos.y+busize.y*.5);
  }
  boolean isover2() {
    return (mouseX>bupos2.x-busize.x*.5&&mouseX<bupos2.x+busize.x*.5&&mouseY>bupos.y-busize.y*.5&&mouseY<bupos.y+busize.y*.5);
  }
  boolean isovercl() {
    return (mouseX>clpos.x&&mouseX<clpos.x+clsize.x&&mouseY>clpos.y&&mouseY<clpos.y+clsize.y);
  }
  boolean otherselectlist(ArrayList <Slider> allsl) {
    boolean bout=false;
    for (int i=0; i<allsl.size(); i++) if (allsl.get(i).state) bout = true;
    if (state) bout = false;
    ;
    return bout;
  }
  boolean otherselectarr(Slider [] allsl) {
    boolean bout=false;
    for (int i=0; i<allsl.length; i++) if (allsl[i].state)bout = true;
    if (state) bout = false;
    ;
    return bout;
  }  
  void press() {
    if (type==11) {
      if (isovercl()) state = !state;
      if (state) {
        if (isover()) drag = true;
        if (isover2()) drag2 = true;
      }
    }
    if (type!=11) {
      if (isover()) drag = true;
      if (isover2()) drag2 = true;
    }
  }
  void release() {
    drag = false;
    drag2 = false;
  }
  float roundit(float numin, int dec) {                                              
    float dec10 = pow(10, dec);
    float roundout = round(numin * dec10)/dec10;
    return roundout;
  }
  float rg(float fin, float grunit) {
    float fout = fin + grunit*.5;
    fout = roundit(fout-(fout%grunit), 2);
    return fout;
  }
}
