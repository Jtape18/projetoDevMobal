import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/cotacao_page.dart';
import 'pages/transferencia_page.dart';

void main() {
  runApp(const BancoDigitalApp());
}

class BancoDigitalApp extends StatelessWidget {
  const BancoDigitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco Digital',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.cotacao: (context) => const CotacaoPage(),
        AppRoutes.transferencia: (context) => const TransferenciaPage(),
      },
    );
  }
}
