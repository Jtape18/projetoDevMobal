import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CotacaoPage extends StatefulWidget {
  const CotacaoPage({super.key});

  @override
  State<CotacaoPage> createState() => _CotacaoPageState();
}

class _CotacaoPageState extends State<CotacaoPage> {
  String cotacao = 'Carregando...';

  @override
  void initState() {
    super.initState();
    buscarCotacao();
  }

  Future<void> buscarCotacao() async {
    final url = Uri.parse(
      'https://economia.awesomeapi.com.br/json/last/USD-BRL',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        cotacao = '1 USD = ${json['USDBRL']['bid']} BRL';
      });
    } else {
      setState(() {
        cotacao = 'Erro ao buscar cotação';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cotação')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(cotacao, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: buscarCotacao,
              child: const Text('Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
