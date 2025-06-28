import 'package:flutter/material.dart';
import '../../data/models/personaje.model.dart';
import '../widgets/personaje_card.dart';
import '../widgets/app_drawer.dart';
import '../../data/services/favs.service.dart';
import '../widgets/appbar.dart';
import '../widgets/shimmer_card.dart';

class PaginaFavoritos extends StatelessWidget {
  const PaginaFavoritos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SwAppBar(),
      drawer: const AppDrawer(),
      body: FutureBuilder<List<Personaje>>(
        future: ServicioFavoritos().obtenerFavoritos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) => const ShimmerCard(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final favoritos = snapshot.data!;
          if (favoritos.isEmpty) {
            return const Center(child: Text('No hay favoritos aún.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: favoritos.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              return PersonajeCard(personaje: favoritos[index]);
            },
          );
        },
      ),
    );
  }
}
