// Importamos la libreria MINIM
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Creamos las variables de Minim
Minim minim;
AudioPlayer banda_inicio;
AudioPlayer audio_juego;
AudioPlayer audio_mover;
AudioPlayer audio_caer;
AudioPlayer audio_player1;
AudioPlayer audio_player2;
AudioPlayer audio_nowinner;
/*
 * Constantes globales.
 *
 */
 static final int GAME_INTRO    = 0;
 static final int GAME_PREPARED = 1;
 static final int GAME_STARTED  = 2;
 static final int GAME_FINISHED = 3;

/*
 * Variables globales.
 *
 */ 
color background_grey; 
// Variables de tiempo.
int time_now;
 
// Instanciar los objetos.
Board board = new Board();
Player player1 = new Player(1, board);
Player player2 = new Player(2, board); 
Game game = new Game(player1, player2, board);
Scoreboard scoreboard = new Scoreboard(game); 
Background backgroundGame = new Background();


  // Imagen ficha roja y amarila tumbadas.
  PImage redh_box;
  PImage yellowh_box;

/*
 * Setup.
 *
 */
void setup() {
   size(1280, 800);
   frameRate (24);   
   
   minim = new Minim(this);
   banda_inicio = minim.loadFile("banda_sonora.mp3");
   audio_juego = minim.loadFile("audio_juego.mp3");
   audio_mover = minim.loadFile("mover.mp3");
   audio_caer = minim.loadFile("caer.mp3");
   audio_player1 = minim.loadFile("jugador1.mp3");
   audio_player2 = minim.loadFile("jugador2.mp3");
   audio_nowinner = minim.loadFile("nowinner.mp3");
   
   background_grey = color (58, 58, 58);     
   backgroundGame.setup();  
   board.setup();
   scoreboard.setup();
   player1.setup();
   player2.setup();
   
   banda_inicio.loop();     
   audio_juego.loop();
   audio_juego.pause();
   
    // Añadimos imagen roja y amarilla
    redh_box = loadImage ("redh.png");
    yellowh_box = loadImage ("yellowh.png");
}

/*
 * Draw.
 *
 */
void draw() {
   background(background_grey);   
   
   // Devuelve la cantidad de milisegundos (milésimas de segundo) desde que se inició el programa.
   // Esta información se usa a menudo para sincronizar eventos y secuencias de animación.
   time_now = millis(); 
   
   // Pintar los objetos por tiempo.   
   backgroundGame.draw();
   
   // Animar los elementos.
   if (time_now > 2000) {
     board.draw();   
   }
   if (time_now > 3000) {
     board.setState(1);
   }
   
   if (time_now < 5000) {
     animate_boxes(3500);
   }
   
   if (time_now > 4500) {
     player2.draw(4500);     
   }
   
   if (time_now > 5500) {
     player1.draw(5500);
   }  
      
   if (time_now > 7000) {
     scoreboard.draw(7000);
   }
   
   // Cuando el juego está empezado.
   if (game.getState() == GAME_STARTED) {   
     // Comprobamos que jugador es el actual.
     Player current = game.getPlayerCurrent();    
     banda_inicio.pause(); 
     // Si no hay jugador actual se sortea.
     if (current != null) {
       // Si hay jugador actual, el jugador actual se prepara.
       current.prepared();
       // El marcador se pone en estado juego empezado.
       scoreboard.setState(2);
     } else {
       // Se sortea el jugador.
       game.drawPlayer();
     }
   } else if (game.getState() == GAME_FINISHED) {
     // Si el juego ha terminado se cambia el marcador.
     scoreboard.setState(3);   
   }
}
  
// Eventos del teclado.
void keyPressed() {
  scoreboard.keyPressed();
}

 // Animación de fichas.
void animate_boxes(int time) { 

  if (time_now > time) {
       player1.select(board.getColumns()[0]); 
       player2.select(board.getColumns()[1]); 
       player1.select(board.getColumns()[2]); 
       player2.select(board.getColumns()[7]); 
       player1.select(board.getColumns()[1]); 
       player2.select(board.getColumns()[0]);  
       player2.select(board.getColumns()[3]); 
       player1.select(board.getColumns()[5]); 
       player2.select(board.getColumns()[2]); 
       player1.select(board.getColumns()[7]); 
       player2.select(board.getColumns()[6]); 
       player1.select(board.getColumns()[4]);  
     }
     
     if (time_now > (time + 100)) {
       player1.select(board.getColumns()[6]); 
       player2.select(board.getColumns()[1]); 
       player1.select(board.getColumns()[2]); 
       player2.select(board.getColumns()[7]); 
       player1.select(board.getColumns()[1]); 
       player2.select(board.getColumns()[6]); 
       player1.select(board.getColumns()[3]); 
       player2.select(board.getColumns()[0]); 
       player1.select(board.getColumns()[2]); 
       player2.select(board.getColumns()[5]); 
       player1.select(board.getColumns()[4]); 
       player2.select(board.getColumns()[4]);
       player1.select(board.getColumns()[0]); 
       player2.select(board.getColumns()[1]); 
       player1.select(board.getColumns()[1]); 
       player2.select(board.getColumns()[6]); 
       player1.select(board.getColumns()[3]); 
       player2.select(board.getColumns()[2]); 
       player1.select(board.getColumns()[7]); 
       player2.select(board.getColumns()[1]); 
       player1.select(board.getColumns()[4]);  
     }    

     if (time_now > (time + 200)) {
       player1.select(board.getColumns()[3]); 
       player2.select(board.getColumns()[1]); 
       player1.select(board.getColumns()[2]); 
       player2.select(board.getColumns()[7]); 
       player1.select(board.getColumns()[1]); 
       player2.select(board.getColumns()[6]); 
       player1.select(board.getColumns()[7]); 
       player2.select(board.getColumns()[5]); 
       player1.select(board.getColumns()[2]); 
       player2.select(board.getColumns()[5]); 
       player1.select(board.getColumns()[0]); 
       player2.select(board.getColumns()[1]); 
       player1.select(board.getColumns()[7]); 
       player2.select(board.getColumns()[7]); 
       player1.select(board.getColumns()[1]); 
       player2.select(board.getColumns()[6]); 
       player1.select(board.getColumns()[3]); 
       player2.select(board.getColumns()[2]); 
       player1.select(board.getColumns()[7]); 
       player2.select(board.getColumns()[1]); 
       player1.select(board.getColumns()[4]);  
     }
     
     // Se cambia el estado del botón de reinicio.    
     if (time_now > (time + 950)) {
       board.setStateReset(1);       
     }
     
     // Se resetea el tablero.
     if (time_now > (time + 1000)) {
       board.reset(); 
     }     
          
     // Se pintan fichas caidas en la bandeja.     
     if ((time_now > (time + 1000)) && (time_now < (time + 1300))) {
       boxes_down();
     }

     // Se cambia el botón de reinicio.
     if (time_now > (time + 1300)) {
       board.reset();
     }
    
}

// Fichas caidas en la bandeja.
void boxes_down() {
    
    // Dibujar sombra de la caja.
    image(redh_box, 170, 651);
    image(redh_box, 287, 647);
    image(redh_box, 430, 650);
    image(redh_box, 526, 651);
    image(redh_box, 626, 651);
    image(redh_box, 326, 651);
    image(redh_box, 406, 646);
    image(redh_box, 466, 651);
    image(redh_box, 516, 654);
    image(redh_box, 606, 651);
    image(redh_box, 576, 651);
    
    image(yellowh_box, 180, 645);
    image(yellowh_box, 277, 645);
    image(yellowh_box, 440, 650);
    image(yellowh_box, 516, 651);
    image(yellowh_box, 616, 651);
    image(yellowh_box, 316, 651);  
    image(yellowh_box, 516, 651); 
    image(yellowh_box, 416, 651);  
    image(yellowh_box, 486, 651); 
    image(yellowh_box, 356, 651);  
    image(yellowh_box, 436, 651); 
    image(yellowh_box, 346, 651);  
    image(yellowh_box, 506, 651);  

}
