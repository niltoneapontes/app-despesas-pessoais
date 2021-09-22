import 'package:expenses/components/adaptative_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    if (Platform.isIOS)
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (pickedDate) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      },
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime.now(),
                      minimumYear: 2020,
                      maximumDate: DateTime.now(),
                    ),
                  ),
                  // Close the modal
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: CupertinoButton(
                      child: Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  )
                ],
              ),
            );
          });
    else
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          setState(() {
            _selectedDate = null as DateTime;
          });
          return;
        }

        setState(() {
          _selectedDate = pickedDate;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final _inputFields = Platform.isIOS
        ? [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CupertinoTextField(
                controller: _titleController,
                placeholder: 'Título',
                textInputAction: TextInputAction.next,
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CupertinoTextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                placeholder: 'Valor (R\$)',
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(DateFormat('dd/MM/y').format(_selectedDate)),
                  ),
                  TextButton(
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptativeButton(
                  label: 'Nova transação',
                  onPressed: _submitForm,
                )
              ],
            )
          ]
        : [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(DateFormat('dd/MM/y').format(_selectedDate)),
                  ),
                  TextButton(
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptativeButton(
                  label: 'Nova transação',
                  onPressed: _submitForm,
                )
              ],
            )
          ];

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 40 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(children: _inputFields),
        ),
      ),
    );
  }
}
