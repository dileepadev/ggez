import 'dart:math';


class GenerateGgezEventRegisterID {
  String ggezEventId() {
    var rng = Random();
    // for (var i = 0; i < 10; i++) {
    //   debugPrint('Ggez#${rng.nextInt(100)}');
    // }
    return 'GgezEvents#${rng.nextInt(1000000000)}';
  }
}
