// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:fl_seoul/main.dart';

void main() {
  testWidgets('fl_seoul navigation smoke test', (WidgetTester tester) async {
    final prefs = await SharedPreferences.getInstance();
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(prefs));

    // Tap the local_see icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.local_see));
    await tester.pump();

    // Verify that our map has moved.
    expect(find.text('0'), findsNothing);
  });
}
