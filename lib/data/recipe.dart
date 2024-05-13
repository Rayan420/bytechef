import 'dart:io';
import 'dart:typed_data';

import 'package:bytechef/data/user.dart';
import 'package:flutter/foundation.dart';

class Recipe {
  final String name;
  final Uint8List? image;
  final Uint8List? video;
  final String videoUrl;
  final String imageUrl;
  final String duration;
  final String serving;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  final String id = DateTime.now().millisecondsSinceEpoch.toString();
  final User owner;
  final int views;
  final double rating;
  final Map<String, User> reviews = {};
  final int searchCount;
  final List<String> category;

  Recipe({
    required this.name,
    required this.duration,
    required this.serving,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.image,
    required this.owner,
    required this.video,
    required this.videoUrl,
    required this.imageUrl,
    required this.rating,
    required this.views,
    required this.searchCount,
    required this.category,
  });

  //from json
  Recipe.fromJson(Map<String, dynamic> json, User owner)
      : name = json['name'],
        image = json['image'],
        video = json['video'],
        videoUrl = json['videoUrl'],
        imageUrl = json['imageUrl'],
        duration = json['duration'],
        rating = json['rating'],
        views = json['views'],
        serving = json['serving'],
        description = json['description'],
        ingredients = List<String>.from(json['ingredients']),
        searchCount = json['searchCount'],
        steps = List<String>.from(json['steps']),
        category = List<String>.from(json['category']),
        owner = owner;
}
