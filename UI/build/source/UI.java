import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Date; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class UI extends PApplet {


Text a;
public void setup() {
  
  createfile("ui.pde","UI.pde",sketchPath("")+"data/");
  a = new Text(new PVector (100,100), new PVector (200,20),"Sliderde 1",10);
  //a.addsecond(4);
  //a.calcposhide(new PVector(200,100));
  a.scaletoandroid(1.0f);
}
public void draw(){
  background(255);
  a.display();
  ellipse(100,100,5,5);
}
public void mousePressed(){
  a.select();
  a.unselect();
}
public void mouseReleased(){
  //a.release();
}
public void keyPressed(){
 a.type();
}




public void createfile(String filename, String filetoexclude,String filepath){
  saveStrings(dataPath(filepath + filename),joinfilestrings(listFileNames(filetoexclude, sketchPath())));
  println("file created in data, dont forget to save before executing");
}
public String [] joinfilestrings(ArrayList <String> filenames) {
  ArrayList <String> alltext = new ArrayList <String> ();
  for (String n:filenames) {
   String[] lines = loadStrings(n);
    for (String s:lines) alltext.add(s);
  }
  String alltextst [] =  new String [alltext.size()];
  for (int i=0; i<alltext.size();i++) alltextst [i] =alltext.get(i);
  return alltextst;
}
public ArrayList <String> listFileNames(String filename, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String allnames[] = file.list();
    ArrayList <String> names = new ArrayList <String> ();
    for (int i=0; i<allnames.length;i++) if (!txequal123(allnames[i],filename)&&(txequal123(allnames[i].substring(allnames[i].length()-3,allnames[i].length()),"pde")))names.add(allnames[i]);
    return names;
  } else return null;
}
public boolean txequal123(String a, String b) {
  if (a==null||b==null) return false;
  else {
    int al= a.length();
    int bl= b.length();
    int minl;
    boolean bout = true;
    if (al!=bl) bout = false;
    if (al<bl) minl = al;
    else minl = bl;
    for (int i=0; i<minl; i++) if (a.charAt(i)!=b.charAt(i)) bout = false;
    return bout;
  }
}
class Click {
  PVector pos, size, mid, end;
  String name;
  boolean state, displaystate;
  int type = 0;
  int icon = 0;
  float textsize = 12;
  float scand = 1;
  int con = 200;
  int coff = 100;
  Click(PVector _pos, PVector _size, String _name, int _type) {
    pos=_pos;
    size=_size;
    calcpos();
    name = _name;
    type = _type;
  }
  public void calcpos() {
    mid = new PVector(pos.x+size.x/2, pos.y+size.y/2);
    end = new PVector(pos.x+size.x, pos.y+size.y);
  }
  public void scaletoandroid(float _scand) {
    scand = _scand;
    pos  = new PVector (scand*pos.x, scand*pos.y);
    size  = new PVector (scand*size.x, scand*size.y);
    mid  = new PVector (scand*mid.x, scand*mid.y);
    end  = new PVector (scand*end.x, scand*end.y);
    textsize = textsize * scand;
  }
  public void display() {
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
      if (type==10) textAlign(LEFT, CENTER);
      if (type==10) text(name, end.x+(size.x*.3f), mid.y);
      if (type==11) textAlign(CENTER, CENTER);
      if (type==11) text(name, mid.x, end.y+(textsize*.8f));
    }

    if (type==20||type==21) {                            // //boton redondeado =2 redondeado cuadrado =3 vacio texto adentro
      stroke(coff);
      if (displaystate)  noStroke();
      if (displaystate)  fill(con);
      if (type==20) rect(pos.x, pos.y, size.x, size.y, size.y/2);
      if (type==21) rect(pos.x, pos.y, size.x, size.y, size.y/4);
      textAlign(CENTER, CENTER);
      if (displaystate)  fill(255);
      else fill(coff);
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
      if (type==30)text(name, mid.x, end.y+size.y*.15f);
      if (type==31) textAlign(LEFT, CENTER);
      if (type==31) if (isover())text(name, end.x+size.x*.2f, mid.y);
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
      text(name, mid.x, mid.y);
    }
    if (type==41) {                                  //texto sobre linea
      textAlign(CENTER, CENTER);
      if (displaystate)  fill(con);
      else fill(coff);
      if (isover()) strokeWeight(2*scand);
      else strokeWeight(1*scand);
      text(name, mid.x, mid.y); 
      line(pos.x, end.y, end.x, end.y);
    }
    strokeWeight(1*scand);
    popStyle();
  }

  public boolean isover() {
    return  (mouseX > pos.x && mouseX < end.x  &&mouseY >pos.y && mouseY < end.y);
  }
  public boolean isoverandpressed() {
    return  (isover()&&mousePressed == true);
  }
  public void presson() {
    if (isover()) state = true;
    if (isover()) displaystate = true;
  }
  public void pressoff() {
    if (isover()) state = false;
  }
}
class Toggle {
  PVector pos, size, mid, end, poshide, posshow;
  String name;
  boolean state;
  int type = 0;
  int icon = 0;
  float textsize = 12;
  float scand = 1;
  int con = 200;
  int coff = 100;
  Toggle(PVector _pos, PVector _size, String _name, int _type) {
    pos=_pos;
    size=_size;
    calcpos();
    name = _name;
    type = _type;
    poshide = pos;
    posshow = pos;
  }
  public void calcpos() {
    mid = new PVector(pos.x+size.x/2, pos.y+size.y/2);
    end = new PVector(pos.x+size.x, pos.y+size.y);
  }
  public void calcposhide(PVector _posshow) {
    poshide = pos;
    posshow = _posshow;
  }
  public void scaletoandroid(float _scand) {
    scand = _scand;
    pos  = new PVector (scand*pos.x, scand*pos.y);
    size  = new PVector (scand*size.x, scand*size.y);
    mid  = new PVector (scand*mid.x, scand*mid.y);
    end  = new PVector (scand*end.x, scand*end.y);
    poshide  = new PVector (scand*poshide.x, scand*poshide.y);
    posshow  = new PVector (scand*posshow.x, scand*posshow.y);
    textsize = textsize * scand;
  }
  public void display() {
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
        ellipse(mid.y, mid.y, size.y*1.05f, size.y*1.05f);
      } else {
        noStroke();
        fill(con);
        rect(pos.x, pos.y, size.x, size.y, size.y); 
        fill(255);
        stroke(coff);
        ellipse(end.x-(size.y*.5f), pos.y+(size.y*.5f), size.y*1.05f, size.y*1.05f);
      }      
      fill(coff);
      if (type==11)  textAlign(CENTER, CENTER);
      if (type==11)  text(name, mid.x, end.y+textsize*.8f);
      if (type==12)  textAlign (LEFT, CENTER);
      if (type==12)  text(name, end.x+textsize*.8f, mid.y );
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
      if (type==20) textAlign(CENTER, CENTER);
      if (type==20) text(name, mid.x, end.y+textsize*.8f);
      if (type==21) textAlign(LEFT, CENTER);
      if (type==21) text(name, end.x+textsize*.8f, mid.y);
    }
    if (type==22) {
      stroke(coff);
      noFill();
      strokeWeight(1*scand);
      if (isover()) strokeWeight(2*scand);
      if (state) fill(con);
      if (state) noStroke();
      if (state) ellipse(pos.x+(size.y*.5f), pos.y+(size.y*.5f), size.x*1.05f, size.y*1.05f);
      fill(coff);
      if (state) fill(coff);
      if (state) noStroke();
      PVector a = new PVector (pos.x+(size.x*.5f), pos.y+(size.y*.5f));
      drawicon(icon, a, size);
      textAlign(CENTER, CENTER);
      if (state) fill(con);
      else fill(coff);
      text(name, pos.x+(size.x*.5f), end.y+textsize*.8f);
    }
    if (type==30||type==31) {                       //show hide bar horizontal
      stroke(coff);
      fill(255);
      strokeWeight(1*scand);
      if (isover()) strokeWeight(2*scand);
      if (!state) {
        rect(poshide.x, poshide.y, size.x, size.y);
        if (type==30)line(pos.x+size.x*.5f-7*scand, pos.y+size.y*.5f, pos.x+size.x*.5f, pos.y+size.y*.5f+7*scand);
        if (type==30) line(pos.x+size.x*.5f+7*scand, pos.y+size.y*.5f, pos.x+size.x*.5f, pos.y+size.y*.5f+7*scand);
        if (type==31)       line(pos.x+(size.x*.4f), pos.y+size.y*.5f-(7*scand), pos.x+(size.x*.7f), pos.y+size.y*.5f);
        if (type==31) line(pos.x+(size.x*.4f), pos.y+size.y*.5f+(7*scand), pos.x+(size.x*.7f), pos.y+size.y*.5f);
      }
      if (state) {
        rect(poshide.x, poshide.y, posshow.x-poshide.x+size.x, posshow.y-poshide.y+size.y);
        if (type==30) line(pos.x+size.x*.5f-7*scand, pos.y+size.y*.5f+7*scand, pos.x+size.x*.5f, pos.y+size.y*.5f);
        if (type==30) line(pos.x+size.x*.5f+7*scand, pos.y+size.y*.5f+7*scand, pos.x+size.x*.5f, pos.y+size.y*.5f);
        if (type==31) line(pos.x+(size.x*.7f), pos.y+size.y*.5f-(7*scand), pos.x+(size.x*.4f), pos.y+size.y*.5f);
        if (type==31) line(pos.x+(size.x*.7f), pos.y+size.y*.5f+(7*scand), pos.x+(size.x*.4f), pos.y+size.y*.5f);
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
      text(name, pos.x+(size.x*.5f), pos.y+(size.y*.5f));
    }
    popStyle();
  }
  public void turnon() {
    state = true;
    if (type==30||type==31) {
      pos  = new PVector (posshow.x, posshow.y);
      calcpos();
    }
  }
  public void turnoff() {
    state = false;
    if (type==30||type==31) {
      pos  = new PVector (poshide.x, poshide.y);
      calcpos();
    }
  }
  public void press() {
    if (type!=30&&type!=31) if (isover()) state = !state;
    if (type==30||type==31) if (isover()) if (!state) turnon();
    if (type==30||type==31) if (isover()) if (state) turnoff();
  }
  public boolean isover() {
    if (mouseX>pos.x&&mouseX<end.x&&mouseY>pos.y&&mouseY<end.y) return true;
    else return false;
  }
}
class Option {
  PVector pos, size, mid, end, ipos[], imid[], iend[];
  String[] names;
  boolean state, displaystate;
  int type = 0;
  int namei = 0;
  float textsize = 12;
  float scand = 1;
  int con = 100;
  int coff = 200;
  Option(PVector _pos, PVector _size, String _names[], int _type) {
    pos = _pos;
    size=_size;
    names = _names;
    type = _type;
  }
  public void calcpos() {
    mid = new PVector (pos.x + size.x/2, pos.y + size.y/2);
    end = new PVector (pos.x + size.x, pos.y + size.y   );
    calcipos(type);
  }
  public void scaletoandroid(float _scand) {
    scand = _scand;
    pos = new PVector (pos.x*scand, pos.y*scand);
    size = new PVector (size.x*scand, size.y*scand);
    textsize = textsize * scand;
    calcpos();
  }

  public void calcipos(int type) {
    if (type==10) {
      ipos = new PVector [names.length];
      imid = new PVector [names.length];
      iend = new PVector [names.length];
      for (int i=0; i<ipos.length; i++) if (i==namei) ipos[i] = new PVector (pos.x, pos.y);
      for (int i=0; i<ipos.length; i++) if (i<namei) ipos[i] = new PVector (pos.x, pos.y+(i*size.y)+size.y);
      for (int i=0; i<ipos.length; i++) if (i>namei) ipos[i] = new PVector (pos.x, pos.y+(i*size.y));
      for (int i=0; i<imid.length; i++) if (i==namei) imid[i] = new PVector (pos.x+size.x*.5f, pos.y+size.y*.5f);
      for (int i=0; i<imid.length; i++) if (i<namei) imid[i] = new PVector (pos.x+size.x*.5f, pos.y+(i*size.y)+size.y*1.5f);
      for (int i=0; i<imid.length; i++) if (i>namei) imid[i] = new PVector (pos.x+size.x*.5f, pos.y+(i*size.y)+size.y*0.5f);
      for (int i=0; i<iend.length; i++) if (i==namei) iend[i] = new PVector (pos.x+size.x, pos.y+size.y);
      for (int i=0; i<iend.length; i++) if (i<namei) iend[i] = new PVector (pos.x+size.x, pos.y+(i*size.y)+size.y*2);
      for (int i=0; i<iend.length; i++) if (i>namei) iend[i] = new PVector (pos.x+size.x, pos.y+(i*size.y)+size.y*1);
    }
    if (type==20||type==30) {
      ipos = new PVector [names.length];
      imid = new PVector [names.length];
      iend = new PVector [names.length];
      for (int i=0; i<ipos.length; i++) ipos[i] = new PVector (pos.x+(size.x*i), pos.y);
      for (int i=0; i<imid.length; i++) imid[i] = new PVector (pos.x+(size.x*i)+(size.x*.5f), pos.y+(size.y*.5f));
      for (int i=0; i<imid.length; i++) iend[i] = new PVector (pos.x+(size.x*i)+(size.x), pos.y+(size.y));
    }
  }
    public void display() {
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
          if (isoveri()[i])  strokeWeight (2);
          else strokeWeight(1);
          fill(255);
          rect(ipos[i].x, ipos[i].y, size.x, size.y, size.y/4);
          fill(con);
           
          if (i!=namei) text(names[i], iend[i].x-25, imid[i].y);
        }
      }   
      line(end.x-15*scand, mid.y, end.x-10*scand, mid.y+5*scand);
      line(end.x-5*scand, mid.y, end.x-10*scand, mid.y+5*scand);
      fill(con);
      text(names[namei], end.x-20*scand, mid.y);
    }
    if (type==20) {
      rectMode(CORNER);
      textAlign(CENTER, CENTER);
      for (int i=0; i<names.length; i++) if (i!=namei) {     
        noFill();
        stroke(coff);
        strokeWeight(1*scand);
        
        if (isoveri()[i]) strokeWeight(1.5f*scand);
        rect(ipos[i].x, ipos[i].y, size.x, size.y);
        fill(coff);
        text(names[i], imid[i].x, imid[i].y);
      }
      for (int i=0; i<names.length; i++) if (i==namei) {
        stroke(con);
        strokeWeight(1.5f*scand);
        line(ipos[i].x, ipos[i].y, ipos[i].x, iend[i].y);
        line(ipos[i].x, ipos[i].y, iend[i].x, ipos[i].y);
        line(iend[i].x, ipos[i].y, iend[i].x, iend[i].y);
        fill(con);
        text(names[i], imid[i].x, imid[i].y);
      }
    }
    if (type==30) {

      for (int i=0; i<names.length; i++) if (i!=namei) {     
        fill(coff);
        stroke(coff);
        strokeWeight(1*scand);
        if (isoveri()[i]) strokeWeight(1.5f*scand);
        ellipse( imid[i].x, imid[i].y, 7*scand, 7*scand);
      }
      for (int i=0; i<names.length; i++) if (i==namei) {
        fill(con);
        stroke(con);
        strokeWeight(1*scand);
        if (isoveri()[i]) strokeWeight(1.5f*scand);
        ellipse( imid[i].x, imid[i].y, 7*scand, 7*scand);
      }
    }
    popStyle();
  }
    public boolean isover() {
    if (mouseX>pos.x&&mouseX<end.x&&mouseY>pos.y&&mouseY<end.y) return true;
    else return false;
  }
  public boolean [] isoveri() {
    boolean [] bout = new boolean [names.length];
    for (int i=0; i<bout.length; i++) {
      if (mouseX>ipos[i].x&&mouseX<iend[i].x&&mouseY>ipos[i].y&&mouseY<iend[i].y) bout[i] = true;
      else bout[i] = false;
    }
    return bout;
  }
  public void press() {
    if (type==10) {
      if (isover()) state = !state;
      if (state) for (int i=0; i<names.length; i++) if (i!=namei) {
        if (isoveri()[i]) {
          namei = i;
          state = !state;
        }
      }
      calcipos(type);
    }
    if (type==20||type==30) {
      for (int i=0; i<names.length; i++)  if (isoveri()[i]) {
        namei = i;
      }
    }
  }
  
}
public void drawicon(int icon, PVector pos, PVector size) {
  if (icon==0) { 
    pushMatrix();
    rect(pos.x-size.x*.35f, pos.y, size.x*.7f, size.y*.1f, size.y*.1f);
    translate(pos.x-size.x*.3f, pos.y+size.y*.05f);
    rotate(QUARTER_PI);
    translate(-pos.x+size.x*.3f, -pos.y-size.y*.05f);
    rect(pos.x-size.x*.3f, pos.y, size.x*.4f, size.y*.1f, size.y*.1f);
    translate(pos.x-size.x*.3f, pos.y+size.y*.05f);
    rotate(-2*QUARTER_PI);
    translate(-pos.x+size.x*.3f, -pos.y-size.y*.05f);
    rect(pos.x-size.x*.3f, pos.y, size.x*.4f, size.y*.1f, size.y*.1f);
    popMatrix();
  }
  if (icon==1) {  //INFORMATION
    rectMode(CENTER);
    ellipse(pos.x, pos.y-size.y*.3f, size.y*.1f, size.y*.1f);
    rect(pos.x, pos.y+size.y*.1f, size.x*.1f, size.y*.5f, size.y*.1f);
    rect(pos.x-size.x*.1f, pos.y-size.y*.1f, size.x*.2f, size.y*.1f, size.y*.1f);
    rectMode(CORNER);
  }
  if (icon==2) { //PLUS
    rect(pos.x-size.x*.4f, pos.y-size.y*.05f, size.x*.8f, size.y*.1f, size.y*.1f);
    rect(pos.x-size.x*.05f, pos.y-size.y*.4f, size.x*.1f, size.y*.8f, size.y*.1f);
  }
  if (icon==3) {  // SAVED MOUSE
    pushMatrix();
    rect(pos.x-size.x*.05f, pos.y-size.y*.3f, size.y*.1f, size.y*.4f, size.y*.1f);
    rect(pos.x-size.x*.35f, pos.y+size.y*.2f, size.x*.7f, size.y*.1f, size.y*.1f);
    translate(size.x*.3f, -size.y*.4f);
    translate(pos.x-size.x*.3f, pos.y+size.y*.05f);
    rotate(HALF_PI);
    rotate(QUARTER_PI);
    translate(-pos.x+size.x*.3f, -pos.y-size.y*.05f);
    rect(pos.x-size.x*.3f, pos.y, size.x*.4f, size.y*.1f, size.y*.1f);
    translate(pos.x-size.x*.3f, pos.y+size.y*.05f);
    rotate(-2*QUARTER_PI);
    translate(-pos.x+size.x*.3f, -pos.y-size.y*.05f);
    rect(pos.x-size.x*.35f, pos.y, size.x*.4f, size.y*.1f, size.y*.1f);
    popMatrix();
  }
  if (icon==4) {       //HOME
    pushMatrix();
    rect(pos.x-size.x*.3f, pos.y-size.y*+.15f, size.y*.1f, size.y*.3f, size.y*.1f);
    rect(pos.x+size.x*.18f, pos.y-size.y*+.15f, size.y*.1f, size.y*.3f, size.y*.1f);
    rect(pos.x-size.x*.35f, pos.y+size.y*.2f, size.x*.7f, size.y*.1f, size.y*.1f);
    translate(size.x*.3f, -size.y*.4f);
    translate(pos.x-size.x*.3f, pos.y+size.y*.05f);
    rotate(HALF_PI);
    rotate(QUARTER_PI);
    translate(-pos.x+size.x*.3f, -pos.y-size.y*.05f);
    rect(pos.x-size.x*.3f, pos.y, size.x*.4f, size.y*.1f, size.y*.1f);
    translate(pos.x-size.x*.3f, pos.y+size.y*.05f);
    rotate(-2*QUARTER_PI);
    translate(-pos.x+size.x*.3f, -pos.y-size.y*.03f);
    rect(pos.x-size.x*.3f, pos.y, size.x*.4f, size.y*.1f, size.y*.1f);
    popMatrix();
  }

  if (icon==5) {  // SAVE
    pushMatrix();
    rect(pos.x-size.x*.05f, pos.y-size.y*.4f, size.y*.1f, size.y*.5f, size.y*.1f);
    rect(pos.x-size.x*.35f, pos.y+size.y*.2f, size.x*.7f, size.y*.1f, size.y*.1f);
    translate(size.x*.3f, -size.y*.4f);
    translate(pos.x-size.x*.3f, pos.y+size.y*.50f);
    rotate(PI*1.5f);
    rotate( QUARTER_PI);
    translate(-pos.x+size.x*.3f, -pos.y-size.y*.05f);
    rect(pos.x-size.x*.3f, pos.y, size.x*.4f, size.y*.1f, size.y*.1f);
    translate(pos.x-size.x*.3f, pos.y+size.y*.05f);
    rotate( -2*QUARTER_PI);
    translate(-pos.x+size.x*.3f, -pos.y-size.y*.05f);
    rect(pos.x-size.x*.3f, pos.y, size.x*.4f, size.y*.1f, size.y*.1f);
    popMatrix();
  }

  if (icon==6) {  // PENCIL
    pushMatrix();
    translate(pos.x, pos.y);
    rotate( -QUARTER_PI);
    translate(-pos.x, -pos.y);
    rect(pos.x-size.y*.15f, pos.y-size.y*.1f, size.x*.5f, size.y*.15f, size.y*.1f);
    rotate( QUARTER_PI);
    popMatrix();
    triangle(pos.x-size.x*.2f, pos.y+size.x*.15f, pos.x-size.x*.2f, pos.y+size.x*.2f, pos.x-size.x*.15f, pos.y+size.x*.2f);
  }
  if (icon==7) {  // DELETE HOMES
    pushMatrix();
    translate(pos.x, pos.y);
    rotate( -QUARTER_PI);
    translate(-pos.x, -pos.y);
    rect(pos.x-size.x*.4f, pos.y-size.y*.05f, size.x*.8f, size.y*.1f, size.y*.1f);
    rect(pos.x-size.x*.05f, pos.y-size.y*.4f, size.x*.1f, size.y*.8f, size.y*.1f);
    popMatrix();
  }
  if (icon==8) {  // BUY HOME
    pushMatrix();
    translate(pos.x, pos.y);
    rotate( -QUARTER_PI);
    translate(-pos.x, -pos.y);
    translate(-size.x*.1f, size.y*.1f);
    rect(pos.x-size.y*.15f, pos.y-size.y*.05f, size.x*.6f, size.y*.15f, size.y*.1f);
    rect(pos.x-size.y*.15f, pos.y-size.y*.3f, size.x*.15f, size.y*.4f, size.y*.1f);
    popMatrix();
  }

  if (icon==9) { //MINUS
    rect(pos.x-size.x*.4f, pos.y-size.y*.05f, size.x*.8f, size.y*.1f, size.y*.1f);
    //rect(pos.x-size.x*.05, pos.y-size.y*.4, size.x*.1, size.y*.8, size.y*.1);
  }
  if (icon==10) {  //MORE 3 PUNTOS
    ellipse(pos.x-size.x*.3f, pos.y, size.y*.2f, size.y*.2f);
    ellipse(pos.x, pos.y, size.y*.2f, size.y*.2f);
    ellipse(pos.x+size.x*.3f, pos.y, size.y*.2f, size.y*.2f);
  }
  if (icon==11) { //ACCOUNT
    rect(pos.x-size.x*.35f, pos.y+size.y*.2f, size.x*.7f, size.y*.1f, size.y*.1f);
  }
  if (icon==12) {  // GENERATE
    pushMatrix();
    rect(pos.x-size.x*.3f, pos.y-size.y*+.15f, size.y*.1f, size.y*.3f, size.y*.1f);
    rect(pos.x+size.x*.18f, pos.y-size.y*+.15f, size.y*.1f, size.y*.3f, size.y*.1f);

    rect(pos.x-size.x*.1f, pos.y+size.y*.2f, size.x*.3f, size.y*.1f, size.y*.1f);
    rect(pos.x+size.x*.1f-size.x*.1f, pos.y+size.y*.1f, size.x*.1f, size.y*.3f, size.y*.1f);

    translate(size.x*.3f, -size.y*.4f);
    translate(pos.x-size.x*.3f, pos.y+size.y*.05f);
    rotate(HALF_PI);
    rotate(QUARTER_PI);
    translate(-pos.x+size.x*.3f, -pos.y-size.y*.05f);
    rect(pos.x-size.x*.3f, pos.y, size.x*.4f, size.y*.1f, size.y*.1f);
    translate(pos.x-size.x*.3f, pos.y+size.y*.05f);
    rotate(-2*QUARTER_PI);
    translate(-pos.x+size.x*.3f, -pos.y-size.y*.03f);
    rect(pos.x-size.x*.3f, pos.y, size.x*.4f, size.y*.1f, size.y*.1f);
    popMatrix();
  }
  if (icon==13) { //MINUS
    rect(pos.x-size.x*.2f, pos.y-size.y*.025f, size.x*.4f, size.y*.05f, size.y*.05f);
    //rect(pos.x-size.x*.05, pos.y-size.y*.4, size.x*.1, size.y*.8, size.y*.1);
  }

  if (icon==14) { //PLUS
    rect(pos.x-size.x*.2f, pos.y-size.y*.025f, size.x*.4f, size.y*.05f, size.y*.05f);
    rect(pos.x-size.x*.025f, pos.y-size.y*.2f, size.x*.05f, size.y*.4f, size.y*.05f);
  }
  if (icon==15) { //MINUS
    rect(pos.x-size.x*.3f, pos.y-size.y*.2f, size.x*.6f, size.y*.06f, size.y*.03f);
    rect(pos.x-size.x*.3f, pos.y-size.y*.0f, size.x*.6f, size.y*.06f, size.y*.03f);
    rect(pos.x-size.x*.3f, pos.y+size.y*.2f, size.x*.6f, size.y*.06f, size.y*.03f);
    //rect(pos.x-size.x*.05, pos.y-size.y*.4, size.x*.1, size.y*.8, size.y*.1);
  }
}
class Slider {
  PVector pos, size, mid, end, bupos, bupos2, busize, slsize, slstopb, slstope;
  String name;
  float value, value2, minstopv, maxstopv;
  boolean state, drag, drag2;
  float  minV=0;
  float maxV=1;
  int flt = 1;
  int type = 0;
  int icon = 0;
  float textsize = 12;
  float textdist = 90;
  float scand = 1;
  int con = 100;
  int coff = 200;
  Slider(PVector _pos, PVector _size, String _name, int _type, float _minV, float _value, float _maxV) {
    pos=_pos;
    size=_size;
    calcpos();
    name = _name;
    type = _type;
    minV=_minV;
    value = _value;
    value2=value;
    maxV=_maxV;
  }
  public void calcpos() {
    mid = new PVector(pos.x+size.x*.5f, pos.y+size.y*.5f);
    end = new PVector(pos.x+size.x, pos.y+size.y);
    bupos  = new PVector (map(value, minV, maxV, pos.x, end.x), mid.y);
    bupos2 = new PVector (map(value2, minV, maxV, pos.x, end.x), mid.y);
    busize = new PVector (size.y, size.y);
    slsize = new PVector (size.x, 3*scand);
    slstopb = new PVector (pos.x, pos.y);
    slstope = new PVector (end.x, end.y);
  }
  public void scaletoandroid(float _scand) {
    scand = _scand;
    pos  = new PVector (scand*pos.x, scand*pos.y);
    size  = new PVector (scand*size.x, scand*size.y);
    calcpos();
    textsize = textsize * scand;
  }
  public void addstops(float _minstopV, float _maxstopV) {
    minstopv = _minstopV;
    maxstopv = _maxstopV;
    slstopb = new PVector (map(minstopv, minV, maxV, pos.x, end.x), pos.y);
    slstope = new PVector (map(maxstopv, minV, maxV, pos.x, end.x), end.y);
  }
  public void addsecond(float _value2) {
    value2 = _value2;
    calcpos();
  }
  public void display() {
    pushStyle();
    rectMode(CORNER);
    textSize(textsize);
    if (type==10) {
      if (flt<0) value = PApplet.parseInt(roundit(map(bupos.x, pos.x, end.x, minV, maxV), flt)); 
      else value = roundit(map(bupos.x, pos.x, end.x, minV, maxV), flt);  
      if (drag) bupos.x = constrain(mouseX, slstopb.x, slstope.x);
      if (slstopb!=null)if (slstopb.x!=pos.x) line(slstopb.x, slstopb.y-(busize.y*.2f), slstopb.x, slstopb.y+slsize.y+(busize.y*.2f));
      if (slstope!=null)if (slstope.x!=end.x) line(slstope.x, slstope.y-slsize.y-(busize.y*.2f), slstope.x, slstope.y+(busize.y*.2f));
      noStroke();
      fill(coff);
      rect(pos.x, mid.y-slsize.y*.5f, slsize.x, slsize.y, slsize.y*.5f); 
      fill(con);
      rect(pos.x, mid.y-slsize.y*.5f, bupos.x-pos.x, slsize.y, slsize.y/2); 
      strokeWeight(1*scand);
      if (isover()) strokeWeight(2*scand);
      stroke(con);
      fill(255);
      ellipse(bupos.x, mid.y, busize.x, busize.y);
      fill(con);
      textAlign(CENTER, CENTER);
      if (flt<=0) text( PApplet.parseInt(value), bupos.x, bupos.y-textsize*.6f);
      else text( nfc(value, 2), bupos.x, bupos.y-textsize*.6f); 
      fill(con);
      textAlign(LEFT, CENTER);
      text(name, pos.x-textdist, mid.y);
      strokeWeight(1*scand);
    }
    if (type==20) {
      if (flt<0) value = PApplet.parseInt(roundit(map(bupos.x, pos.x, end.x, minV, maxV), flt)); 
      if (flt<0) value2 = PApplet.parseInt(roundit(map(bupos2.x, pos.x, end.x, minV, maxV), flt));
      if (flt>=0) value = roundit(map(bupos.x, pos.x, end.x, minV, maxV), flt);
      if (flt>=0) value2 = roundit(map(bupos2.x, pos.x, end.x, minV, maxV), flt);
      if (drag) bupos.x = constrain(mouseX, slstopb.x, bupos2.x-busize.y);
      if (drag2) bupos2.x = constrain(mouseX, bupos.x+busize.y, slstope.x);
      if (slstopb!=null)if (slstopb.x!=pos.x) line(slstopb.x, slstopb.y-(busize.y*.2f), slstopb.x, slstopb.y+slsize.y+(busize.y*.2f));
      if (slstope!=null)if (slstope.x!=end.x) line(slstope.x, slstope.y-slsize.y-(busize.y*.2f), slstope.x, slstope.y+(busize.y*.2f));
      noStroke();
      fill(coff);
      rect(pos.x, mid.y-slsize.y*.5f, slsize.x, slsize.y, slsize.y*.5f); 
      fill(con);
      rect(bupos.x, mid.y-slsize.y*.5f, bupos2.x-bupos.x, slsize.y, slsize.y/2); 
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
      if (flt<=0) text( PApplet.parseInt(value), bupos.x, pos.y-textsize*.6f);
      else text( nfc(value, 2), bupos.x, pos.y-textsize*.6f); 
      if (flt<=0) text( PApplet.parseInt(value2), bupos2.x, pos.y-textsize*.6f);
      else text( nfc(value2, 2), bupos2.x, pos.y-textsize*.6f); 
      fill(con);
      textAlign(LEFT, CENTER);
      text(name, pos.x-textdist, mid.y);
      strokeWeight(1*scand);
    }
    popStyle();
  }
  public boolean isover() {
    return (mouseX>bupos.x-busize.x*.5f&&mouseX<bupos.x+busize.x*.5f&&mouseY>mid.y-busize.y*.5f&&mouseY<mid.y+busize.y*.5f);
  }
  public boolean isover2() {
    return (mouseX>bupos2.x-busize.x*.5f&&mouseX<bupos2.x+busize.x*.5f&&mouseY>mid.y-busize.y*.5f&&mouseY<mid.y+busize.y*.5f);
  }
  public void press() {
    if (isover()) drag = true;
    if (isover2()) drag2 = true;
  }
  public void release() {
    drag = false;
    drag2 = false;
  }
    public float roundit(float numin, int dec) {                                              
    float dec10 = pow(10, dec);
    float roundout = round(numin * dec10)/dec10;
    return roundout;
  }
}
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
  int con = 200;
  int coff = 100;
  Text(PVector _pos, PVector _size, String _name, int _type) {
    pos=_pos;
    size=_size;
    calcpos();
    name = _name;
    type = _type;
  }
  public void scaletoandroid(float _scand) {
    scand = _scand;
    pos = new PVector (pos.x*scand, pos.y*scand);
    size = new PVector (size.x*scand, size.y*scand);
    calcpos();
    textsize  = textsize*scand;
  }
  public void calcpos() {
    mid = new PVector(pos.x+size.x*.5f, pos.y+size.y*.5f);
    end = new PVector(pos.x+size.x, pos.y+size.y);
  }
  public void display() {
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
    if (itext.length()==0&&!state) text(name, mid.x, mid.y-textsize*.3f);
    if (type==10&&itext.length()<50) {
      if (state) text(itext+dash, mid.x, mid.y-textsize*.3f);
      else text(itext, mid.x, mid.y-textsize*.3f);
    }
    if (type==20&&itext.length()<50) {
      String textp = "";
      for (int i=0; i<itext.length(); i++) textp = textp + "*";
      if (state) text(textp+dash, mid.x, mid.y-textsize*.3f);
      else text(textp, mid.x, mid.y-textsize*.3f);
    }
    
  }
    public boolean isover() {
    if (mouseX>pos.x&&mouseX<end.x&&mouseY>pos.y&&mouseY<end.y) return true;
    else return false;
  }
    public void select() {
    if (isover()) state = !state;
  }
  public void unselect() {
    if (state)if (!isover()) state = false;
  }
    public void type() {
    if (state) {
      if ((key >= 'A' && key <= 'z') ||(key >= '0' && key <= '9') || key == ' '|| key=='('|| key==')'|| key==','|| key=='.'|| key=='|'||key=='@'||key=='-'||key=='_')   itext = itext + str(key);
      if ((key == CODED&&keyCode == LEFT)||keyCode == BACKSPACE)  if (itext.length()>0) itext = itext.substring(0, itext.length()-1);
    }
  }
}

public boolean textis(ArrayList <Text> alltx) {
  boolean bout = false;
  for (Text a : alltx) if (a.state) bout = true;
  return bout;
}
class textrect {
  PVector pos, size;
  String text;
  int i;
  textrect(PVector _pos, PVector _size, String _text, int _i) {
    pos=_pos;
    size=_size;
    text=_text;
    i=_i;
  }
  public void display() {
    fill(255);
    textAlign(CENTER, CENTER);
    rect(pos.x, pos.y, size.x, size.y);
    fill(100);
    if (text!=null) text(text, pos.x + size.x*.5f, pos.y + size.y*.5f);
  }
}


//                                                                              INT
//                                                                                     factorials
public int factorial(int num) {
  if (num>12) println("numero factorial muy grande");
  return fact(num);
}
public int fact(int num) {
  if (num <= 1) return 1;
  else return num*fact(num - 1);
}                                   
public int min0(int num) {
  if (num>=0) return num;
  else return 0;
}
//                                                                              FLOAT
public float roundit(float numin, int dec) {                                                    //round
  float dec10 = pow(10, dec);
  float roundout = round(numin * dec10)/dec10;
  return roundout;
}
public float roundspan(float fin, float spanu) {
  float fout = fin + spanu*.5f;
  fout = roundit(fout-(fout%spanu), 2);
  return fout;
}
public float divNaN0(float a, float b) {
  if (a==0&&b==0) return 0;
  else return a/b;
} 
public float [] ranflarr(int num, float min, float max) {                                     //   random array
  float rout[] = new float [num];
  for (int i=0; i<rout.length; i++) rout [i] = random(min, max);
  return rout;
}
public float min0max1fl(int min0max1, float a, float b) {
  float fout;
  if ((min0max1==0&&a<b)||(min0max1==1&&a>b))  fout=a;
  else fout =b;
  return fout;
}
public float [] cloneflarr(float [] flin) {                                                   //clone float array
  float [] flout = new float [flin.length];
  for (int i=0; i<flin.length; i++) flout[i] = flin[i];
  return flout;
}
public float [] cloneflarrpart(float [] flin, int inv, int finv) {                           //clone part of float array
  float [] flout = new float [finv-inv];
  for (int i=0; i<finv-inv; i++) flout[i] = flin[i+inv];
  return flout;
}
//VECTOR
public PVector clonevector(PVector vectorin) {
  return new PVector (vectorin.x, vectorin.y);
}
//                                                                              STRING
//                                                                                      equal
public boolean txequal(String a, String b) {
  if (a==null||b==null) return false;
  else {
    int al= a.length();
    int bl= b.length();
    int minl;
    boolean bout = true;
    if (al!=bl) bout = false;
    if (al<bl) minl = al;
    else minl = bl;
    for (int i=0; i<minl; i++) if (a.charAt(i)!=b.charAt(i)) bout = false; 
    return bout;
  }
}
public String [] clonestarr(String [] stin) {
  String [] stout = new String [stin.length];
  for (int i=0; i<stin.length; i++) stout[i] = stin[i];
  return stout;
}
public String [][] clonedstarr(String [][] stin) {
  String [][] stout = new String [stin.length][];
  for (int i=0; i<stout.length; i++) stout [i] = new String [stin[i].length];
  for (int i=0; i<stout.length; i++) for (int j=0; j<stout[i].length; j++)  stout[i][j] = stin[i][j];
  return stout;
}
public ArrayList <String> removeemptyst(ArrayList <String> stin) {
  ArrayList <String> stout = new ArrayList <String> ();
  for (int i=0; i<stin.size(); i++) if (!txequal(stin.get(i), "")) stout.add(stin.get(i));
  return stout;
}
public String [] removeemptystarr(String [] stin) {
  ArrayList <String> stout = new ArrayList <String> ();
  for (int i=0; i<stin.length; i++) if (!txequal(stin[i], "")) stout.add(stin[i]);
  String starrout[] = new String [stout.size()];
  for (int i=0; i<starrout.length; i++) starrout[i] = stout.get(i);
  return starrout;
}
public boolean stinstarr(String stx, String [] starr) {
  boolean isinarr = false;
  for (int i=0; i<starr.length; i++) if (txequal(stx, starr[i])) isinarr = true;
  return isinarr;
}
public String [] starrDElist(ArrayList <String> stin) {
  String [] stout = new String [stin.size()];
  for (int i=0; i<stin.size(); i++) stout[i] = stin.get(i);
  return stout;
}
public String [] addstTOarr(String stx, String [] starr) {
  String [] stout = new String [starr.length+1]; 
  for (int i=0; i<starr.length; i++)  stout[i] = starr[i];
  stout[stout.length-1] = stx;
  return stout;
}
public String [] removestFROMarr(String stx, String [] starr) {
  ArrayList <String> stlist = new ArrayList <String>() ; 
  for (int i=0; i<starr.length; i++) if (!txequal(starr[i], stx)) stlist.add(starr[i]);
  String [] stout = new String [stlist.size()];
  for (int i=0; i<stout.length; i++) stout [i] = stlist.get(i);
  return stout;
}
//                                                                                        permutations
public String[] permutation01(String [] pre, float num) {
  int numin = factorial(pre.length)-1;
  if (num<1)  numin =PApplet.parseInt(map(num, 0, 1, 0, factorial(pre.length))); 
  String newA[] = perm(pre, 0, new ArrayList <String[]> (), numin);
  return newA;
}
public String[]  perm(String[] iA, int s, ArrayList <String[]> igm, int nume) {    
  for (int i = s; i < iA.length; i++) {
    String temp = iA[s];
    iA[s] = iA[i];
    iA[i] = temp;
    perm(iA, s + 1, igm, nume);
    iA[i] = iA[s];
    iA[s] = temp;
  }
  if (s == iA.length - 1) {
    String toadd= "";
    for (int i=0; i<iA.length-1; i++) toadd = toadd + iA[i] + ",";
    toadd = toadd + iA[iA.length-1];   
    igm.add(split(toadd, ","));
  }
  String [] ig1 = null;
  if (igm.size()>nume)  ig1 = igm.get(nume);
  return ig1;
}
//DRAW
public void daline( PVector a, PVector b, float space) {
  float inline = space/PVector.dist(b, a);
  for (float i=0; i<=1-inline; i+=inline) {
    float x1 = (b.x*i)+(a.x*(1-i));
    float y1 = (b.y*i)+(a.y*(1-i));
    float x2 = (b.x*(i+(inline*.5f)))+(a.x*(1-(i+(inline*.5f))));
    float y2 = (b.y*(i+(inline*.5f)))+(a.y*(1-(i+(inline*.5f))));
    line(x1, y1, x2, y2);
  }
}


public Table loadtableandroid(String filenamed, String filetyped, boolean inandroid) {      ///SAVE LOAD TABLES
  Table tout;
  String fullname = filenamed + "." + filetyped;
  tout = loadTable(fullname, "header");
  if (inandroid) {
    try {                                                                                                          
      tout  =  new  Table(new  File(sketchPath("")+fullname), "header");
    } 
    catch  (Exception  e) {   
      try { 
        tout.save(new  File(sketchPath("")+filenamed), filetyped);
      }
      catch(IOException  iox) {
        println("Failed  to  write  file.");
      }
    }
  }
  return tout;
}
public void savetableandroid(String filenamed, String filetyped, boolean inandroid, Table tablein) {
  String fullname = filenamed + "." + filetyped;
  if (!inandroid) {
    saveTable(tablein, "data/" + fullname);
    println("saved");
  }
  if (inandroid) {
    try {        
      tablein.save(new  File(sketchPath("")+fullname), filetyped);
      println("saved");
    }    
    catch(IOException  iox) {        
      println("Failed  to  write  file."  +  iox.getMessage());
    }
  }
}

public boolean isoverpossize(PVector pos, PVector size) {
  return (mouseX>pos.x&&mouseX<pos.x+size.x&&mouseY>pos.y&&mouseY<pos.y+size.y);
}


public float [] flarrDEstarr(String [] starr) {
  float [] flout = new float [starr.length];
  for (int i=0; i<starr.length; i++) flout [i] = PApplet.parseFloat (starr[i]);
  return flout;
}

public int [] inarrDEstarr(String [] starr) {
  int [] inout = new int [starr.length];
  for (int i=0; i<starr.length; i++) inout [i] = PApplet.parseInt (starr[i]);
  return inout;
}
  public void settings() {  size(500,500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#050505", "--hide-stop", "UI" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
