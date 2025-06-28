import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/personaje.model.dart';

class ServicioSwapi {
  Future<List<Personaje>> obtenerPersonajes({int pagina = 1}) async {
    final url = Uri.parse('https://swapi.info/api/people?page=$pagina');
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final List<dynamic> lista = json.decode(respuesta.body);
      return lista.map((e) => Personaje.desdeJson(e)).toList();
    } else {
      throw Exception('Error al obtener personajes');
    }
  }

  Future<Personaje> obtenerDetalle(String url) async {
    final uri = Uri.parse(url);
    final respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      final data = json.decode(respuesta.body);
      return Personaje.desdeJson(data);
    } else {
      throw Exception('Error al obtener el personaje');
    }
  }
}
