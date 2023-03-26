import 'dart:convert';

import 'package:randmealgen/models/meal_model.dart';
import 'package:http/http.dart' as http;

class MealRepo {
  Future<MealModel> getMeal() async {
    String url = "https://www.themealdb.com/api/json/v1/1/random.php";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    return MealModel.fromJson(jsonDecode(response.body));
  }
}
