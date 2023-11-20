import 'package:flutter/material.dart';
import 'feriados_screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key});

  void _navigateToFeriados(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeriadosScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Cursos'),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Professores'),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Feriados'),
            onTap: () => _navigateToFeriados(context), // Chama a função de navegação
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
