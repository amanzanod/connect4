/**
 * Clase del jugador.
 *
 */
public class Player {
  
  /*
   * Constantes.
   *
   */
   static final int PLAYER_WAITING = 0;
   static final int PLAYER_PREPARED = 1;   
   static final int PLAYER_SELECTED = 2;
  
  // Colores.
  color panel_front = color (41, 70, 155);
  color panel_lateral = color (25, 46, 106);
  color panel_top = color (32, 45, 96);
  color colorPlayer = color(255, 0, 0);
  color colorPlayerShadow = color(147, 0, 0);
  
  // Formar a crear.
  private PShape box_front;
  private PShape box_top;
  private PShape box_lateral;  
      
  // Imagen sombra del pie
  PImage shadow_box;  
    
  // Imagen ficha roja y amarila.
  PImage red_box;
  PImage yellow_box;
  PImage redv_box;
  PImage yellowv_box;
  
  // Fuente del número de la ficha de la caja.
  PFont font_player;

  // Identificador.
  private int id; 
  
  // Nombre del jugador.
  private String name;  
  
  // Estado del jugador.
  private int state = PLAYER_WAITING;
  
  // Pizarra del juego.
  private Board board;
  
  // Posicion del jugador.
  private int posPlayer;
  
  // Posición de la ficha para elegir.
  private int positionToken = 4;
  
  // Fichas sin utilizar.
  private int tokenUnused = 32;
  
  // Constructor.
  Player(int id, Board board) {
    this.setId(id);
    this.board = board;
    // Dependiendo el tipo de jugador la ficha es de un color y hay unas coordenadas.
    if (id == 1) {
      this.colorPlayer = color(255, 0, 0);
      this.colorPlayerShadow = color(147, 0, 0);
      this.posPlayer = 0;
      this.name = "Jugador " + id;
    } else {
      this.colorPlayer = color(255, 177, 0);
      this.colorPlayerShadow = color(173, 115, 0);
      this.posPlayer = 210;
      this.name = "Jugador " + id;
    }
  }  
  
  // Get name.
  String getName() {  
    return this.name;
  }
  
  // Get id.
  int getId() {  
    return this.id;
  }
  
  // Set id.
  void setId(int id) {  
    this.id = id;
  }
  
  // Get color player
  color getColor() {
    return this.colorPlayer;
  }    
    
  // Get color player shadow
  color getColorShadow() {
    return this.colorPlayerShadow;
  }
  
  // Get state.
  int getState() {
    return this.state;
  }
  
  // Set state.
  void setState(int state) {
    this.state = state;
  }
  
  // Get token unused.
  int getTokenUnused() {
    return this.tokenUnused;
  }
  
  // Jugador preparado para elegir.
  void prepared() {
    this.state = PLAYER_PREPARED;
  };
  
  // Sonido Jugador
  void playSound() {
    if (id == 1) {
      audio_player1.rewind();
      audio_player1.play();
    } else if (id == 2) {
      audio_player2.rewind();
      audio_player2.play();
    } 
  }
    
  // Resetear.
  void reset() {
    this.tokenUnused = 32;
  }
  
  // Jugador esperando.
  void waiting() {
    this.state = PLAYER_WAITING;
    this.positionToken = 4;
  };
  
  // Mover a la derecha.
  void moveRight() {
    if (this.positionToken < 8) {
      // Añadir sonido de mover.
      audio_mover.rewind();
      audio_mover.play();
      this.positionToken ++;
    }    
  }
  
  // Mover a la izquierda.
  void moveLeft() {    
    if (this.positionToken > 1) {
      // Añadir sonido de mover.
      audio_mover.rewind();
      audio_mover.play();
      this.positionToken --;
    } 
  }
  
  // Seleccionar columna.
  boolean select() {
    boolean result;
 
    Column[] columns = board.getColumns();
    Column column = columns[this.positionToken - 1];
    
    if (this.tokenUnused > 0) { 
      result = column.select(this);
      
      if (result) {
        // Se resta una ficha al jugador.
        // Añadir sonido de mover.
        this.tokenUnused --;        
        audio_caer.rewind();
        audio_caer.play();
      }
    } else {
      // Si no hay más fichas a utilizar no se puede elegir columna.
      result = false;
    }
    
    return result;
  }
  
  // Seleccionar columna.
  void select(Column column) {  
    column.select(this);
  }
  
  // Configuración.
  void setup() { 
   // Se crea la caja.
    this.create_container();
    // Añadimos imagen sombra
    shadow_box = loadImage ("box_shadow1.png");
    // Añadimos imagen roja y amarilla
    red_box = loadImage ("red.png");
    yellow_box = loadImage ("yellow.png");
    redv_box = loadImage ("redv.png");
    yellowv_box = loadImage ("yellowv.png");
  }
  
  // Dibujar.
  void draw(int time){
    font_player = loadFont("Arial-BoldMT-48.vlw"); 
    shape(box_front , -50 + this.posPlayer, -30); 
    // Se dibujar las fichas.
    for (int i=0; i < 20; i++){      
      if (time_now > (time + (50*i))) {
        draw_box(i);    
      }      
    } 
    // Se dibujan las cajas.
    draw_container();
    
    if (this.state == PLAYER_PREPARED) {   
      // Si el jugador está preparado,se dibuja la ficha.
      draw_token_prepared();      
    } else if (this.state == PLAYER_SELECTED) {
      // Si el jugador selecciona la ficha baja.
      draw_token_prepared();
    }
  }
  
  // Se dibuja la caja.
  void draw_container() {       
    // Dibujar sombra de la caja.
    image(shadow_box, 745 + this.posPlayer, 658);
    shape(box_lateral , 190 + this.posPlayer, 0); 
    shape(box_lateral , 0 + this.posPlayer, 0);    
    shape(box_front , 0 + this.posPlayer, 0);      
    shape(box_top , 0 + this.posPlayer, 0);
    if (this.getState() == PLAYER_PREPARED) {
      fill (255, 255, 255);
      ellipse(940 + this.posPlayer, 680, 60, 60);
    } 
    if (this.getId() == 1) {
      image (red_box, 912 + this.posPlayer, 652);
    } else {
      image (yellow_box, 912 + this.posPlayer, 652);
    }
    textFont(font_player);
    fill (panel_front);
    textSize(30);
    text (this.getId(), 932 + this.posPlayer, 690);
  }
  
  // Dibujar la caja.
  void draw_box(int i) {
    if (this.getId() == 1) {
      image (redv_box, 960 + this.posPlayer - (8 * i),  550);
    } else {
      image (yellowv_box, 960 + this.posPlayer - (8 * i),  550);
    }
  }
  
   // Dibujar la ficha en preparación.
  void draw_token_prepared() {    
    int disp = (65 * (this.positionToken - 1));  
    // Pintar ficha según jugador.
    if (this.getId() == 1) {
      image (red_box, 165 + disp, 30);
    } else {
      image (yellow_box, 165 + disp, 30);
    }
    
  }
  
  // Se crea la caja.
  void create_container() {  
    box_front = createShape();
    box_front .beginShape();
    box_front .fill(panel_front);
    box_front .noStroke();
    box_front .vertex(850, 590);
    box_front .vertex(1040, 590);
    box_front .vertex(1040, 740);
    box_front .vertex(850, 740);
    box_front .endShape(CLOSE);
    
    box_lateral = createShape();
    box_lateral .beginShape();
    box_lateral .fill(panel_lateral);
    box_lateral .noStroke();
    box_lateral .vertex(800, 560);
    box_lateral .vertex(850, 590);
    box_lateral .vertex(850, 740);
    box_lateral .vertex(800, 710);
    box_lateral .endShape(CLOSE);
      
    box_top = createShape();
    box_top .beginShape();
    box_top .fill(panel_top);
    box_top .noStroke();
    box_top .vertex(820, 574);
    box_top .vertex(1010, 574);
    box_top .vertex(1040, 590);
    box_top .vertex(850, 590);
    box_top .endShape(CLOSE);
  }   
}
