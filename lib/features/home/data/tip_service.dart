import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:safedrive/features/home/data/tip_model.dart';

Future<List<TipAuto>> fetchTips() async {
  final response = await http.get(
      Uri.parse('https://jdu202012207.github.io/pruebas-api/tips-autos.json'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => TipAuto.fromJson(item)).toList();
  } else {
    throw Exception('Error al cargar los datos');
  }
}
