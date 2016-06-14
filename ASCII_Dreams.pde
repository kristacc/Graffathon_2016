import moonlander.library.*;
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
 
PVector location;
PVector velocity;


Minim minim;
AudioPlayer song;
Moonlander moonlander;

int SONG_SKIP_MILLISECONDS = 0;
//int SONG_SKIP_MILLISECONDS = 2000;




// plasmaaa:
char plazm[][];
char plazm_mapping[] = {'.', '*', '#', 'O'};
int num = 70;
int num2 = 50;

void compute_plazm( float t ){
  for( int i = 0 ; i < num ; i += 1 ){
    for( int j = 0 ; j < num2 ; j += 1 ){
      float v = 0;
      v = sin(i/3.0+j/3.0)*cos(1*j) + 2*sin(1-i/5.0 - t )*cos(j/4.0+t - 0.2) + sin(j/8.0-t/3.0);
      v /= 4.5;
      v = (1+v)/2.0;
      plazm[i][j] = plazm_mapping[(int)(v*4)];
    }
  }
 }



// **********************************************
//
// Classes:
//
// **********************************************

class AsciiParticle {
  PVector position;
  char mark;

  AsciiParticle( char letter, int x, int y ){
    mark = letter;
    position = new PVector( x, y );
  }

  void draw(int colour){
   fill(colour);
   text( mark, position.x, position.y );
  }

}


class AsciiFrame {

  String[] lines;
 

  AsciiFrame( String filename ){
    lines = loadStrings( filename );
    }

 void draw(int colour){
   fill(colour);
   PFont font;
   font = createFont( "Courier New", 12);
   textFont ( font, 12 );
   

    for (int i = 0; i < lines.length; i++) {
      text(lines[i], 0, i*6,2000,2000);
      }

    }
    
    AsciiParticle[] extractLetters(){
    AsciiParticle[] hiukkaset;
    int montako_kirjainta = 0;
    for( int y = 0 ; y < lines.length ; y += 1 ){
      for( int x = 0 ; x < lines[y].length() ; x += 1 ){
        if( lines[y].charAt(x) != ' ' && lines[y].charAt(x) != '\n' ){
           montako_kirjainta += 1;
          }
      }

    }

    hiukkaset = new AsciiParticle[montako_kirjainta];
    int counter = 0;
    for( int y = 0 ; y < lines.length ; y += 1 ){
      for( int x = 0 ; x < lines[y].length() ; x += 1 ){
        if( lines[y].charAt(x) != ' ' && lines[y].charAt(x) != '\n' ){
          hiukkaset[counter] = new AsciiParticle( lines[y].charAt(x), (int)(x*7.25), (int)(y*6.25) );
          counter += 1;
        }
      }
    }

    return hiukkaset;
    }

}


 AsciiFrame framet[];
 AsciiParticle particles[];
 AsciiParticle plasmaparticles[];
 PVector tiivistin[];
 
 
void setup() {
  size(1920,1080);
  //size(990,540);
  smooth();
  background(255);
  location = new PVector(100,100);
  velocity = new PVector(2.5,5); 
 
 

  
  
  // plasmaaaa
  plazm = new char[num][num2];
  for( int i = 0 ; i < num ; i += 1 ){
    for( int j = 0 ; j < num2 ; j += 1 ){
      plazm[i][j] = ' ';
      }  
    }
    
    
    
   // frames for bunny
    framet = new AsciiFrame[32];
    framet[0] = new AsciiFrame( "1.txt" );
    framet[1] = new AsciiFrame( "2.txt" );
    framet[2] = new AsciiFrame( "3.txt" );
    framet[3] = new AsciiFrame( "4.txt" );
    framet[4] = new AsciiFrame( "5.txt" );
    framet[5] = new AsciiFrame( "6.txt" );
    framet[6] = new AsciiFrame( "7.txt" );
    framet[7] = new AsciiFrame( "8.txt" );
    framet[8] = new AsciiFrame( "9.txt" );
    framet[9] = new AsciiFrame( "10.txt" );
    
    framet[10] = new AsciiFrame( "11.txt" );
    framet[11] = new AsciiFrame( "12.txt" );
    framet[12] = new AsciiFrame( "13.txt" );
    framet[13] = new AsciiFrame( "14.txt" );
    framet[14] = new AsciiFrame( "15.txt" );
    framet[15] = new AsciiFrame( "16.txt" );
    framet[16] = new AsciiFrame( "17.txt" );
    framet[17] = new AsciiFrame( "18.txt" );
    framet[18] = new AsciiFrame( "19.txt" );
    framet[19] = new AsciiFrame( "20.txt" );
    
    framet[20] = new AsciiFrame( "21.txt" );
    framet[21] = new AsciiFrame( "22.txt" );
    
    particles = framet[18].extractLetters();
    plasmaparticles = null;//new AsciiParticle[num*num];
    
    tiivistin = new PVector[9];
    tiivistin[0] = new PVector(100,500);
    tiivistin[1] = new PVector(200,200);
    tiivistin[2] = new PVector(600,300);
    tiivistin[3] = new PVector(800,400);
    tiivistin[4] = new PVector(700,50);
    tiivistin[5] = new PVector(900,20);
    tiivistin[6] = new PVector(900,450);
    tiivistin[7] = new PVector(500,450);
    tiivistin[8] = new PVector(200,450);
    
    minim = new Minim( this ); song = minim.loadFile(  "testi_18.mp3", 1024 );
    song.play();
  
} 

void plazm_to_particles(){
  if( plasmaparticles == null ){
    int counter = 0; 
    plasmaparticles = new AsciiParticle[num*num2];
    for( int i = 0 ; i < num ; i += 1 ){
      for( int j = 0 ; j < num2 ; j += 1 ){
        plasmaparticles[counter] = new AsciiParticle( plazm[i][j], i*16+7, j*16+7  ); 
        counter += 1;  
      }
    } 
  }
}
 

 
 
void draw() {
  pushMatrix();
  scale(1.939,2);
  int time = millis();
  
  
  
 // side bar, team name:
 if (time > 0 && time < 10000){
 //if (time > 0 ){
   
        noStroke();
    fill(255,10); // piirtaa paalle valkoista 10% peittävyydella == feikki himmeneminen
    rect(0,0,width,height);
    
    //textAlign(CENTER);
   
    String s = "Team KC";
    fill(0);
    textSize(32);
    //text("Something or other", 50,50);
    text(s, 100, 500*sin(time),1000,1000);
    //text(s, 20, 1*time,1000,1000);
    //text(s, 20, 30,1000,1000);
     
    }
  
 
 
  if (time > 2000 && time < 3000){
   
    noStroke();
    fill(255,10); // piirtaa paalle valkoista 10% peittävyydella == feikki himmeneminen
    rect(0,0,width,height);
 
    fill(0);
    textSize( int(4*time*0.01) );
    text("Presents",450,300+time*0.001);
   
    }
  
//clear screen
 if (time > 3000 && time < 3020){
   
    noStroke();
    fill(255);
    rect(150,0,width,height);
   
    }
 
 
 // name of the demo:
  if (time > 3020 && time < 10000){
   
    noStroke();
    fill(255,10); // piirtaa paalle valkoista 10% peittävyydella == feikki himmeneminen
    rect(0,0,width,height);
    
    fill(0);
    textSize(0);
    textLeading(10);
     
    textSize( int(2*time*0.01) );
    text("ASCII Dreams",300, 300/(0.001*(time-3020)));
      
  }
 
  if (time > 9500 && time < 10000){
   fill( 100/sin(time) );
   
   noStroke();
    fill(100/sin(time), 80); 
    rect(0,0,width,height);
    fill(100*sin(time), 80);
  }
 
 // plasmaaaaaa
 if (time > 10000 && time < 15000){
   noStroke();
    fill(255); 
    rect(0,0,width,height);
    fill(0);
    
    textSize(15);
    
    compute_plazm(millis()/1000.0);
    for( int i = 0 ; i < num ; i += 1 ){
      for( int j = 0 ; j < num2 ; j += 1 ){
        text( plazm[i][j], i*16+7, j*16+7 );
      }
    }
 }
 
 // to here so black-white-black  change
 if (time > 15000 && time < 17000){
   fill( 100/sin(time) );
   
   noStroke();
    fill(100/sin(time)); 
    rect(0,0,width,height);
    fill(100*sin(time));
    
    textSize(15);
    
    compute_plazm(millis()/1000.0);
    for( int i = 0 ; i < num ; i += 1 ){
      for( int j = 0 ; j < num2 ; j += 1 ){
        text( plazm[i][j], i*16+7, j*16+7 );
      }
    }
   
 }
 
  // plasmaaaaaa
 if (time > 17000 && time < 30000){
   noStroke();
    fill(0); 
    rect(0,0,width,height);
    fill(255);
    
    textSize(15);
    
    compute_plazm(millis()/1000.0);
    for( int i = 0 ; i < num ; i += 1 ){
      for( int j = 0 ; j < num2 ; j += 1 ){
        text( plazm[i][j], i*16+7, j*16+7 );
      }
    }
 }
 
 
 
 // vibrations with plasma
 if (time > 30000 && time < 32000){
     fill( 100/sin(time) );
   
   noStroke();
    fill(100/sin(time)); 
    rect(0,0,width,height);
    fill(100*sin(time));
    
    textSize(15);
    
    compute_plazm(millis()/1000.0);
    for( int i = 0 ; i < num ; i += 1 ){
      for( int j = 0 ; j < num2 ; j += 1 ){
        text( plazm[i][j], i*16+7, j*16+7 );
      }
    }

   
 }
 
 
 // "cleaning"
 
 if (time > 32000 && time < 45000){
  plazm_to_particles();
   
   fill(255,40);
   rect(0,0,width,height);
   for( int i = 0; i < plasmaparticles.length; i++){
      plasmaparticles[i].draw(0);
       
      for( int j = 0 ; j< tiivistin.length ; j++ ){
        PVector q = PVector.sub( tiivistin[j], plasmaparticles[i].position );
        if( q.magSq() < 50*50 ){
          q.normalize();
          plasmaparticles[i].position.add( q );
        }
      }
      plasmaparticles[i].position.x += random(-0.2,0.2);
      plasmaparticles[i].position.y += random(-0.2,0.2);
   }
 
 
   PVector tc = new PVector(0,0);
   for( int j = 0 ; j< tiivistin.length ; j++ ){
     tiivistin[j].x += random(-7,7);
     tiivistin[j].y += random(-5,5);
     tc.add(tiivistin[j]);
   }
   tc.mult( 1.0/tiivistin.length );
   
   for( int j = 0 ; j< tiivistin.length ; j++ ){
     PVector q = PVector.sub( tc, tiivistin[j] );
     q.normalize();
     //q.mult(0.25);
     q.mult(0.7);
     tiivistin[j].add(q);
   }
   
 }
  
 
 
 // crashing down.....
 
  
 if (time > 45000 && time < 48000){
   PVector middle = new PVector( 990/2, 540/2 );
   fill(255,40);
   rect(0,0,width,height);
   
   for( int i = 0; i < plasmaparticles.length; i++){
      plasmaparticles[i].draw(0);
      PVector q = PVector.sub( middle, plasmaparticles[i].position );
      q.normalize();
      q.mult(2.5);
      plasmaparticles[i].position.add( q );  
      plasmaparticles[i].position.x += random(-0.2,0.2);
      plasmaparticles[i].position.y += random(-0.2,0.2);
     }
   }

if (time > 48000 && time < 50000){
   PVector middle = new PVector( 990/2, 540/2 );
   fill(255,40);
   rect(0,0,width,height);
   for( int i = 0; i < plasmaparticles.length; i++){
      plasmaparticles[i].draw(0);
      PVector q = PVector.sub( plasmaparticles[i].position, middle );
      q.normalize();
      q.mult(1.8);
      plasmaparticles[i].position.add( q );  
      plasmaparticles[i].position.x += random(-0.2,0.2);
      plasmaparticles[i].position.y += random(-0.2,0.2);
     }
   }

// flashing the bunny
if (time > 50000 && time < 52000){
     fill( 100/sin(time) );
   
   noStroke();
    fill(100/sin(time)); 
    rect(0,0,width,height);
    fill(100*sin(time));
    

  PVector middle = new PVector( 990/2, 540/2 );
   for( int i = 0; i < plasmaparticles.length; i++){
      plasmaparticles[i].draw(0);
      PVector q = PVector.sub( plasmaparticles[i].position, middle );
      q.normalize();
      q.mult(1.8);
      plasmaparticles[i].position.add( q );  
      plasmaparticles[i].position.x += random(-0.2,0.2);
      plasmaparticles[i].position.y += random(-0.2,0.2);
     }
   
 framet[0].draw(255);
 }
 
 

 // bunnyy, musta
  if (time > 52000 && time < 60000){
   framet[((time-52000)/200) % 22].draw(255);
   noStroke();
   fill(0,80); // piirtaa paalle valkoista 80% peittävyydella == feikki himmeneminen
   rect(0,0,width,height);
   
 
  }
  
  
 // to here so black-white-black  change
 if (time > 60000 && time < 62000){
   fill( 100/sin(time) );
   
   noStroke();
    fill(100/sin(time)); 
    rect(0,0,width,height);
    fill(100*sin(time));

   
 }
  
  
  // bunnyy, valkoinen
  if (time > 62000 && time < 70035){
     framet[((time-62000)/200) % 22 ].draw(0);
     noStroke();
     fill(255,80); // piirtaa paalle valkoista 80% peittävyydella == feikki himmeneminen
     rect(0,0,width,height);
  
  
  }
  
    // bunnyy, valkoinen, stop
  if (time > 70035 && time < 71000){
     framet[((70034-62000)/200) % 22].draw(0);
     //noStroke();
     fill(255,80); // piirtaa paalle valkoista 80% peittävyydella == feikki himmeneminen
     //rect(0,0,width,height);
  
  
  }
  
  // bunny wobbly
  if (time > 71000 && time < 80000){
 //if (time > 0 ){
   

   //framet[time/200].draw();
   noStroke();
    fill(255,40); // piirtaa paalle valkoista 10% peittävyydella == feikki himmeneminen
    rect(0,0,width,height);
    
    for( int i = 0; i < particles.length; i++){
      particles[i].draw(0);
      
      particles[i].position.x += random(-1,1);
      particles[i].position.y += random(-1,1);
    }
  
 }
 
 // bunny to the rescue!
 if (time > 80000 && time < 87000){
   
   fill(255,40);
   rect(0,0,width,height);
   for( int i = 0; i < particles.length; i++){
      particles[i].draw(0);
      
      particles[i].position.x *= 1.02;
      particles[i].position.y *= 1.01;
   }
 }
  if( time > 84000 ){
   exit();
 } 
  

  
  
  popMatrix();
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
 }
 
 

 
 

