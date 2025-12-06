import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livetest/recipe_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> recipes = [];

  Future<void> loadRecipeData() async {
    final String jsonUrl = await rootBundle.loadString('assets/recipes.json');
    final responseData = jsonDecode(jsonUrl);
    setState(() {
      recipes = responseData['recipes'];
    });
  }

  @override
  void initState() {
    super.initState();
    loadRecipeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe List')),
      body: recipes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(Icons.palette_outlined),
                    title: Text(recipe.title),
                    subtitle: Text(recipe.description),
                  ),
                );
              },
            ),
    );
  }
}
