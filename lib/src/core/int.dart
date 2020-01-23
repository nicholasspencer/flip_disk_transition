extension IntExtension on int {
  List<int> get digits {
    final digits = List<int>();

    var _this = this;

    while (_this > 0) {
      digits.add(_this % 10);
      _this = _this / 10 as int;
    }

    return digits.reversed.toList();
  }
}
