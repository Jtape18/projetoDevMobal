import 'package:flutter/material.dart';

class TransferenciaView extends StatefulWidget {
  const TransferenciaView({super.key});

  @override
  State<TransferenciaView> createState() => _TransferenciaViewState();
}

class _TransferenciaViewState extends State<TransferenciaView> {
  final _agenciaController = TextEditingController();
  final _contaController = TextEditingController();
  final _valorController = TextEditingController();

  bool _isTransferindo = false;
  String? _mensagemErro;

  void _transferir() {
    setState(() {
      _mensagemErro = null;
    });

    if (_agenciaController.text.isEmpty || _contaController.text.isEmpty || _valorController.text.isEmpty) {
      setState(() {
        _mensagemErro = 'Por favor, preencha todos os campos';
      });
      return;
    }

    setState(() {
      _isTransferindo = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isTransferindo = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transferência de R\$ ${_valorController.text} realizada (mock)'),
            backgroundColor: Colors.green.shade600,
          ),
        );
        _agenciaController.clear();
        _contaController.clear();
        _valorController.clear();
      });
    });
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[700]),
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

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
      title: const Text(
        'Transferência',
        style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
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
                    child: Icon(Icons.account_balance, color: Colors.white, size: 20),
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
                'Informe os dados para transferência',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
              ),
              const SizedBox(height: 32),

              TextField(
                controller: _agenciaController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration('Agência'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _contaController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration('Conta'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _valorController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: _inputDecoration('Valor'),
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
                onPressed: _isTransferindo ? null : _transferir,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isTransferindo
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                      )
                    : const Text(
                        'Transferir',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
