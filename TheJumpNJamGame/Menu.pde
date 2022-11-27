//To display easy mode and hard mode buttons
class Button {
    PVector pos;
    float radius;
    color col;
    String caption;
    boolean visible;
    Button(float x, float y, float r, String txt, color c) {
        pos = new PVector(x, y);
        radius = r;
        caption = txt;
        col = c;
        visible = true;
    }
    void show() {
        fill(col);
        strokeWeight(3);
        rect(pos.x - 100, pos.y - 60, radius * 2, radius);
        fill(0);
        float fontSize = radius * 0.33;
        textSize(fontSize);
        float tx = pos.x;
        float ty = pos.y;
        text(caption, tx, ty);
    }
}
