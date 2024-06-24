import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'dart:typed_data';
import 'dart:math';

extension Uint8ListExtension on Uint8List {
  Uint8List fillRandom() {
    Random random = Random();
    for (int i = 0; i < length; i++) {
      this[i] = random.nextInt(256);
    }
    return this;
  }
}

class MultiplierGenerator {
  late final String salt;
  late final num e;

  MultiplierGenerator() {
    e = pow(2, 52);
    salt = generateSalt();
  }

  String generateSalt() {
    final bytes = Uint8List(16);
    bytes.fillRandom();
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
  }

  double generate(String? hash) {
    hash ??= "100af1b49f5e9f87efc81f838bf9b1f5e38293e5b4cf6d0b366c004e0a8d9987";
    final value = getResult(hash);
    hash = getPrevGame(hash);
    return value;
  }

  double getResult(String gameHash) {
    final hm = Hmac(sha256, hex.decode(gameHash));
    final h = hm.convert(hex.decode(salt)).toString();

    if (int.parse(h.substring(0, 16), radix: 16) % 33 == 0) {
      return 1;
    }

    var hInt = int.parse(h.substring(0, 16), radix: 16);
    return (100 * e - hInt) / (e - hInt);
  }

  String getPrevGame(String hashCode) {
    final m = sha256.convert(hex.decode(hashCode));
    return m.toString();
  }
}

void main() {
  final a = MultiplierGenerator();
  print(a.generateSalt());
}
