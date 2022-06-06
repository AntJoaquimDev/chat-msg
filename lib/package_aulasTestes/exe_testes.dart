void main(List<String> args) {
  final s = Stream<int>.periodic(
    Duration(seconds: 2),
    (indexs) => indexs + 2,
  ).take(10);

  s.listen((valor) {
    print('O valor é $valor');
  });
}
