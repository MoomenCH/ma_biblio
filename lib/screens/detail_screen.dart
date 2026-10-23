import 'package:flutter/material.dart';
import '../models/livre.dart';

// Q4.8 : StatefulWidget, car le bouton favoris change l'affichage
class DetailScreen extends StatefulWidget {
  final Livre livre;

  const DetailScreen({super.key, required this.livre});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final livre = widget.livre;

    return Scaffold(
      appBar: AppBar(title: Text(livre.titre)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // En-tête coloré de 200 px
              Container(
                height: 200,
                width: double.infinity,
                color: livre.couleur,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Text(
                  livre.titre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Trois ListTile
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Auteur'),
                subtitle: Text(livre.auteur),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Année'),
                subtitle: Text('${livre.annee}'),
              ),
              ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Genre'),
                subtitle: Text(livre.genre),
              ),

              // Rangée de boutons
              Padding(
                padding: const EdgeInsets.all(8),
                child: OverflowBar(
                  alignment: MainAxisAlignment.end,
                  spacing: 8,
                  children: [
                    TextButton.icon(
                      icon: Icon(
                        livre.favori
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      label: const Text('Ajouter aux favoris'),
                      onPressed: () {
                        setState(() {
                          livre.favori = !livre.favori;
                        });
                      },
                    ),
                    TextButton.icon(
                      icon: Icon(
                        livre.lu
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                      ),
                      label: const Text('Marquer comme lu'),
                      onPressed: () {
                        setState(() {
                          livre.lu = !livre.lu;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}