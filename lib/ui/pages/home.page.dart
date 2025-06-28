import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/personaje.controller.dart';
import '../widgets/personaje_card.dart';
import '../widgets/appbar.dart';
import '../widgets/app_drawer.dart';
import './Busqueda.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_detectarScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ControladorPersonajes>().cargarPersonajes();
    });
  }

  void _detectarScroll() {
    final controller = context.read<ControladorPersonajes>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !controller.cargandoMas) {
      controller.cargarMas();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ControladorPersonajes>();

    if (controller.estaCargando && controller.lista.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (controller.error != null) {
      return Scaffold(body: Center(child: Text(controller.error!)));
    }

    return Scaffold(
      appBar: const SwAppBar(),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (texto) {
                final textoLimpio = texto.trim();
                if (textoLimpio.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BusquedaPage(textoBusqueda: textoLimpio),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: controller.lista.length,
                itemBuilder: (context, index) {
                  final personaje = controller.lista[index];
                  return PersonajeCard(personaje: personaje);
                },
              ),
            ),
            if (controller.cargandoMas)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
