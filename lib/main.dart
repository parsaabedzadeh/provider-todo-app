import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provoider_test1/screens/home_page.dart';
import 'package:provoider_test1/variables.dart';

void main() {
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Variables(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    ),
  );
}
