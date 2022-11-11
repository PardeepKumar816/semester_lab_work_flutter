import 'dart:isolate';

import 'package:flutter/material.dart';

import 'main.dart';

void main() {
  void isofunction(var msg) {
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 5; j++) {
        debugPrint(msg + "$i" + '$j');
      }
    }
  }
  // void concurr(var message) {
  //   debugPrint('$message From Isolate');
  // }
  //
  // Isolate.spawn(concurr, 'Mad');
  // Isolate.spawn(concurr, 'Practical');
  // Isolate.spawn(concurr, 'No. 7');
  // Isolate.spawn(concurr, 'saeen muhammad uzair khawaja');

  Isolate.spawn(isofunction, 'Iso function');

  debugPrint('Normal debugPrint 1');
  debugPrint('Normal debugPrint 2');
  debugPrint('Normal debugPrint 3');
  runApp(const MyApp());
}
