import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: Column(
        children: [
          // Q1.1 + Q1.2 : Mon profil avec onTap et SnackBar
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mon profil'),
            subtitle: const Text('Nom, e-mail, mot de passe'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil sélectionné')),
              );
            },
          ),

          // Q1.3 + Q1.5 : Notifications personnalisée
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Alertes et rappels'),
            trailing: const Icon(Icons.chevron_right),
            tileColor: Colors.indigo.shade50,
            iconColor: Colors.indigo,
            textColor: Colors.indigo.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () {},
          ),

          // Q1.3 : Langue
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Langue'),
            subtitle: const Text('Français'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          // Q1.3 + Q1.4 : À propos
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('À propos'),
            subtitle: const Text('MaBiblio version 1.0\nTP Listes et grilles'),
            // dense: true,      // tuile plus compacte : hauteur et texte réduits
            isThreeLine: true,   // réserve la place de 3 lignes, icônes alignées en haut
            // enabled: false,   // tuile grisée, onTap désactivé, plus d'effet d'encre
            onTap: () {},
          ),
        ],
      ),
    );
  }
}