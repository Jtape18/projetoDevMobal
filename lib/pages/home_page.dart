import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Banco Digital')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.attach_money),
              label: const Text('Cotação'),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cotacao);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Transferência'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.transferencia,
                  arguments: {
                    'saldo': 1000.0, // exemplo de argumento
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
