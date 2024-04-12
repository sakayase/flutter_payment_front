import 'package:flutter/material.dart';
import 'package:payment_front/widgets/form.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  DateTime expirationDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FormWidget(
              formKey: _formKey,
              monthController: monthController,
              yearController: yearController,
            ),
          ),
        ),
      ),
      bottomSheet: const BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Powered by Sakayase'),
          ],
        ),
      ),
    );
  }
}
