import 'package:flutter/material.dart';

class PerfilView extends StatelessWidget {
  const PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header com avatar, nome e email
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.person, size: 32, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Olá, Karen',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'karen@email.com',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Seções de configurações
          _buildSectionTitle('Conta'),
          _buildListTile(Icons.person_outline, 'Informações pessoais'),
          _buildListTile(Icons.notifications_none, 'Notificações'),
          _buildListTile(Icons.lock_outline, 'Segurança'),

          const SizedBox(height: 24),
          _buildSectionTitle('Preferências'),
          _buildListTile(Icons.brightness_6_outlined, 'Tema'),
          _buildListTile(Icons.language_outlined, 'Idioma'),

          const SizedBox(height: 24),
          _buildSectionTitle('Ajuda'),
          _buildListTile(Icons.help_outline, 'Central de Ajuda'),
          _buildListTile(Icons.info_outline, 'Sobre o app'),

          const SizedBox(height: 32),
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              icon: const Icon(Icons.logout),
              label: const Text('Sair da Conta'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
