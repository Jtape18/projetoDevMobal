import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CotacaoView extends StatefulWidget {
  const CotacaoView({super.key});

  @override
  State<CotacaoView> createState() => _CotacaoViewState();
}

class _CotacaoViewState extends State<CotacaoView> {
  String? cotacao;
  bool carregando = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    buscarCotacao();
  }

  Future<void> buscarCotacao() async {
    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      final url = Uri.parse('https://economia.awesomeapi.com.br/json/last/USD-BRL');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          cotacao = '1 USD = ${json['USDBRL']['bid']} BRL';
          carregando = false;
        });
      } else {
        setState(() {
          erro = 'Erro ao buscar cotação';
          carregando = false;
        });
      }
    } catch (e) {
      setState(() {
        erro = 'Erro de conexão';
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo e nome do banco
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 40),

              const Icon(Icons.monetization_on_rounded, size: 70, color: Colors.deepPurple),
              const SizedBox(height: 20),

              Text(
                'Cotação Atual do Dólar',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),

              if (carregando)
                const CircularProgressIndicator()
              else if (erro != null)
                Column(
                  children: [
                    const Icon(Icons.error_outline, size: 40, color: Colors.red),
                    const SizedBox(height: 10),
                    Text(
                      erro!,
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ],
                )
              else
                Text(
                  cotacao ?? '',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: buscarCotacao,
                icon: const Icon(Icons.refresh),
                label: const Text('Atualizar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
