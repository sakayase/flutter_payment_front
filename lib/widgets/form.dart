import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input.dart';

final int minYear = DateTime.now().year;
const int maxYear = 2050;
final RegExp currencyRegex = RegExp(r'^[0-9]+(\.[0-9]{1,2})?$');

String? nameValidator(value) {
  if (value == null || value.isEmpty) {
    return 'emptyInputError';
  }
  return null;
}

String? numCardValidator(value) {
  if (value == null || value.isEmpty) {
    return 'emptyInputError';
  } else if (value.length < 12) {
    return 'cardNumberTooShortError';
  }
  return null;
}

String? cvvValidator(value) {
  {
    if (value == null || value.isEmpty) {
      return 'emptyInputError';
    }
    if (value.length < 3) {
      return 'cvvToShortError';
    }
    return null;
  }
}

List<String> generateListYears() {
  int currentYear = DateTime.now().year;
  List<String> yearList = [];
  for (var year = currentYear; year < currentYear + 10; year++) {
    yearList.add(year.toString().substring(year.toString().length - 2));
  }
  return yearList;
}

class FormWidget extends StatefulWidget {
  const FormWidget({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.monthController,
    required this.yearController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController monthController;
  final TextEditingController yearController;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final double height = 500.0;
  final double width = 500.0;
  final String nameHint = 'Nom';
  final String nameLabel = 'Titulaire de la carte :';
  final String numeroCarteHint = 'Numéro de la carte';
  final String numeroCarteLabel = 'Numéro de la carte :';
  final String cvvHint = 'CVV';
  final String cvvLabel = 'CVV :';
  final String monthHint = 'mm';
  final String yearHint = 'yyyy';
  final String dateLabel = 'Date d\'expiration :';
  final String amountLabel = 'Montant :';
  final String amountHint = '0.00';
  final bool isAmountDefined = false;

  var month;
  var year;

  List<String> listMonths = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];

  List<String> listYears = generateListYears();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Input(
              label: nameLabel,
              validatorFunction: nameValidator,
              hint: nameHint,
            ),
            Input(
              formatter: [
                LengthLimitingTextInputFormatter(19),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              label: numeroCarteLabel,
              validatorFunction: numCardValidator,
              hint: numeroCarteHint,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width / 3,
                  child: Row(
                    children: [
                      SizedBox(
                        width: width / 9,
                        child: DropdownButtonFormField(
                          menuMaxHeight: 300.0,
                          hint: const Text('mm'),
                          onChanged: (value) {
                            setState(() {
                              month = value;
                            });
                          },
                          items: listMonths.map((String month) {
                            return DropdownMenuItem(
                              child: Text(month),
                              value: month,
                            );
                          }).toList(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('/'),
                      ),
                      SizedBox(
                        width: width / 9,
                        child: DropdownButtonFormField(
                          menuMaxHeight: 300.0,
                          hint: const Text('yy'),
                          onChanged: (value) {
                            setState(() {
                              month = value;
                            });
                          },
                          items: listYears.map((String year) {
                            return DropdownMenuItem(
                              child: Text(year),
                              value: year,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width / 3,
                  child: Input(
                    label: cvvLabel,
                    validatorFunction: cvvValidator,
                    hint: cvvHint,
                    formatter: [
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                ),
              ],
            ),
            if (!isAmountDefined)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 3,
                    child: Input(
                      label: amountLabel,
                      validatorFunction: (str) => null,
                      hint: amountHint,
                      formatter: [
                        LengthLimitingTextInputFormatter(7),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^([0-9])*([,.][0-9]{0,2})?$')),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width / 3,
                  )
                ],
              ),
            SizedBox(
              width: width / 3,
              child: ElevatedButton(
                onPressed: () {
                  if (widget._formKey.currentState!.validate()) {
                    widget._formKey.currentState!.save();
                  }
                },
                child: const Text('Pay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
