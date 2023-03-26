// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_null_comparison, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randmealgen/models/meal_model.dart';
import 'package:randmealgen/providers/meal_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class recipeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<MealModel> meal = ref.watch(mealProvider);
    return SafeArea(
      child: Scaffold(
          body: meal.when(
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              error: (error, stack) => Center(
                    child: Text(error.toString()),
                  ),
              data: (recipe) {
                recipe.ingredients.removeWhere(
                    (element) => element.name == null || element.name == "");
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  recipe.image,
                                ),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Chip(
                                        backgroundColor: Colors.yellow,
                                        label: Container(
                                          child: Center(
                                            child: Text(
                                              recipe.category,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Chip(
                                          backgroundColor: Colors.orange,
                                          label: Container(
                                            child: Center(
                                              child: Text(
                                                recipe.area,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  15),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (recipe.youtubeUrl != "") {
                                          await launchUrl(
                                              Uri.parse(recipe.youtubeUrl));
                                        }
                                      },
                                      child: const Text('YOUTUBE',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)))
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                'INGREDIENTS :',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      recipe.ingredients.map((ingredient) {
                                    return Column(
                                      children: [
                                        Image(
                                          height: 150,
                                          width: 150,
                                          image: NetworkImage(
                                              'https://www.themealdb.com/images/ingredients/${ingredient.name}.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          ingredient.name,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ingredient.measure,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        )
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                'PROCEDURE :',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                recipe.instructions,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
