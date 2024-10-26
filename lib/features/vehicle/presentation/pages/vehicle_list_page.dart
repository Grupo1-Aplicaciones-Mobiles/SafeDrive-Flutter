import 'package:flutter/material.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_model.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_service.dart';
import 'package:safedrive/features/vehicle/presentation/pages/add_vehicle_page.dart';
import 'package:safedrive/features/vehicle/presentation/pages/vehicle_detail_page.dart';
import 'package:safedrive/features/vehicle/presentation/widgets/vehicle_list_item.dart';

class VehicleListPage extends StatefulWidget {
  const VehicleListPage({super.key});

  @override
  State<VehicleListPage> createState() => _VehicleListPageState();
}

class _VehicleListPageState extends State<VehicleListPage> {
  List<VehicleModel> _vehicles = [];

  Future<void> _loadData() async {
    List<VehicleModel> vehicles = await VehicleService().getVehicles();
    print('vehicles: $vehicles');
    setState(() {
      _vehicles = vehicles;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Vehículos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddVehiclePage(),
                        ),
                      );
                      if (result == true) {
                        _loadData(); // Recarga los datos si se agregó un vehículo
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _vehicles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VehicleDetailPage(
                            vehicleModel: _vehicles[index],
                          ),
                        ),
                      );
                    },
                    child: VehicleListItem(vehicleModel: _vehicles[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
