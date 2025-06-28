import 'package:swapi_app/data/models/personaje.model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ServicioBusquedaPersonaje {
  Future<List<Personaje>> buscarPersonajesPorNombre(String texto) async {
    final url = Uri.parse('https://swapi.info/api/people?search=$texto');
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final jsonData = json.decode(respuesta.body);
      return List<Map<String, dynamic>>.from(
        jsonData['results'],
      ).map((e) => Personaje.desdeJson(e)).toList();
    } else {
      throw Exception('Error al buscar personajes');
    }
  }
}
