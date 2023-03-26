import 'package:randmealgen/models/meal_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randmealgen/repository/meal_repository.dart';

final mealProvider = FutureProvider<MealModel>((ref) {
  return MealRepo().getMeal();
});
