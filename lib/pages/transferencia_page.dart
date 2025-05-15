import 'package:flutter/material.dart';

class TransferenciaPage extends StatefulWidget {
  const TransferenciaPage({super.key});

  @override
  State<TransferenciaPage> createState() => _TransferenciaPageState();
}

class _TransferenciaPageState extends State<TransferenciaPage> {
  final valorController = TextEditingController();
  String mensagem = '';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final saldoAtual = args?['saldo'] ?? 0.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Transferência')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Saldo atual: R\$ ${saldoAtual.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor da transferência',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final valor = double.tryParse(valorController.text) ?? 0.0;
                setState(() {
                  if (valor > 0 && valor <= saldoAtual) {
                    mensagem =
                        'Transferência de R\$ ${valor.toStringAsFixed(2)} realizada com sucesso!';
                  } else {
                    mensagem = 'Valor inválido ou saldo insuficiente.';
                  }
                });
              },
              child: const Text('Transferir'),
            ),
            const SizedBox(height: 20),
            Text(
              mensagem,
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
