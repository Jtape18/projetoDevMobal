import 'package:flutter/material.dart';

class EmprestimoView extends StatefulWidget {
  const EmprestimoView({super.key});

  @override
  State<EmprestimoView> createState() => _EmprestimoViewState();
}

class _EmprestimoViewState extends State<EmprestimoView> {
  final _controller = TextEditingController();
  bool _isSolicitando = false;
  String? _mensagemErro;

  void solicitarEmprestimo() {
    setState(() => _mensagemErro = null);
    final valor = _controller.text.trim();
    if (valor.isEmpty) {
      setState(() => _mensagemErro = 'Informe o valor do empréstimo');
      return;
    }

    setState(() => _isSolicitando = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isSolicitando = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Solicitado empréstimo de R\$ $valor (mock)')),
        );
        _controller.clear();
      });
    });
  }

  InputDecoration get _inputDecoration => InputDecoration(
        prefixText: 'R\$ ',
        labelStyle: TextStyle(color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Empréstimo',
          style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo + nome banco
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.deepPurple,
                    child: const Icon(Icons.account_balance, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Banco Ágil',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.deepPurple[700],
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              Text(
                'Informe o valor desejado:',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
              ),
              const SizedBox(height: 32),

              TextField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                decoration: _inputDecoration,
                enabled: !_isSolicitando,
              ),

              if (_mensagemErro != null) ...[
                const SizedBox(height: 16),
                Text(
                  _mensagemErro!,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _isSolicitando ? null : solicitarEmprestimo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isSolicitando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                      )
                    : const Text(
                        'Solicitar',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
