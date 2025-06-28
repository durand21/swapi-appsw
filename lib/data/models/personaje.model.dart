class Personaje {
  final String nombre;
  final String url;
  final String genero;
  final String nacimiento;
  final String? altura;
  final String? peso;

  const Personaje({
    required this.nombre,
    required this.url,
    required this.genero,
    required this.nacimiento,
    this.altura,
    this.peso,
  });

  factory Personaje.desdeJson(Map<String, dynamic> json) {
    return Personaje(
      nombre: json['name'] ?? 'Desconocido',
      url: json['url'] ?? '',
      genero: json['gender'] ?? 'desconocido',
      nacimiento: json['birth_year'] ?? 'desconocido',
      altura: json['height'],
      peso: json['mass'],
    );
  }
}
