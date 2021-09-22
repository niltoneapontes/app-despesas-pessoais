import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  String avatarText(value) {
    if (value >= 1000000) {
      value = value / 1000000;
      return 'R\$${value.toStringAsFixed(2).replaceAll('.', ',')}M';
    } else if (value >= 1000) {
      value = value / 1000;
      return 'R\$${value.toStringAsFixed(2).replaceAll('.', ',')}k';
    } else
      return 'R\$${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.1),
                Container(
                  height: constraints.maxHeight * 0.3,
                  child: Text('Não há transações cadastradas',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  // child: Image.asset(
                  //   'assets/images/waiting.png',
                  //   fit: BoxFit.cover,
                  // ),
                  child: Text('😴',
                      style: TextStyle(
                          fontSize:
                              40 * MediaQuery.of(context).textScaleFactor)),
                )
              ],
            );
          })
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
                          child: Text(avatarText(transaction.value)),
                        ),
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
                  trailing: MediaQuery.of(context).size.width > 200
                      ? TextButton.icon(
                          onPressed: () => deleteTransaction(transaction.id),
                          label: Text(
                            'Excluir',
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          ),
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTransaction(transaction.id),
                          color: Theme.of(context).errorColor),
                ),
              );
            },
          );
  }
}
