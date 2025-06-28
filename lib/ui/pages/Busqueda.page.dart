import 'package:flutter/material.dart';
import '../../data/models/personaje.model.dart';
import '../../data/services/swapi.service.dart';
import '../widgets/personaje_card.dart';
import '../widgets/appbar.dart';
import '../widgets/app_drawer.dart';

class BusquedaPage extends StatelessWidget {
  final String textoBusqueda;
  const BusquedaPage({super.key, required this.textoBusqueda});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SwAppBar(),
      drawer: const AppDrawer(),
      body: FutureBuilder<List<Personaje>>(
        future: ServicioSwapi().buscarPersonajes(textoBusqueda),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final resultados = snapshot.data ?? [];

          if (resultados.isEmpty) {
            return const Center(child: Text('No se encontraron personajes.'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: resultados.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return PersonajeCard(personaje: resultados[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
