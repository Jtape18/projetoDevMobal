import 'package:flutter/material.dart';

class EmprestimoPage extends StatefulWidget {
  const EmprestimoPage({super.key});

  @override
  State<EmprestimoPage> createState() => _EmprestimoPageState();
}

class _EmprestimoPageState extends State<EmprestimoPage> {
  double valor = 0;
  int parcelas = 1;
  double resultado = 0;

  void calcularEmprestimo() {
    double juros = 0.05; // 5% ao mês
    double total = valor * (1 + juros * parcelas);
    setState(() {
      resultado = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulação de Empréstimo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Valor desejado'),
              keyboardType: TextInputType.number,
              onChanged: (v) => valor = double.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 10),
            DropdownButton<int>(
              value: parcelas,
              onChanged: (v) => setState(() => parcelas = v ?? 1),
              items:
                  [1, 3, 6, 12]
                      .map(
                        (p) => DropdownMenuItem(
                          value: p,
                          child: Text('$p parcelas'),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularEmprestimo,
              child: const Text('Simular'),
            ),
            const SizedBox(height: 20),
            if (resultado > 0)
              Text(
                'Total a pagar: R\$ ${resultado.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
