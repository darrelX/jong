import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

double generateComplexCrashNumber() {
  // Étape 1 : Initialisation
  int seed =
      Random().nextInt(100); // Graine aléatoire pour une plus grande diversité
  final random = Random(seed);

  // Étape 2 : Génération de la Valeur de Base
  double randomValue = random.nextDouble() * 10; // Valeur entre 0 et 10
  DateTime now = DateTime.now();
  String hashInput = '$seed$randomValue${now.millisecondsSinceEpoch}';
  var bytes = utf8.encode(hashInput);

  var hashOutput = sha256.convert(bytes).toString().substring(0, 10);
  int baseValue = int.parse(hashOutput, radix: 16) % 200; // Changer la plage

  // Étape 3 : Calcul de la Valeur Finale
  double transformationFactor =
      sin(baseValue / 10) * 50; // Utiliser une fonction trigonométrique
  double adjustedBaseValue = baseValue + transformationFactor;

  // Étape 4 : Introduction de l'Accélération et du Bruit
  double noise = random.nextDouble() * 5; // Ajouter du bruit aléatoire
  double acceleratedValue =
      (adjustedBaseValue * log(1 + adjustedBaseValue / 150)) + noise;

  // Étape 5 : Arrondi et Retour
  double finalValue = (acceleratedValue % 150).toDouble();
   return ((finalValue - 0) / (50 - 0)) * (20 - 0) + 0; // Changer la plage de retour
}

void main() {
  for (var i = 0; i < 1000; i++) {
    print(generateComplexCrashNumber());
  }
}
