import 'package:flutter/material.dart';
import '../../data/models/personaje.model.dart';
import '../pages/details.page.dart';

class PersonajeCard extends StatelessWidget {
  final Personaje personaje;

  const PersonajeCard({super.key, required this.personaje});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => showDialog(
            context: context,
            builder: (_) => DetalleModal(personaje: personaje),
          ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                personaje.nombre,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text('Género: ${personaje.genero}'),
              Text('Nacimiento: ${personaje.nacimiento}'),
            ],
          ),
        ),
      ),
    );
  }
}
