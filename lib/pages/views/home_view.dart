import 'package:flutter/material.dart';
import 'dart:math';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool mostrarSaldo = true;
  double saldo = 0;

  void gerarSaldoFake() {
    setState(() {
      saldo = Random().nextDouble() * 10000;
    });
  }

  void toggleSaldo() {
    setState(() {
      mostrarSaldo = !mostrarSaldo;
    });
  }

  @override
  void initState() {
    super.initState();
    gerarSaldoFake();
  }

  @override
  Widget build(BuildContext context) {
    final textoSaldo = mostrarSaldo
        ? 'R\$ ${saldo.toStringAsFixed(2)}'
        : '••••••••';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOPO COM LOGO E NOME DO BANCO
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.account_balance, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                Text(
                  'Banco Ágil',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // SALDO
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade500, Colors.deepPurple.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_wallet_rounded, size: 36, color: Colors.white),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        textoSaldo,
                        key: ValueKey(mostrarSaldo),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      mostrarSaldo ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: toggleSaldo,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // MENU RÁPIDO
            Text(
              'Acesso Rápido',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
            ),
            const SizedBox(height: 16),

            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 100,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: [
                _menuItem(Icons.pix, 'Pix', () {
                  Navigator.pushNamed(context, '/pix');
                }),
                _menuItem(Icons.send_rounded, 'Transferir', () {
                  Navigator.pushNamed(context, '/transferencia');
                }),
                _menuItem(Icons.monetization_on_rounded, 'Empréstimo', () {
                  Navigator.pushNamed(context, '/emprestimo');
                }),
                _menuItem(Icons.add_card_rounded, 'Gerar Saldo', gerarSaldoFake),
                _menuItem(Icons.qr_code_scanner_rounded, 'Pagar Boleto', () {
                  Navigator.pushNamed(context, '/pagar-boleto');
                }),
                _menuItem(Icons.trending_up_rounded, 'Cotação', () {
                  Navigator.pushNamed(context, '/cotacao');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.deepPurple),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
