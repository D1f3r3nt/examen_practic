import 'package:shared_preferences/shared_preferences.dart';

/// Clase dedicada a tratar los datos de la memoria
class Preferences {
  static late SharedPreferences _prefs;

  static bool _logueado = false;

  /// Clase para iniciar el preferences
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Creamos getter para asi realizar la consulta a la vez,
  /// en caso de no estar guardado devolvemos el valor por defecto
  static bool get logueado {
    return _prefs.getBool('logueado') ?? _logueado;
  }

  /// Creamos setter para asi guardar la informacion a la vez
  static set logueado(bool value) {
    _prefs.setBool('logueado', value);
  }
}
