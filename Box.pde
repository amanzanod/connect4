/**
 * Clase de la casilla.
 *
 */
public class Box {
  
  // Colores.
  color color_front = color (41, 70, 155);
  color color_light = color (88, 122, 198);  
  color color_shadow = color (30, 51, 130);  
  color color_empty = color (12, 26, 53);  
  color color_player = color_empty;   
      
  // Imagen ficha roja y amarila.
  PImage red_box;
  PImage yellow_box;
  
  // Coordenadas.
  int posX = 0;
  int posY = 0;

  // Identificador de la casilla.
  private int id;
  // Columna a la que pertenece.
  private Column column;
  // Jugador que la ha seleccionado, por defecto en null.
  private Player player = null;
  
  // Constructor.
  Box(int id, Column column) {
    this.setColumn(column);
    this.setId(id);
    this.setPosX();
    this.setPosY();
  }
  
  // Get id.
  int getId() {  
    return this.id;
  }
  
  // Set id.
  void setId(int id) {  
    this.id = id;
  }
  
  // Get column.
  Column getColumn() {  
    return this.column;
  }
  
  // Set column.
  void setColumn(Column column) {  
    this.column = column;
  }
  
  // Get Player.
  Player getPlayer() {
    return this.player;
  }
  
  // Set Player.
  void setPlayer(Player player) {
    this.player = player;
    if (this.player != null) {
      if (this.player.getId() == 1) {
        this.color_player = color(255, 0, 0);
      } else if (this.player.getId() == 2){
        this.color_player = color(255, 177, 0);
      } else {
        this.color_player = color_empty;
      }
    } else {
      this.color_player = color_empty;
    }
    
  }
  
  // Calcular coordenada X
  void setPosX() {
    int initX = 160;
    
    //this.posX = (65 * this.getId()) + initX;
    this.posX = initX + (65 * this.getColumn().getId());
  }
  
  // Calcular coordenada Y
  void setPosY() {
    int initY = 565;
    //this.posY = initY - (65 * this.getColumn().getId());
    this.posY = initY - (65 * this.getId());
    
  }  
  
  // ¿Está seleccionada?
  boolean isSelected() {
    if (this.getPlayer() != null) {
      return false;
    } else {
      return true;
    }
  }
  
  void reset() {
    this.setPlayer(null);
  }
  
  // Configuración.
  void setup() {    
  }
  
  // Dibujar.
  void draw(){
    // Se dibuja la casilla.
    draw_box(); 
  }  
  
  // Dibujar la casilla.
  void draw_box() {
    noStroke();
    fill (color_front);
    rect (posX, posY, 65, 65);
    fill (color_light);
    ellipse(posX + 32, posY + 32, 60, 60);
    fill (color_shadow);
    ellipse(posX + 33, posY + 33, 57, 57); 
    fill (color_player);
    ellipse(posX + 32, posY + 32, 50, 50);
    if (this.player != null) {
      if (this.player.getId() == 1) {
         red_box = loadImage ("red.png");
         image (red_box, posX + 5, posY + 5);
      } else if (this.player.getId() == 2){
        yellow_box = loadImage ("yellow.png");
        image (yellow_box, posX + 5, posY + 5);
      } 
    }     
  }
  
}
