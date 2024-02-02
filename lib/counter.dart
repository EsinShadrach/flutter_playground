class Counter {
  int value = 0;

  void increment() {
    value++;
  }

  void decrement() {
    value--;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Counter &&
        other.runtimeType == runtimeType &&
        value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}
