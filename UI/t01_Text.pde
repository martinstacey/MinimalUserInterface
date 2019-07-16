class Text {
  PVector pos, size, mid, end;
  String name;
  boolean state;
  String itext = "";
  String dash = "|";
  int type = 0;
  int icon = 0;
  float textsize = 12;
  float scand = 1;
  color con = 200;
  color coff = 100;
  Text(PVector _pos, PVector _size, String _name, int _type) {
    pos=_pos;
    size=_size;
    calcpos();
    name = _name;
    type = _type;
  }
  void scaletoandroid(float _scand) {
    scand = _scand;
    pos = new PVector (pos.x*scand, pos.y*scand);
    size = new PVector (size.x*scand, size.y*scand);
    calcpos();
    textsize  = textsize*scand;
  }
  void calcpos() {
    mid = new PVector(pos.x+size.x*.5, pos.y+size.y*.5);
    end = new PVector(pos.x+size.x, pos.y+size.y);
  }
  void display() { 
    pushStyle();
       textSize(textsize);
    rectMode(CORNER);
    textAlign(CENTER, CENTER);
    fill(coff);
    stroke(con);
    strokeWeight(1*scand);
    //rect(pos.x,pos.y,size.x,size.y);
     if (isover()||state) fill(con);
    if (isover()||state) stroke(con);
    if (isover()||state) strokeWeight(2*scand);
    line(pos.x, pos.y+size.y, pos.x+size.x, pos.y+size.y);
    noStroke();
    if (itext.length()==0&&!state) text(name, mid.x, mid.y-textsize*.3);
    if (type==10&&itext.length()<50) {
      if (state) text(itext+dash, mid.x, mid.y-textsize*.3);
      else text(itext, mid.x, mid.y-textsize*.3);
    }
    if (type==20&&itext.length()<50) {
      String textp = "";
      for (int i=0; i<itext.length(); i++) textp = textp + "*";
      noStroke();
      if (state) text(textp+dash, mid.x, mid.y-textsize*.3);
      else text(textp, mid.x, mid.y-textsize*.3);
    }
    popStyle();
  }
    boolean isover() {
    if (mouseX>pos.x&&mouseX<end.x&&mouseY>pos.y&&mouseY<end.y) return true;
    else return false;
  }
    void presson() {
    if (isover()) state = !state;
  }
  void pressoff() {
    if (state)if (!isover()) state = false;
  }
    void type() {
    if (state) {
      if ((key >= 'A' && key <= 'z') ||(key >= '0' && key <= '9') || key == ' '|| key=='('|| key==')'|| key==','|| key=='.'|| key=='|'||key=='@'||key=='-'||key=='_')   itext = itext + str(key);
      if ((key == CODED&&keyCode == LEFT)||keyCode == BACKSPACE)  if (itext.length()>0) itext = itext.substring(0, itext.length()-1);
    }
  }
}
boolean textisar(Text [] alltx) {
  boolean bout = false;
  for (int a = 0; a<alltx.length; a++) if (alltx[a]!=null)  if (alltx[a].state) bout = true;
  return bout;
}
boolean textis(ArrayList <Text> alltx) {
  boolean bout = false;
  for (int a = 0; a<alltx.size(); a++) if (alltx.get(a)!=null)  if (alltx.get(a).state) bout = true;
  return bout;
}
