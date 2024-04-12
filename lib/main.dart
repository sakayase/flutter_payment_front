import 'package:flutter/material.dart';
import 'pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final String titlePage = 'Payment';
  final String title = 'Formulaire de payement';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titlePage,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: PaymentPage(title: title),
    );
  }
}
