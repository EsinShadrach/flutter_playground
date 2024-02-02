import 'package:flutter/material.dart';
import 'package:flutter_playground/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  await Future.delayed(
    const Duration(seconds: 1),
  );
  group('Counter Group =>', () {
    test('Counter Increment test', () {
      debugPrint('Counter Increment test');
      Counter counter = Counter();
      counter.increment();

      expect(counter.value, 1);
    });

    test('Counter Decrement test', () {
      Counter counter = Counter();
      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
