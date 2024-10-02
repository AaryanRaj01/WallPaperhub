import 'package:flutter/material.dart';
import 'package:wallpaper_maker/views/image_screen.dart';

import '../model/wallpapermodel.dart';

Widget brandName() {
  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontSize: 16,
         fontWeight: FontWeight.w500,
      ),
      children: const <TextSpan>[
        TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black)),
        TextSpan(text: 'Hub',style: TextStyle(color: Colors.blue)),
      ],
    ),
  );
}

Widget wallpapersList(
    {required List<WallpaperModel> wallpapers, required context}) {
  return Container(
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: ClampingScrollPhysics(),
      childAspectRatio: 0.6,
      //image is rectangular
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ImageScreen(ImgUrl: wallpaper.src.portrait)));
              },
              child: Hero(
                tag:wallpaper.src.portrait,
                child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          wallpaper.src.portrait,
                          fit: BoxFit.cover,
                        ))),
              ),
            ));
      }).toList(),
    ),
  );
}
