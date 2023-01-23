import 'package:meta/meta.dart';
import 'dart:convert';

class Despesa {
  Despesa({
    this.id,
    required this.titol,
    required this.quantitat,
  });

  int? id;
  String titol;
  double quantitat;

  factory Despesa.fromJson(String str) => Despesa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Despesa.fromMap(Map<String, dynamic> json) => Despesa(
        id: json["id"],
        titol: json["titol"],
        quantitat: json["quantitat"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "titol": titol,
        "quantitat": quantitat,
      };
}
