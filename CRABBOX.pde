import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import processing.serial.*;
import cc.arduino.*;
Arduino arduino;
int buttonPin = 7; // left button
int buttonPin1 = 8; // right button

int crabMin; // left-most edge of crab
int crabMax; // right-most edge of crab

int anchorMin; // left-most edge of anchor, anchorMin = anchorX - anchorWidth/2
int anchorMax; // right-most edge of anchor, anchorMax = anchorX + anchorWidth/2

float crabX = random(displayWidth); // crab starting position

float crabFact;

float anchorX = random(displayWidth); // anchor starting position
int anchorY = 0; // anchor falling

int crabSpeed;
int anchorSpeed;

int holdsecond = second();
int howlongtoshow = 5;
boolean crabFacts = false;

boolean gameStart = false;

PImage background;
PImage anchor; // anchor image
PImage crab; // crab image

// music
Minim minim;
AudioPlayer au_player1;

// CRAB FACTS
String crabFact1 = "William Parsons observed a supernova in 1840 and produced a drawing that resembled a crab, effectively naming the Crab Nebula.";
String crabFact2 = "Despite their name, krabby patties are not actually made out of crab.";
String crabFact3 = "Hermit crabs, king crabs, porcelain crabs, horseshoe crabs, and crab lice are not true crabs.";
String crabFact4 = "Crabs vary in size from a few millimeters wide to up to 4 meters in leg span.";
String crabFact5 = "Male fiddler crabs wave their one large claw about in order to attract females.";
String crabFact6 = "Female crabs can store sperm for a long time before using it to fertilize their eggs.";
String crabFact7 = "When you sleep, crabs lay eggs in your brain. And you should be happy about it.";
String crabFact8 = "Crabocrombie and Fitch";
String crabFact9 = "Crabs have shells.";
String crabFact10 = "A crab invtented the microwave.";
String crabFact11 = "David Bowie was a crab that got caught up in a dare that went too far.";
String crabFact12 = "Crabs are decapods, or crustaceans with 10 limbs.";
String crabFact13 = "A crab's abdomen is curled up underneath their main shell.";
String crabFact14 = "Most crabs have flat bodies that enable them to squeeze into very narrow crevices.";
String crabFact15 = "A crab's shell is really a skeleton on the outside of its body.";
String crabFact16 = "A strong waterspout may sweep up crabs that live near the water and then rain them down over land.";
String crabFact17 = "The largest crab in the world is the Japanese Spider Crab, which can measure up to 13 feet across.";
String crabFact18 = "There are about 4,500 species of true crabs.";
String crabFact19 = "All crabs have claws on their two front legs.";
String crabFact20 = "While shooting 'The Internship,' Vince Vaughn and Owen Wilson compared their extensive crab collections between takes.";
String crabFact21 = "All crabs have one pair of pincers and four pairs of walking legs.";
String crabFact22 = "Crabs have large compound eyes made up of hundreds of tiny lenses.";
String crabFact23 = "A crab can use its claws as a vice for crushing or like scissors for cutting. They can also be used like chopsticks to pick up food.";
String crabFact24 = "The Sally Lightfoot crab is not considered very edible by humans.";
String crabFact25 = "Crabs live in more different places than any other sea animal.";
String crabFact26 = "Crab larvae float for several weeks before settling to the ocean floor to hatch.";
String crabFact27 = "Crabs communicate by flapping their pincers or drumming their claws.";
String crabFact28 = "A female crab lays millions of eggs at one time.";
String crabFact29 = "A group of crabs is called a cast.";
String crabFact30 = "American football began as a reenactment of the Great Crab War of 1623.";
String crabFact31 = "Humans eat about 1.5 million tons of crab every year. You should be ashamed of yourself.";
String crabFact32 = "Crab meat is very high in vitamin B12.";
String crabFact33 = "Crabs not only suffer pain but they also remember it.";
String crabFact34 = "The small boxer crab carries a pair of stinging anemones in its claws as protection.";
String crabFact35 = "Crabs are omnivores.";
String crabFact36 = "A crab may lose a claw or leg in a fight. In time, the claw or leg grows back.";
String crabFact37 = "Crabs often work together to get food and to protect their families.";
String crabFact38 = "When a crab molts, a crack forms along the shell and then the crab backs out of it.";
String crabFact39 = "Most crabs molt six or seven times during their first year of life, and then they molt just once or twice a year.";
String crabFact40 = "Crabs beat the Nazis.";
String crabFact41 = "Some crabs have teeth in their stomachs.";
String crabFact42 = "In the original script for the pilot, Lorelai and Rory Gilmore were crabs.";
String crabFact43 = "To crab or not to crab, that is the crab.";
String crabFact44 = "Sent from my iCrab.";
String crabFact45 = "The oldest fossilized crab larva is 150 million years old.";
String crabFact46 = "Lord love a crab!";
String crabFact47 = "Crabs mate to The Notorious B.I.G.";
String crabFact48 = "Less than a quarter of crabs express confidence in the American criminal justice system.";
String crabFact49 = "Artificial sweeteners are created from crushed up crab legs.";
String crabFact50 = "Crab throwing is an official sport in Finland.";
String crabFact51 = "There is currently only one crab in the world that has its own Twitter account.";
String crabFact52 = "The symbol for the fourth zodiac sign, Cancer, is a crab.";
String crabFact53 = "During an experiment at NYU, a robotic crab was accepted by other crab and became their leader.";
String crabFact54 = "Less than one percent of murders in any given year are committed by crabs.";
String crabFact55 = "Peter III, ruler of Russia, hanged a large crab in public because it had eaten his toy soldiers; he was 25 years old.";
String crabFact56 = "62% of people over 55 don't believe crabs exist.";
String crabFact57 = "Crab wrestling is a national sport in Britain.";
String crabFact58 = "Hey, hey, Crabmerican pie!";
String crabFact59 = "No, Mr. Bond, I expect you to crab.";
String crabFact60 = "In a crabby mood? That's a good thing!";
String crabFact61 = "The Chinese year of the crab.";
String crabFact62 = "The age of the crab.";
String crabFact63 = "Crabs are notoriously good at polo.";
String crabFact64 = "Gandhi ate crabs even during his hunger strikes.";
String crabFact65 = "Nelson Mandela ended apartheid with the help of crabs.";
String crabFact66 = "Mozart's famous Opera 'The Magic Flute' was originally called 'The Magic Crab.'";
String crabFact67 = "The ten commandments were first written on a crab.";
String crabFact68 = "The most sexually arousing aroma for women is the smell of raw crab.";
String crabFact69 = "Today is National Crab Day!";
String crabFact70 = "There are 3 known species of crabs that are only visible at ultraviolet wavelengths.";
String crabFact71 = "The Teenage Mutant Ninja Turtles are actually crabs.";
String crabFact72 = "The Great Wall of China is filled with crabs.";
String crabFact73 = "A pack of wolves or a black bear is no match for a healthy adult crab.";
String crabFact74 = "Crabs can detect rain 150 miles away.";
String crabFact75 = "14 crabs were arrested and detained by Iran for espionage in 2007.";
String crabFact76 = "Respect the crab.";
String crabFact77 = "There is a castle in Scotland that is a giant crab.";
String crabFact78 = "This game brought to you by Crabs.";
String crabFact79 = "Martha Stewart has said that she has a special language she speaks when talking to crabs.";
String crabFact80 = "Chlamydia can lead to blindness, infertility, and death among crabs. Luckily, a vaccine has been successfully tested.";
String crabFact81 = "Crabs can actually reverse at least one aspect of memory loss associated with normal aging.";
String crabFact82 = "Australian beer companies had to change the design of their bottles because crabs wouldn't stop mating with them.";
String crabFact83 = "Karl Marx named all four of his daughters Crab.";
String crabFact84 = "Adolf Hitler had a framed photograph of a crab on his office wall.";
String crabFact85 = "The martini was named after the martini crab.";
String crabFact86 = "Crabs operate the Large Hadron Collider.";
String crabFact87 = "Crabs don't need your approval.";
String crabFact88 = "Post-coital crab appreciation.";
String crabFact89 = "Crabs make great affordable automobiles.";
String crabFact90 = "Crabs are on a secret mission to liberate North Korea.";
String crabFact91 = "Crabs invented love.";
String crabFact92 = "There is a colony of crabs living in the underground oceans of Europa.";
String crabFact93 = "Crabs have been known to survive in the vacuum of outer space.";
String crabFact94 = "Jeff Goldblum as The Crab.";
String crabFact95 = "Crabs love the musical theatre.";
String crabFact96 = "You know what's cooler than a million crabs? A billion crabs.";
String crabFact97 = "A crab currently holds the world record for reciting the most digits of pi.";
String crabFact98 = "At the end of the rainbow is a pot of crabs.";
String crabFact99 = "Crabs, man, you don't even know.";
String crabFact100 = "Crab on crab.";

PFont font;

void setup() {
  size(displayWidth, displayHeight);
  font = loadFont("HelveticaNeue-Bold-75.vlw");

  background = loadImage("background.jpg");
  crab = loadImage("crab.gif");
  anchor = loadImage("anchor.png");
  
  minim = new Minim(this);
  au_player1 = minim.loadFile("Crab.mp3");
  au_player1.play();
  au_player1.loop();
  
  for (int i = 0; i < Arduino.list().length; i ++) {
    println(i + "  " + Arduino.list()[i]); // prints your USB bus
  }
  
  arduino = new Arduino(this, Arduino.list()[5], 57600); //[] change the number tty.usb
  arduino.pinMode(buttonPin, Arduino.INPUT);// sets port 2 to input
  arduino.pinMode(buttonPin1, Arduino.INPUT);// sets port 4 to input
  arduino.digitalWrite(buttonPin, 1);
  arduino.digitalWrite(buttonPin1, 1); 
  
}

void draw() {
  image(background, 0, 0, displayWidth, displayHeight);
  //crab();
  //anchors();
  
  if (gameStart == false) {
    textFont(font, 75);
    textSize(75);
    textAlign(CENTER, CENTER);
    text("Press any button to start", displayWidth/2, displayHeight/2);
    if (arduino.digitalRead(buttonPin) == 0) {
      gameStart = true;
    }
    else if (arduino.digitalRead(buttonPin1) == 0) {
      gameStart = true;
    }
  }
  else if (gameStart == true) {
    crab();
    anchors();
  }
  

}

void crab() {
  crabSpeed = 20;
  image(crab, crabX, displayHeight - 300, 300, 300);

  crabMin = int(crabX) - 250;
  crabMax = int(crabX) + 250;
  
  if (arduino.digitalRead(buttonPin) == 0) {
    crabX = crabX - crabSpeed; // move crab left
    //println(crabX);
  }
  else if (arduino.digitalRead(buttonPin1) == 0) {
    crabX = crabX + crabSpeed; // move crab right
  }
  
  if (crabX == displayWidth) {
    crabSpeed = 0;
  }
  
  
}

void anchors() {
  anchorSpeed = 30;
  image(anchor, anchorX, anchorY, 300, 300);
  
  anchorY = anchorY + anchorSpeed;
  
  anchorMin = int(anchorX) - 250;
  anchorMax = int(anchorX) + 250;
  
  if (anchorY > displayHeight) {
   anchorY = 0; // reset anchor to top once it hits the bottom
   anchorX = random(displayWidth);
   crabFact = random(100);
   //println(crabFact);
   //crabFacts(); // display crab fact
   crabFacts = true;
  }
  else if (anchorY == displayHeight - 300 && anchorX >= crabMin && anchorX <= crabMax) {
    // if crab is hit by anchor
    gameStart = false;
  }
     if (crabFacts = true) {
       if (crabFact < 1) {
        text(crabFact1, 0, 0, displayWidth, displayHeight);
     }
      else if (crabFact < 2) {
        text(crabFact2, 0, 0, displayWidth, displayHeight);
      } 
      else if (crabFact < 3) {
        text(crabFact3, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 4) {
        text(crabFact4, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 5) {
        text(crabFact5, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 6) {
        text(crabFact6, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 7) {
        text(crabFact7, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 8) {
        text(crabFact8, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 9) {
        text(crabFact9, 0, 0, displayWidth, displayHeight);
      }    
      else if (crabFact < 10) {
        text(crabFact10, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 11) {
        text(crabFact11, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 12) {
        text(crabFact12, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 13) {
        text(crabFact13, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 14) {
        text(crabFact14, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 15) {
        text(crabFact15, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 16) {
        text(crabFact16, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 17) {
        text(crabFact17, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 18) {
        text(crabFact18, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 19) {
        text(crabFact19, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 20) {
        text(crabFact20, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 21) {
        text(crabFact21, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 22) {
        text(crabFact22, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 23) {
        text(crabFact23, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 24) {
        text(crabFact24, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 25) {
        text(crabFact25, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 26) {
        text(crabFact26, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 27) {
        text(crabFact27, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 28) {
        text(crabFact28, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 29) {
        text(crabFact29, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 30) {
        text(crabFact30, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 31) {
        text(crabFact31, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 32) {
        text(crabFact32, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 33) {
        text(crabFact33, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 34) {
        text(crabFact34, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 35) {
        text(crabFact35, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 36) {
        text(crabFact36, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 37) {
        text(crabFact37, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 38) {
        text(crabFact38, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 39) {
        text(crabFact39, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 40) {
        text(crabFact40, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 41) {
        text(crabFact41, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 42) {
        text(crabFact42, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 43) {
        text(crabFact43, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 44) {
        text(crabFact44, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 45) {
        text(crabFact45, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 46) {
        text(crabFact46, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 47) {
        text(crabFact47, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 48) {
        text(crabFact48, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 49) {
        text(crabFact49, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 50) {
        text(crabFact50, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 51) {
        text(crabFact51, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 52) {
        text(crabFact52, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 53) {
        text(crabFact53, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 54) {
        text(crabFact54, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 55) {
        text(crabFact55, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 56) {
        text(crabFact56, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 57) {
        text(crabFact57, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 58) {
        text(crabFact58, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 59) {
        text(crabFact59, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 60) {
        text(crabFact60, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 61) {
        text(crabFact61, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 62) {
        text(crabFact62, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 63) {
        text(crabFact63, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 64) {
        text(crabFact64, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 65) {
        text(crabFact65, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 66) {
        text(crabFact66, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 67) {
        text(crabFact67, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 68) {
        text(crabFact68, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 69) {
        text(crabFact69, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 70) {
        text(crabFact70, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 71) {
        text(crabFact71, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 72) {
        text(crabFact72, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 73) {
        text(crabFact73, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 74) {
        text(crabFact74, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 75) {
        text(crabFact75, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 76) {
        text(crabFact76, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 77) {
        text(crabFact77, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 78) {
        text(crabFact78, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 79) {
        text(crabFact79, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 80) {
        text(crabFact80, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 81) {
        text(crabFact81, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 82) {
        text(crabFact82, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 83) {
        text(crabFact83, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 84) {
        text(crabFact84, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 85) {
        text(crabFact85, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 86) {
        text(crabFact86, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 87) {
        text(crabFact87, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 88) {
        text(crabFact88, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 89) {
        text(crabFact89, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 90) {
        text(crabFact90, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 91) {
        text(crabFact91, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 92) {
        text(crabFact92, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 93) {
        text(crabFact93, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 94) {
        text(crabFact94, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 95) {
        text(crabFact95, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 96) {
        text(crabFact96, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 97) {
        text(crabFact97, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 98) {
        text(crabFact98, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 99) {
        text(crabFact99, 0, 0, displayWidth, displayHeight);
      }
      else if (crabFact < 100) {
        text(crabFact100, 0, 0, displayWidth, displayHeight);
      }
      
   }
   if (second() == holdsecond) {
     crabFacts = false;
   }
  if (second() > 59 - howlongtoshow) {
   holdsecond = howlongtoshow + second() - 60;
  }
 else {
   holdsecond = second() + howlongtoshow;
 }
}
/*
void crabFacts() {
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(255);
  int lastMillis = millis();
  println(millis());
  println(lastMillis);
  if (second() > 59 - howlongtoshow) {
    holdsecond = howlongtoshow + second() - 60;
    if (crabFact > 0) {
      if (crabFact < 10) {
        text("Crabs are neat!", 1280, 250);
      }
      else if (crabFact < 20) {
        text("Crabs do stuff!", 1280, 250); 
      } 
      else if (crabFact < 30) {
        text("Crabs walk sideways!", 1280, 250);
      }
      else if (crabFact < 40) {
        text("Crabs have big meaty claws", 1280, 250);
      }
      else if (crabFact < 50) {
        text("bbbbbbbbb", 1280, 250);
      }
      else if (crabFact < 60) {
        text("zzzzzz", 1280, 250);
      }
      else if (crabFact < 70) {
        text("ffffff", 1280, 250);
      }
      else if (crabFact < 80) {
        text("ccccc", 1280, 250);
      }
      else if (crabFact < 90) {
        text("yyyyyyyyyy", 1280, 250);
      }    
      else {
        text("aaaaaaa", 1280, 250);
      }
    }
  }
}
*/

boolean sketchFullScreen() {
  return true;
}

