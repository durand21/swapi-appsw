import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/personaje.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicioFavoritos {
  CollectionReference get favoritosRef {
    final usuario = FirebaseAuth.instance.currentUser;
    final uid = usuario?.uid ?? 'anonimo';
    return FirebaseFirestore.instance.collection('favoritos_$uid');
  }

  Future<List<Personaje>> obtenerFavoritos() async {
    final snapshot = await favoritosRef.get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      return Personaje(
        nombre: data['name'],
        url: data['url'],
        genero: data['gender'],
        nacimiento: data['birth_year'],
        altura: data['height'],
        peso: data['mass'],
      );
    }).toList();
  }

  Future<bool> estaEnFavoritos(String nombre) async {
    final doc = await favoritosRef.doc(nombre).get();
    return doc.exists;
  }

  Future<void> alternarFavorito(Personaje personaje) async {
    final ref = favoritosRef.doc(personaje.nombre);
    final existe = await ref.get();
    if (existe.exists) {
      await ref.delete(); // quitar de favoritos
    } else {
      await ref.set({
        'name': personaje.nombre,
        'url': personaje.url,
        'gender': personaje.genero,
        'birth_year': personaje.nacimiento,
        'height': personaje.altura,
        'mass': personaje.peso,
      }); // agregar a favoritos
    }
  }
}
