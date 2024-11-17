float[] set;
int gap, i1, tmp , j;
String text;
float offset = 0;
boolean run = true;
int time = 0;
void setup() {
  size(800, 600);
  frameRate(60);
  set = new float[int(0.99*width)];
  offset = 0.01*width/2;
  for (int i = 0; i < set.length; i++) set[i] = map(i, 0, set.length - 1, height/50, 9*height/10);
  disorder(set);
  gap = set.length/2;
  i1 = gap;
}

void draw() {
  background(0);
  textSize(20);
  if (run) {
    if (gap > 0) {
      if (i1 < set.length) {
        float tmp = set[i1];
        int j;
        for (j = i1; j >= gap && set[j - gap] > tmp; j -= gap) set[j] = set[j - gap];
        set[j] = tmp;
        i1++;
      }
      else {
        gap /= 2;
        i1 = gap;
      }
      text = "Time: " + (millis() - time) + " ms";
      text(text, 20, 20);
    }
    else {
      run = false;
      time = millis() - time;
    }
  }
  else {
    fill(255);
    text = "Time: " + time + " ms";
    text("finished!\n" + text, 20, 20);
  }

  stroke(255);
  for (int i = 0; i < set.length; i++) {
    line(i + offset, height, i + offset, height-set[i]);
  }
}

void swap(float[] arr, int a, int b) {
  if (a != b) {
    arr[a] += arr[b];
    arr[b] = arr[a] - arr[b];
    arr[a] = arr[a] - arr[b];
  }
}

void disorder(float[] arr) {
  for (int i = 0; i < set.length; i++) {
    int x = round(random(set.length - 1));
    if (i != x) swap(arr, i, x);
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    disorder(set);
    gap = set.length/2;
    i1 = gap;
    time = millis();
    run = true;
  }
}
