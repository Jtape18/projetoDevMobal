import 'package:flutter/material.dart';

class PixView extends StatefulWidget {
  const PixView({super.key});

  @override
  State<PixView> createState() => _PixViewState();
}

class _PixViewState extends State<PixView> {
  final _chavePixController = TextEditingController();
  final _valorPixController = TextEditingController();

  bool _isEnviando = false;
  String? _mensagemErro;

  void _enviarPix() {
    setState(() => _mensagemErro = null);

    if (_chavePixController.text.isEmpty || _valorPixController.text.isEmpty) {
      setState(() => _mensagemErro = 'Preencha todos os campos');
      return;
    }

    setState(() => _isEnviando = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isEnviando = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pix de R\$ ${_valorPixController.text} enviado para ${_chavePixController.text} (mock)'),
            backgroundColor: Colors.green.shade600,
          ),
        );
        _chavePixController.clear();
        _valorPixController.clear();
      });
    });
  }

  InputDecoration get _inputDecoration => InputDecoration(
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
        title: const Text(
          'Enviar Pix',
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
                    child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 20),
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
                'Informe a chave e o valor para enviar Pix',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
              ),
              const SizedBox(height: 32),

              TextField(
                controller: _chavePixController,
                decoration: _inputDecoration.copyWith(labelText: 'Chave Pix'),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _valorPixController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                decoration: _inputDecoration.copyWith(labelText: 'Valor'),
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
                onPressed: _isEnviando ? null : _enviarPix,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isEnviando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                      )
                    : const Text(
                        'Enviar',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
