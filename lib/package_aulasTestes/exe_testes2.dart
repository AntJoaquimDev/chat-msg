import 'dart:async';

void main(List<String> args) {
  final s = Stream<int>.multi((controller) {
    Timer.periodic(Duration(seconds: 1), (timer) => controller.add(1));
    controller.isPaused;
  });

  s.listen((valor) {
    print('O valor é $valor');
  });
}
