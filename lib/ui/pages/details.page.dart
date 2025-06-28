import 'package:flutter/material.dart';
import '../../data/models/personaje.model.dart';
import '../../data/services/swapi.service.dart';
import '../../data/services/favs.service.dart';
import '../widgets/personaje_card.dart';

class DetalleModal extends StatefulWidget {
  final Personaje personaje;
  const DetalleModal({super.key, required this.personaje});

  @override
  State<DetalleModal> createState() => _DetalleModalState();
}

class _DetalleModalState extends State<DetalleModal> {
  late Future<bool> _enFavoritosFuture;

  @override
  void initState() {
    super.initState();
    _enFavoritosFuture = ServicioFavoritos().estaEnFavoritos(
      widget.personaje.nombre,
    );
  }

  void _alternarFavorito(Personaje personaje) async {
    await ServicioFavoritos().alternarFavorito(personaje);
    setState(() {
      _enFavoritosFuture = ServicioFavoritos().estaEnFavoritos(
        personaje.nombre,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final esAncho = MediaQuery.of(context).size.width > 800;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: FutureBuilder<Personaje>(
          future: ServicioSwapi().obtenerDetalle(widget.personaje.url),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final personaje = snap.data!;

            final info = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  personaje.nombre,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text('Género: ${personaje.genero}'),
                Text('Nacimiento: ${personaje.nacimiento}'),
                Text('Altura: ${personaje.altura}'),
                Text('Peso: ${personaje.peso}'),
              ],
            );

            return Stack(
              children: [
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(child: info),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FutureBuilder<bool>(
                    future: _enFavoritosFuture,
                    builder: (context, snapshot) {
                      final enFavoritos = snapshot.data ?? false;
                      return FloatingActionButton(
                        backgroundColor: enFavoritos ? Colors.red : Colors.grey,
                        tooltip:
                            enFavoritos
                                ? 'Quitar de favoritos'
                                : 'Agregar a favoritos',
                        onPressed: () => _alternarFavorito(personaje),
                        child: Icon(
                          enFavoritos ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
