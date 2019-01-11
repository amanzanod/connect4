/**
 * Clase de la columna.
 *
 */
public class Column {

  // Identificador.
  private int id;
  // Casillas que componen la columna.
  private Box[] boxes = new Box[8];
  // Casilla actual para seleccionar.
  private Box currentBox;
  // ¿Es seleccionable la columna?
  private boolean isSelectable;
  
  // Constructor.
  Column(int id) { 
    this.setId(id);
    // Se crean 8 casillas por columna.
    for (int i=0; i < 8; i++){
      boxes[i] = new Box(i, this);
    } 
    
    this.isSelectable = true;
    
    // Por defecto la columan actual es la 0.
    this.setCurrentBox(boxes[0]);
  }
  
  // Get id.
  int getId() {  
    return this.id;
  }
  
  // Set id.
  void setId(int id) {  
    this.id = id;
  }
  
  // Get boxes.
  Box[] getBoxes() {
      return this.boxes;
  }
  
  // Get current box.
  Box getCurrentBox() {
    return this.currentBox;
  }
  
  // Set current box.
  void setCurrentBox(Box box) {
    this.currentBox = box;
  }

  // ¿Es seleccionable?
  boolean isSelectable() {
    return this.isSelectable;
  } 
  
  // Seleccionar por jugador.
  boolean select(Player player) {
    boolean result = false;
    Box current = this.getCurrentBox();    
    // Si es seleccionable.
    if (this.isSelectable()) {
       if (current.getId() < 7) {
         current.setPlayer(player);
         Box nextBox = this.nextBox();
         this.setCurrentBox(nextBox);
       } else if (current.getId() == 7) {
         current.setPlayer(player);
         this.isSelectable = false;
         result = true;
       } else {
         result = false;
       }
       result = true;       
    } else {
      result = false;
    }
    return result;
  }  
  
  // Siguiente casilla a seleccionar.
  private Box nextBox() {    
    Box next = null;    
    for (Box box : boxes) {
      if (box.getId() == this.getCurrentBox().getId() + 1) {
         next = box;
      }
    }    
    return next;  
  }
  
  // Resetear las columnas.
  void reset() {
    Box[] boxes = this.getBoxes();
    for (Box box : boxes) {
      box.reset();
    }  
    this.setCurrentBox(boxes[0]);
    this.isSelectable = true;
  }
  
  // Dibujar.
  void draw(){
    // Se dibuja la casilla.
    for (Box box : boxes) {
      box.draw();
    }
  }
  
}
