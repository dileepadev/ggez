import 'dart:math';


class GenerateGgezId {
  String ggezId() {
    var rng = Random();
    // for (var i = 0; i < 10; i++) {
    //   debugPrint('Ggez#${rng.nextInt(100)}');
    // }
    return 'Ggez#${rng.nextInt(1000000000)}';
  }
}
