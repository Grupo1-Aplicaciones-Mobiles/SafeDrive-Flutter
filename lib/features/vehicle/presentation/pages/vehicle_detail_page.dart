import 'package:flutter/material.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_model.dart';

class VehicleDetailPage extends StatelessWidget {
  const VehicleDetailPage({super.key, required this.vehicleModel});
  final VehicleModel vehicleModel;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: height * 0.40,
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: vehicleModel.id ?? vehicleModel.hashCode,
                    child: Image.network(
                      height: height * 0.40,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      vehicleModel.imageUri,
                    ),
                  ),
                ),
              )
            ];
          },
          body: Column(
            children: [Text(vehicleModel.marca)],
          )),
    );
  }
}
