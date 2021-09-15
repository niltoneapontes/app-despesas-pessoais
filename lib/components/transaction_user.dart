import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
        id: '1',
        title: 'Novo tênis de corrida',
        value: 300.9,
        date: DateTime.now()),
    Transaction(
        id: '2', title: 'Conta de Luz', value: 159.99, date: DateTime.now()),
    Transaction(
        id: '3',
        title: 'Novo tênis de treino',
        value: 300.9,
        date: DateTime.now()),
    Transaction(
        id: '3',
        title: 'Novo tênis de treino',
        value: 300.9,
        date: DateTime.now()),
    Transaction(
        id: '3',
        title: 'Novo tênis de treino',
        value: 300.9,
        date: DateTime.now()),
    Transaction(
        id: '3',
        title: 'Novo tênis de treino',
        value: 300.9,
        date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions),
        TransactionForm(_addTransaction)
      ],
    );
  }
}
