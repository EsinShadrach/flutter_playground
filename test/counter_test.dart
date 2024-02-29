import 'package:flutter_playground/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  await Future.delayed(
    const Duration(seconds: 1),
  );
  group('Counter Group =>', () {
    test('Counter Increment test', () {
      Counter counter = Counter();
      counter.increment();

      expect(
        counter.value,
        2,
        reason:
            "Failed: Count value at initial state is 0, so after increment it should be 1.",
        skip: true,
      );
    });

    test('Counter Decrement test', () {
      Counter counter = Counter();
      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
