import 'package:examen_practic/models/models.dart';
import 'package:examen_practic/preferences/db_preferences.dart';
import 'package:flutter/material.dart';

/// Clase dedicada a proveer la listas para cada situacion
/// Se trata de un Provider
class DespesaListProvider extends ChangeNotifier {
  List<Despesa> despesa = [];

  Future<Despesa> newScan(String titol, double quantitat) async {
    final newScan = Despesa(titol: titol, quantitat: quantitat);

    final id = await DBPreferences.db.insertScan(newScan);

    newScan.id = id;

    despesa.add(newScan);
    notifyListeners();

    return newScan;
  }

  carregarScans() async {
    final scans = await DBPreferences.db.getAllScans();

    this.despesa = scans;

    notifyListeners();
  }

  esborrarTots() async {
    final affected = await DBPreferences.db.deleteAllScan();

    this.despesa = [];

    notifyListeners();
  }

  esborrarPerId(int id) async {
    final affected = await DBPreferences.db.deleteScanById(id);

    this.despesa.removeWhere(
          (element) => element.id == id,
        );

    notifyListeners();
  }
}
