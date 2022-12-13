import '/components/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  //vai ser repassado os ultimos sete dias do termo de transação.

  final List<Transaction> recenteTransaction;

  Chart(this.recenteTransaction);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      
      double totalSum = 0.0;

      for(var i = 0; i < recenteTransaction.length; i++) {
        bool sameDay = recenteTransaction[i].date.day == weekDay.day;
        bool sameMonth = recenteTransaction[i].date.month == weekDay.month;
        bool sameYear = recenteTransaction[i].date.year == weekDay.year;

        if(sameDay && sameMonth && sameYear) {
          totalSum += recenteTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0], 
        'value': totalSum,
        };
    });
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
        return sum + (tr['value'] as double);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: (tr['day'] as String), 
                value: (tr['value'] as double), 
            //(tr['value'] as double) significa cast para indicar que o dado é double           
                percentage: (tr['value'] as double) / _weekTotalValue,
                ),
            );
          }).toList(),
        ),
      ),
    );
  }
}