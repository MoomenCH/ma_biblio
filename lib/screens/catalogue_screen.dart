import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../widgets/livre_card.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Q2.7 : seulement les livres marqués nouveauté
    final nouveautes = livres.where((l) => l.nouveaute).toList();

    // Q2.8 : Column avec titre, liste horizontale, titre, liste verticale
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Nouveautés',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        // Q2.7 : ListView horizontal de 160 px de haut
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: nouveautes.length,
            itemBuilder: (context, index) {
              final livre = nouveautes[index];
              return Container(
                width: 110,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: livre.couleur,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  livre.titre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Tout le catalogue',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        // Q2.4 + Q2.6 + Q2.8 : liste verticale dans un Expanded
        Expanded(
          child: ListView.separated(
            itemCount: livres.length,
            itemBuilder: (context, index) => livreTile(livres[index]),
            // Q2.6 : séparateur indenté de 72 px (aligné après l'avatar)
            separatorBuilder: (context, index) => const Divider(indent: 72),
          ),
        ),
      ],
    );
  }
}