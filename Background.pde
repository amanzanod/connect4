/**
 * Clase del fondo del juego.
 *
 */
public class Background {
  
  // Imagen background
  PImage background;
  
  // Configuración.
  void setup() {    
    // Añadimos imagen background
    background = loadImage ("background.jpg");
  }
  
  // Dibujar.
  void draw() {    
    image (background, 0, 0);
  }
  
}
