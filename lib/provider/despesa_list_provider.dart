import 'package:examen_practic/models/despesa.dart';
import 'package:examen_practic/preferences/db_preferences.dart';
import 'package:flutter/material.dart';

/// Clase dedicada a proveer la listas para cada situacion
/// Se trata de un Provider
class ScanListProvider extends ChangeNotifier {
  List<Despesa> scans = [];
  String tipusSeleccionat = 'http';

  Future<Despesa> newScan(String titol, double quantitat) async {
    final newScan = Despesa(titol: titol, quantitat: quantitat);

    final id = await DBPreferences.db.insertScan(newScan);

    newScan.id = id;

    scans.add(newScan);
    notifyListeners();

    return newScan;
  }

  carregarScans() async {
    final scans = await DBPreferences.db.getAllScans();

    this.scans = scans;

    notifyListeners();
  }

  esborrarTots() async {
    final affected = await DBPreferences.db.deleteAllScan();

    this.scans = [];

    notifyListeners();
  }

  esborrarPerId(int id) async {
    final affected = await DBPreferences.db.deleteScanById(id);

    this.scans.removeWhere(
          (element) => element.id == id,
        );

    notifyListeners();
  }
}
