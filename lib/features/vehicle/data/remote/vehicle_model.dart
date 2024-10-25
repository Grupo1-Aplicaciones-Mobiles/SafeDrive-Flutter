class VehicleModel {
  final int? id;
  final String marca;
  final String modelo;
  final String color;
  final String placa;
  final String imageUri;

  VehicleModel(
      {this.id,
      required this.marca,
      required this.modelo,
      required this.color,
      required this.placa,
      required this.imageUri});

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      marca: json['marca'] ?? '',
      modelo: json['modelo'] ?? '',
      color: json['color'] ?? '',
      placa: json['placa'] ?? '',
      imageUri: json['imagen'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'marca': marca,
      'modelo': modelo,
      'color': color,
      'placa': placa,
      'imagen': imageUri,
    };
  }
}
