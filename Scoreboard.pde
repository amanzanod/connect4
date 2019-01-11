/**
 * Clase del marcador.
 *
 */
public class Scoreboard {
   
  // El juego.
  private Game game;
  
  // Color.
  color scoreboard_color = color (0, 0, 0);
  color menu_color = color (0, 255, 0);
  // Fuente del marcador.
  PFont font_title;
  // Fuente del marcador descripción.
  PFont font_desc;
  // Formas del marcador.
  PShape scoreboard;
  PShape scoreboard_mark_left;
  PShape scoreboard_mark_bottom;   
        
  // Imagen sombra del pie
  PImage score_img;
  
  // Variable para ver si el juego está preparado.
  private int state = GAME_INTRO;
  
  Scoreboard(Game game) {
    this.game = game;
  }
  
  // Get state.
  int getState(){
    return this.state;
  }
  
  // Set state.
  void setState(int state) {
    this.state = state;
  }
  
  // Configuración.
  void setup() {
    create_scoreboard();
    // Añadimos imagen marcador
    score_img = loadImage ("marcador.png");
  }  
  
  // Dibujar.
  void draw(int time) { 
    font_title = loadFont("AdvancedDotDigital.vlw");  
    font_desc = loadFont("SegoeUI-Light-48.vlw");  
    textFont(font_title);
    // Dibujar imagen marcador.
    image(score_img, 0, 0);
         
   // Animar el marcador.
   if (time_now > (time + 500)) {
     draw_title();
   }   
   
   if (time_now > (time + 2000)) {
     // El juego está preparado para empezar.
     if (this.getState() == GAME_INTRO) {
       this.setState(GAME_PREPARED);
     }     
   }
   
   if (this.getState() < GAME_STARTED) {
     
     if (time_now > (time + 1000)) {
       draw_menu1();
     }
           
     if (time_now > (time + 1500)) {
       draw_menu2();
     }
     
   } else if (this.getState() == GAME_STARTED) {     
     draw_current(game.getPlayerCurrent());     
   } else if (this.getState() == GAME_FINISHED) {     
     draw_finish(game.getPlayerWinner());
     banda_inicio.play();
   }   
  }
  
  // Evento de teclado.
  void keyPressed() {
    // Si el juego está preparado o terminado.
    if ((this.getState() == GAME_PREPARED) || (this.getState() == GAME_FINISHED)) {
      if (key == '1') {
        this.game.reset();
        this.game.play();
      } else if (key == '2') {
        exit();
      }
    } else if (this.getState() == GAME_STARTED) {
      
      if (key == CODED) {
        if (keyCode == LEFT) {
          game.getPlayerCurrent().moveLeft();
        } else if (keyCode == RIGHT) {
          game.getPlayerCurrent().moveRight();
        } else if (keyCode == DOWN) {
          boolean result = game.getPlayerCurrent().select();
          if (result) {
            game.getPlayerCurrent().setState(2);
            boolean iswinner = game.isWinner();
            if (!iswinner) {
              game.getPlayerCurrent().waiting();
              game.nextPlayer(); 
            }          
          } 
        }
      }
    }
  }
  
  // Dibujar titulo.
  void draw_title() {   
    fill (255, 255, 255);
    textSize(45);
    text ("4 EN RAYA", 850, 80);
  }
  
  // Dibujar menú.
  void draw_menu1() {   
    fill (menu_color); 
    textSize(40);
    text ("MENÚ:", 850, 190); 
  }  
  
  // Dibujar menú.
  void draw_menu2() {   
    fill (menu_color); 
    textSize(40);
    text ("1. JUGAR", 850, 270);    
    text ("2. SALIR", 850, 340);
  }
  
  // Dibujar el turno del jugador.
  void draw_current(Player player) {   
    fill (menu_color); 
    textSize(40);
    text ("TURNO:", 850, 160); 
    textSize(34);
    text (player.getName(), 900, 240);     
    textFont(font_desc);
    fill (100, 100, 100);
    textSize(24);
    text ("Utilice los cursores para mover la ficha", 840, 300); 
    text ("IZQUIERDA y DERECHA", 840, 328);
    text ("Seleccionar columna: ABAJO", 840, 356); 
  }
  
  // Dibujar el resultado final.
  void draw_finish(Player player) {
    fill (menu_color); 
    textSize(40);
    text ("FINAL", 840, 170);
    textSize(22);
    if (player == null) {
      text ("No hay ganador", 840, 220);
    } else {
      text ("El ganador es " + player.getName(), 840, 220);
    }
    
    textSize(28);
    text ("1. JUGAR", 840, 290);    
    text ("2. SALIR", 840, 350);
  }
  
  // Crear marcador.
  void create_scoreboard() {
    scoreboard = createShape();
    scoreboard .beginShape();
    scoreboard .fill(scoreboard_color);
    scoreboard .noStroke();
    scoreboard .vertex(800, 0);
    scoreboard .vertex(1250, 0);
    scoreboard .vertex(1250, 375);
    scoreboard .vertex(800, 375);
    scoreboard .endShape(CLOSE);
    
    scoreboard_mark_left = createShape();
    scoreboard_mark_left .beginShape();
    scoreboard_mark_left .fill(35,35,35);
    scoreboard_mark_left .noStroke();
    scoreboard_mark_left .vertex(790, 0);
    scoreboard_mark_left .vertex(800, 0);
    scoreboard_mark_left .vertex(800, 375);
    scoreboard_mark_left .vertex(790, 380);
    scoreboard_mark_left .endShape(CLOSE);  
      
    scoreboard_mark_bottom = createShape();
    scoreboard_mark_bottom .beginShape();
    scoreboard_mark_bottom .fill(70,70,70);
    scoreboard_mark_bottom .noStroke();
    scoreboard_mark_bottom .vertex(800, 375);
    scoreboard_mark_bottom .vertex(1250, 375);
    scoreboard_mark_bottom .vertex(1245, 380);
    scoreboard_mark_bottom .vertex(790, 380);
    scoreboard_mark_bottom .endShape(CLOSE);
  }
}
