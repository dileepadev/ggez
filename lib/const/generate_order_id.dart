import 'dart:math';


class GenerateOrderId {
  String ggezOrderId() {
    var rng = Random();
    // for (var i = 0; i < 10; i++) {
    //   debugPrint('Ggez#${rng.nextInt(100)}');
    // }
    return 'GgezOrder#${rng.nextInt(1000000000)}';
  }
}