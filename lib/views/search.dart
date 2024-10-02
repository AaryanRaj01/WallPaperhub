import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_maker/data/data.dart';
import 'package:wallpaper_maker/widget/widget.dart';
import 'package:http/http.dart' as http;

import '../model/wallpapermodel.dart';
class Search extends StatefulWidget {
  final String searchQuery;
  const Search({super.key,required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();


}
class _SearchState extends State<Search> {
  List<WallpaperModel> wallpaper = [];
  final TextEditingController searchcontroller = new TextEditingController();
  getSearchWallpaper(String query) async{
    var url = Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=15");
    var response = await http.get(
        url, headers: {
      "AUTHORIZATION" : apiKey
    });
    print(response.body);
    // print(response.body.toString());
    Map<String,dynamic> _jsonData = jsonDecode(response.body);
    _jsonData["photos"].forEach((element){
      //WallpaperModel wallpaperModel = new WallpaperModel();
      WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
    });

    setState(() {

    });
    print(wallpaper.length);
  }
  @override
  void initState(){
    getSearchWallpaper(widget.searchQuery);//jo udhr se idhr pass kiye hai
    super.initState();
    searchcontroller.text=widget.searchQuery;
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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xfff5f8fd)
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child:  Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                        controller: searchcontroller,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        getSearchWallpaper(searchcontroller.text);
                        },
                      child: Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              wallpapersList(wallpapers: wallpaper,context: context),
            ],
          ),
        ),
      ),
    );
  }
}
