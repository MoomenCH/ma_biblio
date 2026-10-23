import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../models/livre.dart';
import '../widgets/livre_card.dart';
import '../widgets/livre_grid_item.dart';
import 'detail_screen.dart';

class GalerieScreen extends StatefulWidget {
  const GalerieScreen({super.key});

  @override
  State<GalerieScreen> createState() => _GalerieScreenState();
}

class _GalerieScreenState extends State<GalerieScreen> {
  // Q6.6 : true = grille, false = liste
  bool _modeGrille = true;

  // Q6.5 : ouvre le détail, puis rafraîchit au retour (le cœur se met à jour)
  void _ouvrirDetail(Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(livre: livre)),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // Q6.4 : nombre de colonnes selon la largeur de l'écran
    final largeur = MediaQuery.of(context).size.width;
    final colonnes = largeur < 600 ? 2 : (largeur < 900 ? 3 : 4);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie'),
        actions: [
          // Q6.7 : tri par note décroissante
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Trier par note',
            onPressed: () {
              setState(() {
                livres.sort((a, b) => b.note.compareTo(a.note));
              });
            },
          ),
          // Q6.6 : bascule grille / liste
          IconButton(
            icon: Icon(_modeGrille ? Icons.view_list : Icons.grid_view),
            tooltip: _modeGrille ? 'Afficher en liste' : 'Afficher en grille',
            onPressed: () {
              setState(() {
                _modeGrille = !_modeGrille;
              });
            },
          ),
        ],
      ),
      body: _modeGrille
          // Q6.1 : GridView.builder (construction à la demande)
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: livres.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colonnes, // Q6.4 (pour Q6.1, mettez 2)
                childAspectRatio: 0.7,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              // Q6.3 : à tester à la place du délégué ci-dessus
              // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              //   maxCrossAxisExtent: 180,
              //   childAspectRatio: 0.7,
              //   mainAxisSpacing: 12,
              //   crossAxisSpacing: 12,
              // ),
              itemBuilder: (context, index) {
                final livre = livres[index];
                return LivreGridItem(
                  livre: livre,
                  onTap: () => _ouvrirDetail(livre),
                );
              },
            )
          // Q6.6 : mode liste
          : ListView.builder(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                final livre = livres[index];
                return LivreCard(
                  livre: livre,
                  onTap: () => _ouvrirDetail(livre),
                );
              },
            ),
    );
  }
}