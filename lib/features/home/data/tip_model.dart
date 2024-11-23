class TipAuto {
  final int id;
  final String imagen;
  final String contenido;

  TipAuto({required this.id, required this.imagen, required this.contenido});

  factory TipAuto.fromJson(Map<String, dynamic> json) {
    return TipAuto(
      id: json['id'],
      imagen: json['imagen'],
      contenido: json['contenido'],
    );
  }
}
