ArrayList <Click> c;
ArrayList <Toggle> t;
ArrayList <Option> o;
ArrayList <Slider> s;
ArrayList <Text> tx;
ArrayList <Textrect> r;
void setup() {
  size(1000, 800);
  createfile("zz_ui.pde", "UI.pde", sketchPath("")+"data/");
  c = new ArrayList <Click> ();
  int [] ctypes = {20, 21, 30, 31, 32, 40, 41};
  PVector [] csizes = new PVector [7];
  for (int i=0; i<csizes.length; i++) csizes[i] = new PVector (10, i*60);
  for (int i=0; i<csizes.length; i++) c.add(new Click(csizes[i], new PVector (40, 40), "Click"+i, ctypes[i]));           //(PVector _pos, PVector _size, String _name, int _type) {
  t = new ArrayList <Toggle> ();
  int [] ttypes = {10, 11, 12, 20, 21, 22, 30, 31, 40, 50};
  PVector [] tsizes = new PVector [10];
  PVector [] tsizess = {new PVector (40, 20), new PVector (40, 20), new PVector (40, 20), new PVector (20, 20), new PVector (20, 20), new PVector (20, 20), new PVector (60, 20), new PVector (20, 60), new PVector (80, 20), new PVector (40, 40)};
  for (int i=0; i<tsizes.length; i++) tsizes[i] = new PVector (100, i*60+10);
  for (int i=0; i<tsizes.length; i++) t.add(new Toggle(tsizes[i], tsizess[i], "Toggle"+i, ttypes[i])); 
  t.get(6).calcposhide( new PVector (100, 6*55+10+100));
  t.get(7).calcposhide( new PVector (100+100, 7*55+10));
  o = new ArrayList <Option> ();
  int [] otypes = {10, 11, 12, 13, 20, 30, 31};
  PVector [] osizes = new PVector [7];
  String so [] = {"a", "b", "c"};
  for (int i=0; i<osizes.length; i++) osizes[i] = new PVector (250, i*120);
  for (int i=0; i<osizes.length; i++)  o.add(new Option(osizes[i], new PVector (40, 30), so, otypes[i]));
  s = new ArrayList <Slider> ();
  int [] stypes = {10, 11, 20};
  PVector [] ssizes = new PVector [3];
  for (int i=0; i<ssizes.length; i++) ssizes[i] = new PVector (400, i*120);
  PVector [] ssizess = {new PVector (100, 20), new PVector (20, 100), new PVector (100, 20)};
  for (int i=0; i<ssizes.length; i++) s.add(new Slider(ssizes[i], ssizess[i], "Slider" + i, stypes[i], 0, 4, 10));
  s.get(2).addsecond(8);
  tx = new ArrayList <Text> ();
  int [] txtypes = {10, 20};
  PVector [] txsizes = new PVector [2];
  for (int i=0; i<txsizes.length; i++) txsizes[i] = new PVector (600, i*120);
  for (int i=0; i<txsizes.length; i++)  tx.add(new Text(txsizes[i], new PVector (100, 30), "Text" +i, txtypes[i]));
}
void draw() {
  background(255);
  for (int i=0; i<c.size(); i++) c.get(i).display();
  for (int i=0; i<t.size(); i++) if (i!=7) t.get(i).display();
  for (int i=0; i<o.size(); i++)  o.get(i).display();
  for (int i=0; i<s.size(); i++)  s.get(i).display();
  for (int i=0; i<tx.size(); i++)  tx.get(i).display();
}
void mousePressed() {
  for (int i=0; i<c.size(); i++) c.get(i).presson();
  for (int i=0; i<c.size(); i++) c.get(i).pressoff();
  for (int i=0; i<t.size(); i++) t.get(i).press();
  for (int i=0; i<o.size(); i++) o.get(i).press();
  for (int i=0; i<s.size(); i++) s.get(i).press();
  for (int i=0; i<tx.size(); i++) tx.get(i).presson();
}
void mouseReleased() {
  for (int i=0; i<s.size(); i++) s.get(i).release();
}
void keyPressed() {
  for (int i=0; i<tx.size(); i++) tx.get(i).type();
}
void createfile(String filename, String filetoexclude, String filepath) {
  saveStrings(dataPath(filepath + filename), joinfilestrings(listFileNames(filetoexclude, sketchPath())));
  println("file created in data, dont forget to save before executing");
}
String [] joinfilestrings(ArrayList <String> filenames) {
  ArrayList <String> alltext = new ArrayList <String> ();
  for (String n : filenames) {
    String[] lines = loadStrings(n);
    for (String s : lines) alltext.add(s);
  }
  String alltextst [] =  new String [alltext.size()];
  for (int i=0; i<alltext.size(); i++) alltextst [i] =alltext.get(i);
  return alltextst;
}
ArrayList <String> listFileNames(String filename, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String allnames[] = file.list();
    ArrayList <String> names = new ArrayList <String> ();
    for (int i=0; i<allnames.length; i++) if (!txequal123(allnames[i], filename)&&(txequal123(allnames[i].substring(allnames[i].length()-3, allnames[i].length()), "pde")))names.add(allnames[i]);
    return names;
  } else return null;
}
boolean txequal123(String a, String b) {
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
