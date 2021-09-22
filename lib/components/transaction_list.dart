import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text('Não há transações cadastradas',
                  style: Theme.of(context).textTheme.headline6),
              Container(
                height: 200,
                margin: EdgeInsets.only(top: 32),
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final transaction = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                                'R\$${transaction.value.toStringAsFixed(2).replaceAll('.', ',')}')),
                      ),
                      radius: 30),
                  title: Text(
                    '${transaction.title}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(transaction.date),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteTransaction(transaction.id),
                      color: Theme.of(context).errorColor),
                ),
              );
            },
          );
  }
}
