import 'package:flutter/material.dart';
import '../models/livre.dart';

Widget livreTile(Livre livre) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: livre.couleur,
      child: Text(
        livre.titre[0],
        style: const TextStyle(color: Colors.white),
      ),
    ),
    title: Text(livre.titre),
    subtitle: Text('${livre.auteur} – ${livre.annee}'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${livre.note}'),
        const SizedBox(width: 4),
        const Icon(Icons.star, color: Colors.amber, size: 18),
      ],
    ),
  );
}

// Q4.1 : carte réutilisable autour de livreTile()
class LivreCard extends StatelessWidget {
  final Livre livre;
  final VoidCallback? onTap;

  const LivreCard({super.key, required this.livre, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Q4.2
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      // Q4.3
      shadowColor: Colors.black54,
      surfaceTintColor: livre.couleur,
      // Q4.5 : l'effet d'encre respecte les coins arrondis
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: livreTile(livre),
      ),
    );
  }
}