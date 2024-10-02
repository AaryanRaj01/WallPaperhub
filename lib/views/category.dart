import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';
import '../model/wallpapermodel.dart';
import '../widget/widget.dart';

class Categorie extends StatefulWidget {
  final String CategorieName;
  const Categorie({required this.CategorieName});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

  List<WallpaperModel> wallpaper = [];
  getSearchWallpaper(String query) async {
    var url = Uri.parse(
        "https://api.pexels.com/v1/search?query=$query&per_page=15");
    var response = await http.get(
        url, headers: {
      "AUTHORIZATION": apiKey
    });
    print(response.body);
    // print(response.body.toString());
    Map<String, dynamic> _jsonData = jsonDecode(response.body);
    _jsonData["photos"].forEach((element) {
      //WallpaperModel wallpaperModel = new WallpaperModel();
      WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
    });
  }

    @override
  void initState() {
    // TODO: implement initState
      getSearchWallpaper(widget.CategorieName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20,),
              wallpapersList(wallpapers: wallpaper,context: context),
            ],
          ),
        ),
      ),
    );
  }
}
