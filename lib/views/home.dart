import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_maker/data/data.dart';
import 'package:wallpaper_maker/model/wallpapermodel.dart';
import 'package:wallpaper_maker/views/category.dart';
import 'package:wallpaper_maker/views/image_screen.dart';
import 'package:wallpaper_maker/views/search.dart';
import 'package:wallpaper_maker/widget/widget.dart';
import 'package:http/http.dart' as http;
import '../model/categorymodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<CategoryModel> categories = [];
  List<WallpaperModel> wallpaper = [];
  final TextEditingController searchcontroller = new TextEditingController();

  getTrendingPhotos() async{
    var url = Uri.parse("https://api.pexels.com/v1/curated?per_page=50");
    var response = await http.get(
        url, headers: {
          "AUTHORIZATION" : apiKey
    });
   // print(response.body.toString());
    Map<String,dynamic> _jsonData = jsonDecode(response.body);
    _jsonData["photos"].forEach((element){
      //WallpaperModel wallpaperModel = new WallpaperModel();
      WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
    });

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getTrendingPhotos();
    categories = getCatogeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchQuery: searchcontroller.text,)) );
                      },
                      child: Icon(Icons.search),
                    ),
                  ],
                ),
              ),
        
              SizedBox(height: 16,),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.10,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CatgorieTile(imgUrl: categories[index].imgUrl,
                        title: categories[index].categoriesName);
                  },
                  itemCount: categories.length,),
              ),
              wallpapersList(wallpapers: wallpaper,context: context),
            ],
          ),
        ),
      ),

    );
  }
}

class CatgorieTile extends StatelessWidget {

  final String imgUrl;
  final String title;

  CatgorieTile({required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => Categorie(CategorieName: title.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imgUrl, height: 50, width: 100, fit: BoxFit.cover,),
            ),
            Container(
              // color: Colors.black12,
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(title, style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),),
            )
          ],
        ),
      ),
    );
  }
}


