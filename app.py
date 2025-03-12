from flask import Flask, request, jsonify
from stockfish import Stockfish

STOCKFISH_PATH = "stockfish" 

# Initialisation de Stockfish avec les paramètres souhaités
stockfish = Stockfish(path=STOCKFISH_PATH, parameters={"Threads": 2, "Minimum Thinking Time": 30})

app = Flask(__name__)

@app.route("/bestmove", methods=["POST"])
def bestmove():
    """
    Endpoint qui reçoit une position FEN en JSON et retourne le meilleur coup proposé par Stockfish.
    Exemple de payload JSON : {"fen": "rnbqkb1r/pppppppp/5n2/8/2B5/8/PPPPPPPP/RNBQK1NR w KQkq - 2 3"}
    """
    data = request.get_json()
    fen = data.get("fen")
    
    if not fen:
        return jsonify({"error": "Le champ 'fen' est requis"}), 400

    # Configurer la position dans Stockfish
    stockfish.set_fen_position(fen)
    best_move = stockfish.get_best_move()

    # Retourne le coup suggéré
    return jsonify({"fen": fen, "best_move": best_move})

if __name__ == "__main__":
    # Lancer le serveur Flask sur l'adresse 0.0.0.0 pour être accessible en ligne
    app.run(debug=True, host="0.0.0.0", port=5000)
