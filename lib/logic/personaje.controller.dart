import 'package:flutter/material.dart';
import '../data/models/personaje.model.dart';
import '../data/services/swapi.service.dart';

class ControladorPersonajes extends ChangeNotifier {
  final List<Personaje> _lista = [];
  bool _cargando = false;
  bool _cargandoMas = false;
  int _pagina = 1;
  String? _error;

  List<Personaje> get lista => _lista;
  bool get estaCargando => _cargando;
  bool get cargandoMas => _cargandoMas;
  String? get error => _error;

  Future<void> cargarPersonajes() async {
    _cargando = true;
    _error = null;
    notifyListeners();
    try {
      final nuevos = await ServicioSwapi().obtenerPersonajes(pagina: _pagina);
      _lista.addAll(nuevos);
    } catch (e) {
      _error = 'Error al cargar personajes';
      print(e);
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<void> cargarMas() async {
    if (_cargandoMas) return;
    _cargandoMas = true;
    _pagina++;
    notifyListeners();
    try {
      final nuevos = await ServicioSwapi().obtenerPersonajes(pagina: _pagina);
      _lista.addAll(nuevos);
    } catch (_) {
      _pagina--; // rollback si falla
    }
    _cargandoMas = false;
    notifyListeners();
  }
}
