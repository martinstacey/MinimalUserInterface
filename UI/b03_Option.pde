class Option {
  PVector pos, size, mid, end, ipos[], imid[], iend[];
  String[] names;
  boolean state, displaystate;
  int type = 0;
  int namei = 0;
  int icon = 0;
  float textsize = 12;
  float scand = 1;
  color con = 100;
  color coff = 200;
  Option(PVector _pos, PVector _size, String _names[], int _type) {
    pos = _pos;
    size=_size;
    names = _names;
    type = _type;
    calcpos();
    if (type==11||type==13) namei=-1;
  }
  void calcpos() {
    mid = new PVector (pos.x + size.x/2, pos.y + size.y/2);
    end = new PVector (pos.x + size.x, pos.y + size.y   );
    calcipos(type);
  }
  void scaletoandroid(float _scand) {
    scand = _scand;
    pos = new PVector (pos.x*scand, pos.y*scand);
    size = new PVector (size.x*scand, size.y*scand);
    textsize = textsize * scand;
    calcpos();
  }

  void calcipos(int type) {
    if (type==10||type==12) {
      ipos = new PVector [names.length];
      imid = new PVector [names.length];
      iend = new PVector [names.length];
      for (int i=0; i<ipos.length; i++) if (i==namei) ipos[i] = new PVector (pos.x, pos.y);
      for (int i=0; i<ipos.length; i++) if (i<namei) ipos[i] = new PVector (pos.x, pos.y+(i*size.y)+size.y);
      for (int i=0; i<ipos.length; i++) if (i>namei) ipos[i] = new PVector (pos.x, pos.y+(i*size.y));
      for (int i=0; i<imid.length; i++) if (i==namei) imid[i] = new PVector (pos.x+size.x*.5, pos.y+size.y*.5);
      for (int i=0; i<imid.length; i++) if (i<namei) imid[i] = new PVector (pos.x+size.x*.5, pos.y+(i*size.y)+size.y*1.5);
      for (int i=0; i<imid.length; i++) if (i>namei) imid[i] = new PVector (pos.x+size.x*.5, pos.y+(i*size.y)+size.y*0.5);
      for (int i=0; i<iend.length; i++) if (i==namei) iend[i] = new PVector (pos.x+size.x, pos.y+size.y);
      for (int i=0; i<iend.length; i++) if (i<namei) iend[i] = new PVector (pos.x+size.x, pos.y+(i*size.y)+size.y*2);
      for (int i=0; i<iend.length; i++) if (i>namei) iend[i] = new PVector (pos.x+size.x, pos.y+(i*size.y)+size.y*1);
    }
    if (type==11) {
      ipos = new PVector [names.length];
      imid = new PVector [names.length];
      iend = new PVector [names.length];
      for (int i=0; i<ipos.length; i++) ipos[i] = new PVector (pos.x, pos.y+size.y+(size.y*i));
      for (int i=0; i<imid.length; i++) imid[i] = new PVector (pos.x+(size.x*.5), pos.y+size.y+(size.y*i)+(size.y*.5));
      for (int i=0; i<iend.length; i++) iend[i] = new PVector (pos.x+(size.x), pos.y+size.y+(size.y*i)+(size.y));
      
    }
        if (type==13) {
      ipos = new PVector [names.length];
      imid = new PVector [names.length];
      iend = new PVector [names.length];
      for (int i=0; i<ipos.length; i++) ipos[i] = new PVector (pos.x+size.x+size.x*i, pos.y);
      for (int i=0; i<imid.length; i++) imid[i] = new PVector (pos.x+size.x+size.x*i+size.x*.5, pos.y+size.y*.5);
      for (int i=0; i<iend.length; i++) iend[i] = new PVector (pos.x+size.x+size.x*i+size.x, pos.y+size.y);
    }
    if (type==20||type==30||type==31) {
      ipos = new PVector [names.length];
      imid = new PVector [names.length];
      iend = new PVector [names.length];
      for (int i=0; i<ipos.length; i++) ipos[i] = new PVector (pos.x+(size.x*i), pos.y);
      for (int i=0; i<imid.length; i++) imid[i] = new PVector (pos.x+(size.x*i)+(size.x*.5), pos.y+(size.y*.5));
      for (int i=0; i<iend.length; i++) iend[i] = new PVector (pos.x+(size.x*i)+(size.x), pos.y+(size.y));
    }
  }
  void display() {
    pushStyle();
    textSize(textsize);
    if (type==10) {
      stroke(con);
      if (isover()) strokeWeight (2*scand);
      else strokeWeight(1*scand);
      fill(255);
      textAlign(RIGHT, CENTER);
      noFill();
      strokeWeight(1);
      if (state) {
        for (int i=0; i<ipos.length; i++) {
          if (isoveri(i))  strokeWeight (2);
          else strokeWeight(1);
          fill(255);
          rect(ipos[i].x, ipos[i].y, size.x, size.y, size.y/4);
          fill(con);
          noStroke();
          if (i!=namei) text(names[i], iend[i].x-25, imid[i].y);
           stroke(con);
        }
      }   
      line(end.x-15*scand, mid.y, end.x-10*scand, mid.y+5*scand);
      line(end.x-5*scand, mid.y, end.x-10*scand, mid.y+5*scand);
      fill(con);
       noStroke();
      text(names[namei], end.x-20*scand, mid.y);
      stroke(con);
    }
    if (type==11||type==13) {
      stroke(con);
      if (isover()) strokeWeight (2*scand);
      else strokeWeight(1*scand);
      fill(con);
      //text(namei,pos.x,pos.y-15);
      //rect(pos.x, pos.y, size.x, size.y);
      PVector a = new PVector (pos.x+(size.x*.5), pos.y+(size.y*.5));
      PVector isize = new PVector (size.y, size.y);
      fill(con);
      drawicon(icon, a, isize);
      if (state) for (int i=0; i<ipos.length; i++) {
        textAlign(CENTER, CENTER);
        fill(255);
        if (isoveri(i))  strokeWeight (2);
        else strokeWeight(1);
        rect(ipos[i].x, ipos[i].y, size.x, size.y, size.y/4);
        fill(con);
        noStroke();
        text(names[i], imid[i].x, imid[i].y);
        stroke(con);
      }
    }
    if (type==12) {
      stroke(con);
      if (isover()) strokeWeight (2*scand);
      else strokeWeight(1*scand);
      fill(255);
      textAlign(CENTER, CENTER);
      noFill();
      strokeWeight(1);
      if (state) {
        for (int i=0; i<ipos.length; i++) {
          if (isoveri(i))  strokeWeight (2);
          else strokeWeight(1);
          fill(255);
          rect(ipos[i].x, ipos[i].y, size.x, size.y, size.y/4);
          fill(con);
          noStroke();
          if (i!=namei) text(names[i], imid[i].x, imid[i].y-5*scand);
   stroke(con);
        }
      }   
      noStroke();
      fill(255);
      rect(pos.x,pos.y,size.x,size.y,size.y/4);
      stroke(con);
      line(mid.x-5*scand, end.y-9*scand, mid.x-0*scand, end.y-4*scand);
      line(mid.x+5*scand, end.y-9*scand, mid.x-0*scand, end.y-4*scand);
      fill(con);
      noStroke();
      text(names[namei], mid.x, mid.y-5*scand);
      
      
      
    }

    if (type==20) {
      rectMode(CORNER);
      textAlign(CENTER, CENTER);
      for (int i=0; i<names.length; i++) if (i!=namei) {     
        noFill();
        stroke(coff);
        strokeWeight(1*scand);

        if (isoveri(i)) strokeWeight(1.5*scand);
        rect(ipos[i].x, ipos[i].y, size.x, size.y);
        fill(coff);
        noStroke();
        text(names[i], imid[i].x, imid[i].y);
           stroke(con);
      }
      for (int i=0; i<names.length; i++) if (i==namei) {
        stroke(con);
        strokeWeight(1.5*scand);
        line(ipos[i].x, ipos[i].y, ipos[i].x, iend[i].y);
        line(ipos[i].x, ipos[i].y, iend[i].x, ipos[i].y);
        line(iend[i].x, ipos[i].y, iend[i].x, iend[i].y);
        fill(con);
        noStroke();
        text(names[i], imid[i].x, imid[i].y);
        stroke(con);
      }
    }
    if (type==30) {

      for (int i=0; i<names.length; i++) if (i!=namei) {     
        fill(coff);
        stroke(coff);
        strokeWeight(1*scand);
        if (isoveri(i)) strokeWeight(1.5*scand);
        ellipse( imid[i].x, imid[i].y, 7*scand, 7*scand);
      }
      for (int i=0; i<names.length; i++) if (i==namei) {
        fill(con);
        stroke(con);
        strokeWeight(1*scand);
        if (isoveri(i)) strokeWeight(1.5*scand);
        ellipse( imid[i].x, imid[i].y, 7*scand, 7*scand);
      }
    }
        if (type==31) {
          noStroke();
      //starsys(pos,size,0,200,100);
      for (int i=0; i<names.length; i++) if (i>namei) {     
        fill(coff);
        stroke(coff);
        strokeWeight(1*scand);
        if (isoveri(i)) strokeWeight(1.5*scand);
        star5( ipos[i], new PVector (size.x*.8,size.y*.8));
      }
      for (int i=0; i<names.length; i++) if (i<=namei) {
        fill(con);
        stroke(con);
        strokeWeight(1*scand);
        if (isoveri(i)) strokeWeight(1.5*scand);
        star5( ipos[i], new PVector(size.x*.8,size.y*.8));
      }
    }
    popStyle();
  }
  boolean otherselectarr(Option [] allsl){
    boolean bout=false;
    for (int o=0; o<allsl.length; o++)  if (allsl[o].state) bout = true;
    if (state) bout = false;
    return bout;
  }
  boolean isover() {
    if (mouseX>pos.x&&mouseX<end.x&&mouseY>pos.y&&mouseY<end.y) return true;
    else return false;
  }
  boolean isoveri(int nim) {
    boolean [] bout = new boolean [names.length];
    for (int i=0; i<bout.length; i++) {
      if (mouseX>ipos[i].x&&mouseX<iend[i].x&&mouseY>ipos[i].y&&mouseY<iend[i].y) bout[i] = true;
      else bout[i] = false;
    }
    return bout[nim];
  }
  void press() {
    if (type==10||type==11||type==12||type==13) {
      if (isover()) state = !state;
      if (state) for (int i=0; i<names.length; i++) if (i!=namei||type==11||type==13) {
        if (isoveri(i)) {
          namei = i;
          state = !state;
        }
      }
      calcipos(type);
    }
    if (type==20||type==30||type==31) {
      for (int i=0; i<names.length; i++)  if (isoveri(i)) {
        namei = i;
      }
    }
  }
  void pressoff(){
    if (type==11) namei=-1; 
  }
}
