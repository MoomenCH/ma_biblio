import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import '../models/livre.dart';

// Fichier de sauvegarde dans le dossier de l'application
Future<File> _fichierLocal() async {
  final dossier = await getApplicationDocumentsDirectory();
  return File('${dossier.path}/mabiblio.json');
}

List<Livre> _decoder(String contenu) {
  final liste = jsonDecode(contenu) as List<dynamic>;
  return liste
      .map((e) => Livre.fromJson(e as Map<String, dynamic>))
      .toList();
}

// Q7.4 + Q7.8 : lit mabiblio.json s'il existe, sinon l'asset d'origine
Future<List<Livre>> chargerLivres() async {
  if (!kIsWeb) {
    final fichier = await _fichierLocal();
    if (await fichier.exists()) {
      return _decoder(await fichier.readAsString());
    }
  }
  final contenu = await rootBundle.loadString('assets/livres.json');
  return _decoder(contenu);
}

// Q7.7 : écrit la liste dans mabiblio.json (ignoré sur le web)
Future<void> sauvegarderLivres(List<Livre> livres) async {
  if (kIsWeb) return;
  final fichier = await _fichierLocal();
  final texte = jsonEncode(livres.map((l) => l.toJson()).toList());
  await fichier.writeAsString(texte);
}

// Q7.10 : supprime la sauvegarde
Future<void> reinitialiserLivres() async {
  if (kIsWeb) return;
  final fichier = await _fichierLocal();
  if (await fichier.exists()) {
    await fichier.delete();
  }
}