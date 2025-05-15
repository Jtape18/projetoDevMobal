import 'package:flutter/material.dart';

class MonitoramentoPage extends StatelessWidget {
  const MonitoramentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gastos = {
      'Alimentação': 250.00,
      'Transporte': 120.00,
      'Lazer': 180.00,
      'Outros': 100.00,
    };

    double total = gastos.values.reduce((a, b) => a + b);

    return Scaffold(
      appBar: AppBar(title: const Text('Monitoramento Financeiro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total gasto no mês: R\$ ${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Gastos por categoria:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...gastos.entries.map(
              (e) => ListTile(
                leading: const Icon(Icons.category),
                title: Text(e.key),
                trailing: Text('R\$ ${e.value.toStringAsFixed(2)}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
