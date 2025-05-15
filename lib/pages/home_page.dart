import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Banco Digital')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.attach_money),
              label: const Text('Cotação'),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cotacao);
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Transferência'),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.transferencia);
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.analytics),
              label: const Text('Monitoramento'),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.monitoramento);
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.money),
              label: const Text('Empréstimo'),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.emprestimo);
              },
            ),
          ],
        ),
      ),
    );
  }
}
