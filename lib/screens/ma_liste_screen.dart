import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../models/livre.dart';

// Q3.1 : StatefulWidget, car l'écran change quand on coche une case
class MaListeScreen extends StatefulWidget {
  const MaListeScreen({super.key});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  // Q3.2
  bool _nouveautesSeulement = false;

  // Q3.3 : les 5 genres, tous cochés au départ
  final Map<String, bool> _genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Jeunesse': true,
    'Informatique': true,
  };

  // Q3.4 : une icône par genre
  final Map<String, IconData> _icones = {
    'Roman': Icons.menu_book,
    'Science': Icons.science,
    'Histoire': Icons.history_edu,
    'Jeunesse': Icons.child_care,
    'Informatique': Icons.computer,
  };

  // Q3.5 : true = tous cochés, false = aucun, null = mélange (tiret)
  bool? get _tousValeur {
    final valeurs = _genres.values;
    if (valeurs.every((v) => v)) return true;
    if (valeurs.every((v) => !v)) return false;
    return null;
  }

  // Q3.6 : livres filtrés par genres cochés (et nouveautés si demandé)
  List<Livre> get _livresAffiches {
    return livres.where((l) {
      final genreOk = _genres[l.genre] ?? false;
      final nouveauteOk = !_nouveautesSeulement || l.nouveaute;
      return genreOk && nouveauteOk;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final affiches = _livresAffiches;
    final nbLus = affiches.where((l) => l.lu).length;

    return Scaffold(
      appBar: AppBar(
        // Q3.7 : compteur dynamique
        title: Text('Lus : $nbLus / ${affiches.length}'),
      ),
      body: ListView(
        children: [
          // Q3.2
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (valeur) {
              setState(() {
                _nouveautesSeulement = valeur ?? false;
              });
            },
          ),
          const Divider(),

          // Q3.5 : « Tous les genres » à trois états
          CheckboxListTile(
            title: const Text('Tous les genres'),
            tristate: true,
            value: _tousValeur,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (_) {
              setState(() {
                final nouvelleValeur = _tousValeur != true;
                for (final genre in _genres.keys) {
                  _genres[genre] = nouvelleValeur;
                }
              });
            },
          ),

          // Q3.3 + Q3.4 : cases générées depuis la map
          ..._genres.keys.map((genre) {
            final nbLivres = livres.where((l) => l.genre == genre).length;
            return CheckboxListTile(
              secondary: Icon(_icones[genre]),
              title: Text(genre),
              subtitle: Text('$nbLivres livres'),
              activeColor: Colors.indigo,
              controlAffinity: ListTileControlAffinity.leading,
              value: _genres[genre],
              onChanged: (valeur) {
                setState(() {
                  _genres[genre] = valeur ?? false;
                });
              },
            );
          }),
          const Divider(thickness: 2),

          // Q3.6 : liste filtrée avec cases « lu »
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: affiches.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final livre = affiches[index];
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: livre.lu,
                title: Text(
                  livre.titre,
                  style: TextStyle(
                    decoration:
                        livre.lu ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text('${livre.auteur} – ${livre.annee}'),
                onChanged: (valeur) {
                  setState(() {
                    livre.lu = valeur ?? false;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}