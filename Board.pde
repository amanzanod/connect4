/**
 * Clase del tablero.
 *
 */
public class Board {
  
  /*
  * Constantes globales.
  *
  */
  static final int BOARD_OPEN  = 1;
  static final int BOARD_CLOSE = 0;
  static final int RESET_OPEN  = 0;
  static final int RESET_CLOSE = 1;
  
  // Colores.
  color panel_front = color (41, 70, 155);
  color panel_back = color (0, 26, 73);
  color panel_lateral = color (25, 46, 106);
  color panel_top = color (32, 45, 96);
  color panel_top2 = color (30, 55, 128);
  
  // Formar a crear.
  PShape footer_panel_front;
  PShape footer_panel_top1;
  PShape footer_panel_top2;
  PShape footer_panel_top3;
  PShape footer_panel_top4;
  PShape footer_panel_top5;
  PShape footer_panel_lateral1;
  PShape footer_panel_lateral2; 
  PShape top_panel_closed;
  PShape box_front;
  PShape box_top;
  PShape box_lateral;
  
  // Imagen sombra del pie
  PImage shadow_footer;

  // Columnas que componen el tablero.
  private Column[] columns = new Column[8];
  
  // Estado del panel {Abierto o cerrado}
  private int state = BOARD_CLOSE;
  
  // Estado del reseteador.
  private int stateReset = RESET_CLOSE;
  
  // Constructor.
  Board() {   
    // Se crean 8 columnas.
    for (int i=0; i < 8; i++){
      columns[i] = new Column(i);
    }  
  }
  
  // Get Columns.
  Column[] getColumns() {  
    return this.columns;
  }
  
  // Get state.
  int getState() {
    return this.state;
  }
  
  // Set state.
  void setState(int state) {
    this.state = state;
  }
  
  // Reset.
  void reset() {
    for (Column column : columns) {
      column.reset();
    }
  }
  
  // Set State Reset.
  void setStateReset(int state) {
    this.stateReset = state;
  }
  
  // Comprobar si hay ganador.
  boolean checkWinner() {
    boolean result = false;  
    // Comprobar las columnas.
    boolean resultColumn = this.checkColumn();   
    if (resultColumn) { return true;}
    // Comprobar las filas.
    boolean resultRow = this.checkRow();    
    if (resultRow) { return true;}
    // Comprobar las diagonales.
    boolean resultDiagonal = this.checkDiagonal();    
    if (resultDiagonal) { return true;}   
    return result;
  }
  
  // Comprobar las columnas.
  boolean checkColumn() {    
    boolean result = false;    
    // Se crea un array con las fichas de cada columna.
    for (Column column : this.getColumns()) {      
      Box[] boxes = column.getBoxes();  
      int[] col = new int[8];
      
      for (int j=0; j < 8; j++) { 
        if (boxes[j].getPlayer() != null) {
          col[j] = boxes[j].getPlayer().getId();
        } else {
          col[j] = 0;
        }   
      }    
      // Se comprueba que la columna tiene ganador.
      if (checkGroup(col)) {
           return true;
       }        
    }    
    return result;  
  }
  
  boolean checkRow(){
    boolean result = false;
    
    Column[] columns = this.getColumns();       
    // Se crea un array con las fichas de cada fila.
    for (int j=0; j < 8; j++) {      
      int[] row = new int[8];    
      for (int i=0; i < 8; i++) {
        Column column = columns[i];
        if (column.getBoxes()[j].getPlayer() != null) {
             row[i] = column.getBoxes()[j].getPlayer().getId();
         } else {
             row[i] = 0;
         }
      }      
      // Se comprueba que la columna tiene ganador.
      if (checkGroup(row)) {
           return true;
       }  
    }    
    return result;  
  } 
  
  boolean checkDiagonal(){
    boolean result = false;
    // Se comprueban los 4 casos de diagonales.
    if (checkDiagonalGeneral("up_after", 1)) {return true;}    
    if (checkDiagonalGeneral("up_before", 0)) {return true;}    
    if (checkDiagonalGeneral("down_after", 1)) {return true;}    
    if (checkDiagonalGeneral("down_before", 0)) {return true;}    
    return result;  
  }
  
  boolean checkDiagonalGeneral(String type, int n) {
    boolean result = false;
    
    Column[] columns = this.getColumns();
    // Se crea un array con las fichas de cada fila.
    for (int j=0; j < 5; j++) {   
      int[] diagonal = new int[8];
      for (int i=0; i < (7 + n - j); i++) {        
        switch (type) {
            case "up_after":  
                  if (columns[0 + j + i].getBoxes()[0 + i].getPlayer() != null) { 
                    diagonal[0 + i] = columns[0 + j + i].getBoxes()[0 + i].getPlayer().getId();     
                  }
                  break;
            case "up_before":  
                  if (columns[0 + i].getBoxes()[1 + j + i].getPlayer() != null) {          
                    diagonal[0 + i] = columns[0 + i].getBoxes()[1 + j + i].getPlayer().getId();
                  } 
                  break;                  
            case "down_after":  
                  if (columns[7 - i - j].getBoxes()[0 + i].getPlayer() != null) {          
                    diagonal[0 + i] = columns[7 - i - j].getBoxes()[0 + i].getPlayer().getId();
                  } 
                  break;                  
            case "down_before":  
                  if (columns[7 - i].getBoxes()[1 + i + j].getPlayer() != null) {          
                    diagonal[0 + i] = columns[7 - i].getBoxes()[1 + i + j].getPlayer().getId();
                  } 
                  break;    
        }
      }      
      // Se comprueba que la columna tiene ganador.
      if (checkGroup(diagonal)) {
           return true;
       }  
    }    
    return result;
  }
  
  // Comprobar los grupos de casillas creados en la comprobación.
  boolean checkGroup(int[] group) {
    boolean result = false;
    
    int playerId = -1;
    int count = 1;
    // Si existen cuatro casillas del mismo jugador seguidas, hay ganador.
    for (int box : group) {
        if ((playerId == box) && (box != 0)) {
           playerId = box;
           count ++;
        } else {
           playerId = box;
           count = 1;
        }        
        if (count == 4) {
           return true;
        }   
      }
      return result;    
  }
  
  // Configuración.
  void setup() { 
    // Se crea el pie.
    create_footer_panel();
    create_panel_closed();
    
    // Añadimos imagen background
    shadow_footer = loadImage ("shadow_footer.png");
  }
  
  // Dibujar.
  void draw(){
     // Sombra del pie.
    image (shadow_footer, 0, 0);
    if (this.getState() == BOARD_CLOSE) {
      this.panel_closed();
    } else {
      this.panel_open();
    }
  }
  
  // Panel cerrado.
  void panel_closed() {   
    // Se dibuja el pie.
    draw_footer_panel();
    // Se dibuja el panel.
    draw_panel_closed();  
  }
  
  // Panel abierto.
  void panel_open() {
     // Se dibuja el panel.
    draw_panel();     
    // Se dibuja el pie.
    draw_footer_panel();
    // Dibujar las columnas.   
    for (Column column : columns) {
      column.draw();
    }
    
    if (this.stateReset == RESET_CLOSE) {
      this.draw_reset_open();
    } else {
      this.draw_reset_close();
    }    
  }

  // Dibujar el panel.
  void draw_panel() {
    noStroke();
    fill (panel_back);
    rect (160, 90, 520, 540);
    fill (panel_front);
    rect (150, 100, 540, 540);
    fill (panel_lateral);
    triangle (150, 100, 160, 100, 160, 90);
    triangle (680, 90, 680, 100, 690, 100); 
  }
  
  // Dibujar boton reset abierto.
  void draw_reset_open() {    
    fill (panel_top);
    ellipse(125, 500, 54, 27);
    fill (panel_front);
    ellipse(125, 495, 54, 27);      
  }  
    
  // Dibujar boton reset cerrado.
  void draw_reset_close() {
    fill (panel_top);
    rect(95, 495, 55, 9);      
  }
  
  // Dibujar el panel.
  void draw_panel_closed() {
    noStroke();
    fill (panel_front);
    rect (120, 590, 600, 80);
    shape(top_panel_closed , 0, 0);
  }
  
  void create_panel_closed() {          
     top_panel_closed = createShape();
     top_panel_closed .beginShape();
     top_panel_closed .fill(panel_top);
     top_panel_closed .noStroke();
     top_panel_closed .vertex(120, 590);
     top_panel_closed .vertex(720, 590);
     top_panel_closed .vertex(690, 520);
     top_panel_closed .vertex(150, 520);
     top_panel_closed .endShape(CLOSE);
  }
  
  // Se dibuja el pie del panel.
  void draw_footer_panel() {  
    // Formas
    shape(footer_panel_lateral1 , 0, 0);
    shape(footer_panel_lateral2 , 0, 0);
    shape(footer_panel_top5 , 0, 0);
    shape(footer_panel_top1 , 1, 0);
    shape(footer_panel_top2 , -1, 0);
    shape(footer_panel_top3 , 0, 0);
    shape(footer_panel_top4 , 0, 0);
    shape(footer_panel_front , 0, 0);
  }

  // Se crea el pie del panel.
  void create_footer_panel() {
     footer_panel_front = createShape();
     footer_panel_front .beginShape();
     footer_panel_front .fill(panel_front);
     footer_panel_front .noStroke();
     footer_panel_front .vertex(80, 590);
     footer_panel_front .vertex(80, 740);
     footer_panel_front .vertex(110, 740);
     footer_panel_front .vertex(110, 730);   
     footer_panel_front .vertex(730, 730);   
     footer_panel_front .vertex(730, 740);   
     footer_panel_front .vertex(760, 740);
     footer_panel_front .vertex(760, 740);
     footer_panel_front .vertex(760, 590);
     footer_panel_front .vertex(730, 590);
     footer_panel_front .vertex(730, 680);
     footer_panel_front .vertex(490, 680);
     footer_panel_front .vertex(450, 720);
     footer_panel_front .vertex(390, 720);
     footer_panel_front .vertex(350, 680);
     footer_panel_front .vertex(110, 680);
     footer_panel_front .vertex(110, 590);
     footer_panel_front .endShape(CLOSE);
     
     footer_panel_top1 = createShape();
     footer_panel_top1 .beginShape();
     footer_panel_top1 .fill(panel_top);
     footer_panel_top1 .noStroke();
     footer_panel_top1 .vertex(80, 590);
     footer_panel_top1 .vertex(110, 590);
     footer_panel_top1 .vertex(150, 550);
     footer_panel_top1 .vertex(150, 520);
     footer_panel_top1 .endShape(CLOSE);
     
     footer_panel_top2 = createShape();
     footer_panel_top2 .beginShape();
     footer_panel_top2 .fill(panel_top);
     footer_panel_top2 .noStroke();
     footer_panel_top2 .vertex(690, 550);
     footer_panel_top2 .vertex(690, 520);
     footer_panel_top2 .vertex(760, 590);
     footer_panel_top2 .vertex(730, 590);
     footer_panel_top2 .endShape(CLOSE);
     
     footer_panel_top3 = createShape();
     footer_panel_top3 .beginShape();
     footer_panel_top3 .fill(panel_top);
     footer_panel_top3 .noStroke();
     footer_panel_top3 .vertex(118, 673);
     footer_panel_top3 .vertex(357, 673);
     footer_panel_top3 .vertex(395, 710);
     footer_panel_top3 .vertex(390, 720);
     footer_panel_top3 .vertex(350, 680);
     footer_panel_top3 .vertex(110, 680);
     footer_panel_top3 .endShape(CLOSE);
     
     footer_panel_top4 = createShape();
     footer_panel_top4 .beginShape();
     footer_panel_top4 .fill(panel_top);
     footer_panel_top4 .noStroke();
     footer_panel_top4 .vertex(446, 710);
     footer_panel_top4 .vertex(483, 673);
     footer_panel_top4 .vertex(723, 673);
     footer_panel_top4 .vertex(730, 680);
     footer_panel_top4 .vertex(490, 680);
     footer_panel_top4 .vertex(450, 720);
     footer_panel_top4 .endShape(CLOSE);   
        
     footer_panel_top5 = createShape();
     footer_panel_top5 .beginShape();
     footer_panel_top5 .fill(panel_top2);
     footer_panel_top5 .noStroke();
     footer_panel_top5 .vertex(110, 720);
     footer_panel_top5 .vertex(190, 640);
     footer_panel_top5 .vertex(653, 640);
     footer_panel_top5 .vertex(730, 720);
     footer_panel_top5 .vertex(490, 680);
     footer_panel_top5 .vertex(730, 720);
     footer_panel_top5 .endShape(CLOSE);
     
     footer_panel_lateral1 = createShape();
     footer_panel_lateral1 .beginShape();
     footer_panel_lateral1 .fill(panel_lateral);
     footer_panel_lateral1 .noStroke();
     footer_panel_lateral1 .vertex(110, 590);
     footer_panel_lateral1 .vertex(150, 550);
     footer_panel_lateral1 .vertex(150, 640);
     footer_panel_lateral1 .vertex(190, 640);
     footer_panel_lateral1 .vertex(110, 740);
     footer_panel_lateral1 .endShape(CLOSE);   
        
     footer_panel_lateral2 = createShape();
     footer_panel_lateral2 .beginShape();
     footer_panel_lateral2 .fill(panel_lateral);
     footer_panel_lateral2 .noStroke();
     footer_panel_lateral2 .vertex(690, 550);
     footer_panel_lateral2 .vertex(730, 590);
     footer_panel_lateral2 .vertex(730, 740);
     footer_panel_lateral2 .vertex(647, 640);
     footer_panel_lateral2 .vertex(690, 640);
     footer_panel_lateral2 .endShape(CLOSE);
  }
}
