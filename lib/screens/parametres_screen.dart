import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      // Q2.2 : ListView à la place de Column, avec padding de 8
      body: ListView(
        padding: const EdgeInsets.all(8),
        // Q2.3 : divideTiles insère automatiquement un séparateur entre les tuiles
        // (avant : on écrivait un Divider() à la main entre chaque ListTile)
        children: ListTile.divideTiles(
          context: context,
          tiles: [
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
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Langue'),
              subtitle: const Text('Français'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('À propos'),
              subtitle:
                  const Text('MaBiblio version 1.0\nTP Listes et grilles'),
              isThreeLine: true,
              onTap: () {},
            ),
          ],
        ).toList(),
      ),
    );
  }
}