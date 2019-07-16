class Textrect {
  PVector pos, size;
  String text;
  float scand = 1;
  float textsize = 12;
  int i;
  Textrect(PVector _pos, PVector _size, String _text, int _i) {
    pos=_pos;
    size=_size;
    text=_text;
    i=_i;
  }
  void scaletoandroid(float _scand) {
    scand = _scand;
    pos = pos.copy().mult(scand);
    size = size.copy().mult(scand);
    textsize = textsize*scand;
    }
  void display() {
    pushStyle();
    textSize(textsize);
    fill(255);
    textAlign(CENTER, CENTER);
    //rect(pos.x, pos.y, size.x, size.y);
    fill(100);
    noStroke();
    if (text!=null) text(text, pos.x + size.x*.5, pos.y + size.y*.5);
    popStyle();
  }
}
