import 'package:flutter/material.dart';
import '../../data/models/personaje.model.dart';

class PersonajeCard extends StatelessWidget {
  final Personaje personaje;

  const PersonajeCard({super.key, required this.personaje});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(personaje.nombre),
        subtitle: Text(
          'Género: ${personaje.genero} • Nacimiento: ${personaje.nacimiento}',
        ),
      ),
    );
  }
}
