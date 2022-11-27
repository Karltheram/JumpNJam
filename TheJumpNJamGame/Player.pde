//generates the box and changes appearance
class Player {
    float posY = 0;
    float velY = 0;
    float gravity = 1.2;
    int size = 20;
    boolean dead = false;
    int runCount = -5;
    int lifespan;
    int score;
    Player() {}
    void jump() {
        if (posY == 0) {
            gravity = 1.2;
            velY = 16;
        }
    }
    void display() {
        if (posY == 0) {
            if (runCount < 0) {
                image(Box1, playerXpos - Box1.width / 2, height - groundHeight - (posY + Box1.height));
            } else {
                image(Box2, playerXpos - Box2.width / 2, height - groundHeight - (posY + Box2.height));
            }
        } else if (dead) {
            image(boxdead, playerXpos - boxdead.width / 2, height - groundHeight - (posY + boxdead.height));
        } else {
            image(BoxJump, playerXpos - BoxJump.width / 2, height - groundHeight - (posY + BoxJump.height));
        }
        if (!dead) {
            runCount++;
        }
        if (runCount > 5) {
            runCount = -5;
        }
        if (dead) {
            image(boxdead, playerXpos - boxdead.width / 2, height - groundHeight - (posY + boxdead.height));
        }
    }
    void move() {
        posY += velY;
        if (posY > 0) {
            velY -= gravity;
        } else {
            velY = 0;
            posY = 0;
        }
        for (int i = 0; i < obstacles.size(); i++) {
            if (obstacles.get(i).collided(playerXpos, posY + Box1.height / 2, Box1.width * 0.5, Box1.height)) {
                dead = true;
            }
        }
    }
    void update() {
        incrementCounter();
        move();
    }
    void incrementCounter() {
        lifespan++;
        if (lifespan % 3 == 0) {
            score += 1;
        }
    }
    void bedead(){
    dead = true;
    }
}
