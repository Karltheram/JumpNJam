//The Sprites
PImage Box1;
PImage Box2;
PImage BoxJump;
PImage obstacle;
PImage tallobstacle;
PImage groupedobstacle;
PImage boxdead;

//Container for the obstacles
ArrayList < Obstacle > obstacles = new ArrayList < Obstacle > ();

//Variables for timers,speed,score,positions etc
int obstacleTimer = 0;
int minTimeBetObs = 60;
int randomAddition = 0;
float speed = 10;
int groundHeight = 50;
int playerXpos = 100;
int highScore = 0;


//Music,Sound and video background
import processing.sound.*;
SoundFile home;
SoundFile Easygame;
SoundFile Hardgame;
SoundFile thedeath;
import processing.video.*;
Movie homevid;
Movie easyvid;
Movie hardvid;

//object declaration
Player box;
Button easy;
Button hard;
Button quit;
Button stop;

//condition to for death sound to play once 
int playedonce = 0;

//to switch screens
int gameScreen = 0;

void setup() {
    size(1440, 950);
    frameRate(60);
    
    //loading images
    Box1 = loadImage("Box 1.png");
    Box2 = loadImage("Box 2.png");
    BoxJump = loadImage("BoxJump.png");
    obstacle = loadImage("Obstacle.png");
    tallobstacle = loadImage("TallObstacle.png");
    groupedobstacle = loadImage("GroupedObstacle.png");
    boxdead = loadImage("Boxdead.png");
    
    //constructing objects
    box = new Player();
    easy = new Button(width / 2 / 2, height / 2, 100, "Easy Mode", color(0, 255, 255));
    hard = new Button(width / 2 / 2 + width / 2, height / 2, 100, "Hard Mode", color(255, 0, 9));
    quit = new Button(width / 2, height / 2 /2 + height/ 2, 100, "Quit", color(250,130, 61));
    stop = new Button(width / 2 / 2 / 2, height / 2 / 2 / 2, 100, "Stop", color(250,130, 61));
    
    // video backgrounds
    homevid = new Movie(this, "Retro.mov");
    easyvid = new Movie(this, "Easy.mov");
    hardvid = new Movie(this, "Hard.mov");
    thedeath = new SoundFile(this, "death.wav");
    
    // swtich screen conditions
    if (gameScreen == 0) {
        home = new SoundFile(this, "SpaceDubstep.mp3");
        home.loop();
    } else if (gameScreen == 1 && !box.dead) {
        Easygame = new SoundFile(this, "Stars.mp3");
        Easygame.loop();
    } else if (gameScreen == 2) {
        Hardgame = new SoundFile(this, "PinkBloom.mp3");
        Hardgame.loop();
    }
}

void draw() {
    if (gameScreen == 0) {
        homescreen();
    } else if (gameScreen == 1) {
        easyScreen();
    } else if (gameScreen == 2) {
        speed = 20;
        hardScreen();
    }
}

// the screens
void homescreen() {
    homevid.loop();
    image(homevid, 0, 0);
    fill(255, 255, 255);
    textSize(30);
    if (easy.visible) easy.show();
    if (hard.visible) hard.show();
    if (quit.visible) quit.show();
    textAlign(CENTER);
    textSize(60);
    fill(234, 143, 252);
    text("Jump N Jam", width / 2, 300);
}
void easyScreen() {
    //video playing 
    easyvid.loop();
    image(easyvid, 0, 0);
    if (stop.visible) stop.show();
    stroke(0);
    strokeWeight(2);
    fill(234, 143, 252);
    rect(0, height - groundHeight - 30, width, height - groundHeight - 30);
    rect(0, 800, width, 500);
    easygamemode();
    if (box.score > highScore) {
        highScore = box.score;
    }
    if (!box.dead) {
        textSize(20);
        fill(255);
        text("Score: " + box.score, 50, 20);
        text("High Score: " + highScore, width - (140 + (str(highScore).length() * 10)) + 60, 20);
    } else {
        textSize(20);
        fill(255);
        text("Score: " + box.score, width / 2, 200);
        text("High Score: " + highScore, width / 2, 250);
    }
}
void hardScreen() {
    hardvid.loop();
    image(hardvid, 0, 0);
    if (stop.visible) stop.show();
    stroke(0);
    strokeWeight(2);
    fill(61, 109, 250);
    rect(0, height - groundHeight - 30, width, height - groundHeight - 30);
    rect(0, 800, width, 500);
    hardgamemode();
    if (box.score > highScore) {
        highScore = box.score;
    }
    if (!box.dead) {
        textSize(20);
        fill(255);
        text("Score: " + box.score, 50, 20);
        text("High Score: " + highScore, width - (140 + (str(highScore).length() * 10)) + 60, 20);
    } else {
        textSize(20);
        fill(255);
        text("Score: " + box.score, width / 2, 200);
        text("High Score: " + highScore, width / 2, 250);
    }
}

//INPUTS
void keyPressed() {
    if (key == ' ') {
        box.jump();
    }
}
void keyReleased() {
    if (key == 'r' && box.dead) {
        if (gameScreen == 1) {
            easyreset();
            Easygame.loop();
        } else if (gameScreen == 2) {
            hardreset();
            Hardgame.loop();
        }
    } else if (key == 'b' && box.dead) {
        if (gameScreen == 1) {
            easyreset();
            Easygame.stop();
        } else if (gameScreen == 2) {
            hardreset();
            Hardgame.stop();
        }
        gameScreen = 0;
        setup();
    }else if (key == 'x' && box.dead) {
        exit();
    }
}
public void mousePressed() {
    // if we are on the initial screen when clicked, Switches to menu
    if (easy.visible) {
        float d = dist(easy.pos.x, easy.pos.y - 10, mouseX, mouseY);
        if (d <= easy.radius - 52) {
            if (gameScreen == 0) {
                startEasy();
            }
        }
    }
    if (hard.visible) {
        float d = dist(hard.pos.x, hard.pos.y - 10, mouseX, mouseY);
        if (d <= hard.radius - 52) {
            if (gameScreen == 0) {
                startHard();
            }
        }
    }
    if (quit.visible) {
        float d = dist(quit.pos.x, quit.pos.y - 10, mouseX, mouseY);
        if (d <= quit.radius - 52) {
            exit();
        }
    }
    if (stop.visible) {
        float d = dist(stop.pos.x, stop.pos.y - 10, mouseX, mouseY);
        if (d <= stop.radius - 52) {
            box.bedead();
        }
    }
}

//where obstacles and the player is being run
void easygamemode() {
    showObstacles();
    box.display();
    if (!box.dead) {
        obstacleTimer++;
        speed += 0.002;
        if (obstacleTimer > minTimeBetObs + randomAddition) {
            addObstacle();
        }
        moveObstacles();
        box.update();
    } else {
        Easygame.stop();
        if (!thedeath.isPlaying() && playedonce != 1) {
            thedeath.play();
            playedonce = 1;
        }
        fill(0);
        rect(540, 150, 350, 350);
        textSize(32);
        fill(255);
        text("Good Job!", width / 2, 300);
        textSize(16);
        text("(Press 'r' to restart!)", width / 2, 350);
        text("(Press 'b' to go home!)", width / 2, 400);
        text("(Press 'x' to go exit game!)", width / 2, 450);
    }
}
void hardgamemode() {
    showObstacles();
    box.display();
    if (!box.dead) {
        obstacleTimer++;
        speed += 1;
        if (obstacleTimer > minTimeBetObs + randomAddition) {
            addObstacle();
            addObstacle();
        }
        moveObstacles();
        box.update();
    } else {
        Hardgame.stop();
        if (!thedeath.isPlaying() && playedonce != 1) {
            thedeath.play();
            playedonce = 1;
        }
        fill(0);
        rect(540, 150, 350, 350);
        textSize(32);
        fill(255);
        text("Good Job!", width / 2, 300);
        textSize(16);
        text("(Press 'r' to restart!)", width / 2, 350);
        text("(Press 'b' to go home!)", width / 2, 400);
        text("(Press 'x' to go exit game!)", width / 2, 450);
    }
}
void showObstacles() {
    for (int i = 0; i < obstacles.size(); i++) {
        obstacles.get(i).display();
    }
}
void addObstacle() {
    if (random(1) < 0.15) {
        obstacles.add(new Obstacle(floor(random(3))));
    } else {
        obstacles.add(new Obstacle(floor(random(3))));
    }
    randomAddition = floor(random(50));
    obstacleTimer = 0;
}
void moveObstacles() {
    for (int i = 0; i < obstacles.size(); i++) {
        obstacles.get(i).move(speed);
        if (obstacles.get(i).posX < -playerXpos) {
            obstacles.remove(i);
            i--;
        }
    }
}

//reset functions
void easyreset() {
    box = new Player();
    obstacles = new ArrayList < Obstacle > ();
    obstacleTimer = 0;
    randomAddition = floor(random(50));
    playedonce = 0;
    speed = 10;
}
void hardreset() {
    box = new Player();
    obstacles = new ArrayList < Obstacle > ();
    obstacleTimer = 0;
    randomAddition = floor(random(50));
    playedonce = 0;
    speed = 10;
}

//functions to trigger easy mode or hard mode
void startEasy() {
    gameScreen = 1;
    home.stop();
    setup();
}
void startHard() {
    gameScreen = 2;
    home.stop();
    setup();
}

// plays the videos
void movieEvent(Movie homevid) {
    homevid.read();
}
void movieEvent1(Movie easyvid) {
    easyvid.read();
}
void movieEvent2(Movie hardvid) {
    hardvid.read();
}
