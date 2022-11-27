//generates the three obstacles
class Obstacle {
    float posX;
    int boxw, boxh;
    int type;
    Obstacle(int t) {
        posX = width;
        type = t;
        switch (type) {
            case 0:
                boxw = 50;
                boxh = 40;
                break;
            case 1:
                boxw = 50;
                boxh = 40;
                break;
            case 2:
                boxw = 150;
                boxh = 40;
                break;
        }
    }
    void display() {
        switch (type) {
            case 0:
                image(obstacle, posX - obstacle.width / 2, height - groundHeight - obstacle.height);
                break;
            case 1:
                image(tallobstacle, posX - tallobstacle.width / 2, height - groundHeight - tallobstacle.height);
                break;
            case 2:
                image(groupedobstacle, posX - groupedobstacle.width / 2, height - groundHeight - groupedobstacle.height);
                break;
        }
    }
    void move(float speed) {
        posX -= speed;
    }
    boolean collided(float boxX, float boxY, float boxWidth, float boxHeight) {
        float boxLeft = boxX - boxWidth / 2;
        float boxRight = boxX + boxWidth / 2;
        float obstacleLeft = posX - boxw / 2;
        float obstacleRight = posX + boxw / 2;
        if (boxLeft < obstacleRight && boxRight > obstacleLeft) {
            float thebox = boxY - boxHeight / 2;
            float theobstacle = boxh;
            // if collided
            if (thebox < theobstacle) {
                return true;
            }
        }
        return false;
    }
}
