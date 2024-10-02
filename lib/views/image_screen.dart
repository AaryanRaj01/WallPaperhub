import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageScreen extends StatefulWidget {
  final String ImgUrl;
  const ImageScreen({required this.ImgUrl});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  var filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag:widget.ImgUrl,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.ImgUrl,fit: BoxFit.cover,)),
          ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  save();
               },
                child: Stack(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width/2,
                         height:55,
                         color: Color(0xff1C1B1B).withOpacity(0.8),
                    ),
                    Container(
                      height:55,
                      width: MediaQuery.of(context).size.width/2,
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54,width: 1),
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(colors: [
                            Color(0x36FFFFFF),
                            Color(0x0FFFFFFF),
                          ])
                      ),
                      child: Column(
                        children: [
                          Text("Set Wallpaper",style: TextStyle(
                            fontSize: 16,color: Colors.white70
                          ),),
                          Text("Image will be saved in gallery",style: TextStyle(fontSize: 10,color: Colors.white70),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Text("Cancel",style: TextStyle(color: Colors.white70,)),
              SizedBox(height: 50,)
            ],
          ),
        )
        ],
      ),
    );
  }

  Future<void> save() async {
    await _askPermission(); // Request permission
    var response = await Dio().get(
      widget.ImgUrl, // Image path
      options: Options(responseType: ResponseType.bytes), // Getting bytes for the image
    );

    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data)); // Save the image
    print(result);
    Navigator.pop(context);
  }

  Future<void> _askPermission() async {
    if(Platform.isAndroid){
      await _askPermission();
    }
    if (Platform.isIOS) {
      // Request photo permission for iOS
      PermissionStatus status = await Permission.photos.request();
      if (!status.isGranted) {
        // Handle if permission is denied
        return;
      }
    } else {
      // Request storage permission for Android
      PermissionStatus status = await Permission.storage.request();
      if (!status.isGranted) {
        // Handle if permission is denied
        return;
      }
    }
  }
}
