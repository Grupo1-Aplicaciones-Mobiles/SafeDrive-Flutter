import 'package:flutter/material.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_model.dart';

class VehicleListItem extends StatelessWidget {
  const VehicleListItem({super.key, required this.vehicleModel});
  final VehicleModel vehicleModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vehicleModel.marca,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
                child: ClipOval(
                  child: Hero(
                    tag: vehicleModel.id ?? vehicleModel.hashCode,
                    child: Image.network(
                      vehicleModel.imageUri,
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('Modelo: ${vehicleModel.modelo}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('Color: ${vehicleModel.color}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('Placa: ${vehicleModel.placa}'),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
