import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PagarBoletoPage extends StatefulWidget {
  const PagarBoletoPage({super.key});

  @override
  State<PagarBoletoPage> createState() => _PagarBoletoPageState();
}

class _PagarBoletoPageState extends State<PagarBoletoPage> {
  final TextEditingController _controller = TextEditingController();
  bool _barcodeScanned = false;
  String codigoBoleto = '';

  void _onBarcodeDetected(BarcodeCapture capture) {
    if (!_barcodeScanned && capture.barcodes.isNotEmpty) {
      final code = capture.barcodes.first.rawValue ?? '';
      if (code.isNotEmpty) {
        setState(() {
          codigoBoleto = code;
          _controller.text = code;
          _barcodeScanned = true;
        });
        debugPrint('Código do boleto lido: $code');
      }
    }
  }

  void _resetScanner() {
    setState(() {
      codigoBoleto = '';
      _controller.clear();
      _barcodeScanned = false;
    });
  }

  void _pagarBoleto() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Boleto pago: $codigoBoleto (mock)'),
        backgroundColor: Colors.green,
      ),
    );
    _resetScanner(); // reseta após pagamento mockado
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagar Boleto'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Scanner
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                MobileScanner(onDetect: _onBarcodeDetected),
                if (_barcodeScanned)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: Text(
                        'Código lido!',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Formulário e botão
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Código do boleto',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.qr_code_2),
                    ),
                    onChanged: (value) {
                      setState(() {
                        codigoBoleto = value;
                        _barcodeScanned = false;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: codigoBoleto.isEmpty ? null : _pagarBoleto,
                          icon: const Icon(Icons.payment),
                          label: const Text('Pagar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        icon: const Icon(Icons.restart_alt),
                        tooltip: 'Reiniciar scanner',
                        onPressed: _resetScanner,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
