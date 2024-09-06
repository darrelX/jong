import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

extension Uint8ListExtension on Uint8List {
  Uint8List fillRandom() {
    Random random = Random();
    for (int i = 0; i < length; i++) {
      this[i] = random.nextInt(100);
    }
    return this;
  }
}

extension X on double {
  double hexToDouble(String hex) {
    int int64 = int.parse(hex, radix: 16);
    var uint8List = Uint8List(8);
    var byteData = ByteData.sublistView(uint8List);
    byteData.setInt64(0, int64);
    var float64List = Float64List.sublistView(uint8List);

    return float64List[0];
  }

  double generateCrashNumber() {
    // Étape 1 : Initialisation
    int seed = Random().nextInt(10); // Graine aléatoire pour chaque exécution

    final random = Random(seed);

    // Étape 2 : Génération de la Valeur de Base
    double randomValue = random.nextDouble(); // Valeur aléatoire entre 0 et 1
    DateTime now = DateTime.now();
    String hashInput = '$seed$randomValue$now';
    var bytes = utf8.encode(hashInput);

    var hashOutput = sha256.convert(bytes).toString().substring(0, 7);
    int baseValue = int.parse(hashOutput, radix: 16) % 100;
    // print(baseValue);

    // Étape 3 : Calcul de la Valeur Finale

    // Étape 4 : Introduction de l'Accélération
    double acceleratedValue =
        (baseValue.toDouble() * log(1 + baseValue.toDouble() / 100)) % 50;

    // Étape 5 : Arrondi et Retour
    double finalValue = (acceleratedValue % 100).toDouble();
    return ((finalValue - 0) / (50 - 0)) * (10 - 0) + 0;

    // return double.parse(finalValue.toStringAsFixed(2));
  }
}
