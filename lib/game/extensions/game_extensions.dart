import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';

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
}
