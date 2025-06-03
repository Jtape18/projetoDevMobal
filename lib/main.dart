import 'package:flutter/material.dart';
import 'package:meu_projeto/pages/views/cotacao_view.dart';
import 'package:meu_projeto/pages/views/emprestimo_view.dart';
import 'package:meu_projeto/pages/views/pix_view.dart';
import 'package:meu_projeto/pages/views/transferencia_view.dart';
import 'routes/app_routes.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/pagar_boleto_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco Digital',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.cotacao: (context) => const CotacaoView(),
        AppRoutes.pagarBoleto: (context) => const PagarBoletoPage(),
        AppRoutes.emprestimo: (context) => const EmprestimoView(),
        AppRoutes.transferencia: (context) => const TransferenciaView(),
        AppRoutes.pix: (context) => const PixView(),
      },
    );
  }
}
