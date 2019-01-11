/**
 * Clase del juego.
 *
 */
public class Game {
  
  // Jugadores en la partida.
  private Player[] players = new Player[2];
  
  // Pizarra de la partida.
  private Board board;
  
  // Jugador que tiene el turno.
  private Player playerCurrent = null;
  
  // Jugador que ha ganado.
  private Player playerWinner = null;
  
  // Estado del juego.
  private int state = GAME_INTRO;
  
  // Constructor.
  Game(Player player1, Player player2, Board board) {
    this.players[0] = player1;
    this.players[1] = player2;
    this.board = board;
  }
  
  // Get players.
  Player[] getPlayers() {
    return this.players;
  }
  
  // Get player 1.
  Player getPlayer1() {    
    return this.players[0];
  }
  
  // Get player 2.
  Player getPlayer2() {    
    return this.players[1];
  }  
    
  // Get player current.
  Player getPlayerCurrent() {    
    return this.playerCurrent;
  }  
  
  // Get player winner.
  Player getPlayerWinner() {    
    return this.playerWinner;
  }
  
  // Get state.
  int getState() {
    return this.state;
  }
  
  // Sortear jugador aleatoriamente.
  void drawPlayer() {  
   int r = (int) random(0, 2);
   if (r == 1) {
     this.playerCurrent = getPlayer2();
   } else {
     this.playerCurrent = getPlayer1();
   } 
  }
  
  // Próximo jugador.
  void nextPlayer() {
    if (this.getPlayerCurrent().getId() == 1) {
      if (this.players[1].getTokenUnused() > 0) {
        this.playerCurrent = this.players[1];
      } else {
        this.finish();
      }
    } else {
      if (this.players[0].getTokenUnused() > 0) {
        this.playerCurrent = this.players[0];
      } else {
        this.finish();
      }
    }
  } 
  
  // Empezar a jugar.
  void reset() {
    this.board.reset(); 
    this.state = GAME_STARTED;
    for (Player player : this.getPlayers()) {
       player.reset();
    }    
    this.playerWinner = null;
  }
  
  // Empezar a jugar.
  void play() {
    this.state = GAME_STARTED;
    audio_juego.play(); 
  }
  
  // Terminar el juego.
  void finish() {
    this.state = GAME_FINISHED;
  }
  
  // Existe ganador?
  boolean isWinner() {    
    boolean result = this.board.checkWinner();   
    if (result) {
      audio_juego.pause();
      this.finish();
      this.playerWinner = this.getPlayerCurrent();  
      this.playerWinner.playSound();
    }
    return false;
  }  
}
