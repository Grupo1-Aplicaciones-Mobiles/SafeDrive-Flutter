class VehicleModel {
  final int? id;
  final String marca;
  final String modelo;
  final String color;
  final String placa;
  final String imageUri;
  final double latitude;
  final double longitude;

  VehicleModel(
      {this.id,
      required this.marca,
      required this.modelo,
      required this.color,
      required this.placa,
      required this.imageUri,
      required this.latitude,
      required this.longitude});

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      marca: json['marca'] ?? '',
      modelo: json['modelo'] ?? '',
      color: json['color'] ?? '',
      placa: json['placa'] ?? '',
      imageUri: json['imagen'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'marca': marca,
      'modelo': modelo,
      'color': color,
      'placa': placa,
      'imagen': imageUri,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
