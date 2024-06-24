import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'dart:typed_data';
import 'dart:math';

import 'package:jong/game/extensions/game_extensions.dart';

class MultiplierGenerator {
  late final String salt;
  late final num e;

  MultiplierGenerator() {
    e = pow(2, 52);
    salt = generateSalt();
  }

  String generateSalt() {
    final bytes = Uint8List(3);
    bytes.fillRandom();
    return bytes.map((byte) => byte.toRadixString(2).padLeft(2, '0')).join('');
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
    print(h);

    if (int.parse(h.substring(0, 16), radix: 16) % 33 == 0) {
      return 1;
    }

    BigInt hInt = BigInt.parse(h.substring(0, 16), radix: 16);
    return (BigInt.from(100 * e) - hInt) / (BigInt.from(e) - hInt);
  }

  String getPrevGame(String hashCode) {
    final m = sha256.convert(hex.decode(hashCode));
    return m.toString();
  }

  // double radomNumber() {
  //   final a = int.parse(generateSalt().substring(0, 4), radix: 16);
  //   return 5 * (1+ sin(radians))
  // }
}

double getResult(String gameHash) {
  final hm = Hmac(sha256, hex.decode(gameHash));
  final h = hm
      .convert(hex.decode(
          "100af1b49f5e9f87efc81f838bf9b1f5e38293e5b4cf6d0b366c004e0a8d9987"))
      .toString();

  if (int.parse(h.substring(0, 16), radix: 16) % 33 == 0) {
    return 1;
  }

  BigInt hInt = BigInt.parse(h.substring(0, 16), radix: 16);
  return (BigInt.from(100 * e) - hInt) / (BigInt.from(e) - hInt);
}

void main() {
  List<MultiplierGenerator> a = [];

  for (var i = 0; i < 20; i++) {
    a.add(MultiplierGenerator());
    print(a[i].getResult("abcd"));
  }
  // print(b.hexToDouble(a.generateSalt().substring(0,2)));

  // final a = MultiplierGenerator();
  // print(a.getResult("3A7F"));
}
