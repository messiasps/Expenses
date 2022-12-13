import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
//color: Theme.of(context).colorScheme.primary
class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ? Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Nenhuma Transação Cadastrada!',
            style: Theme.of(context).textTheme.headline6,
            // style: TextStyle(
            //   color: Theme.of(context).colorScheme.primary,
            //   //style: theme.of(context).textTheme.title
            // ),
          ),
          const SizedBox(height: 20),//espaço entre os texto
          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png',
            fit: BoxFit.cover,
            ),
          ),
        ],
      ) : ListView.builder(
        itemCount: transactions.length,//qtd de itens da lista
        itemBuilder: ((ctx, index) {
          final tr = transactions[index];
          return Card(
                    child: Row(
                      children: [//filhos de row
                        Container(//colocar estilo
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            //color: Colors.purple,
                            color: Theme.of(context).colorScheme.primary,//assumindo a cor do theme, ou seja consigo pegar a cor padrão do theme!
                            width: 2,
                          )
                        ),
                        padding: const EdgeInsets.all(10),
                          child: Text(
                            'R\$ ${tr.value.toStringAsFixed(2)}',//imprimir com duas casas decimais
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              ),
                            Text(
                              DateFormat('d MMM y').format(tr.date),
                              style: TextStyle(
                                color: Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
              }
            ),
    ),
    );
  }
}