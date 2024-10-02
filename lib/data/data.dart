import '../model/categorymodel.dart';

String apiKey = "IvOiTvtJFsPBqZ1f2lr3NhCNaPZNarp09OdhqFCGTG9CN9lW4K5s77p6";
List<CategoryModel> getCatogeries(){

  List<CategoryModel> categories =[];
  CategoryModel categoriesModel = new CategoryModel();

  //
  categoriesModel.imgUrl = "https://images.pexels.com/photos/1647121/pexels-photo-1647121.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoriesModel.categoriesName = "Street Art";
  categories.add(categoriesModel);
  categoriesModel = new CategoryModel();

  //
  categoriesModel.imgUrl = "https://images.pexels.com/photos/847393/pexels-photo-847393.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoriesModel.categoriesName = "Wild Life";
  categories.add(categoriesModel);
  categoriesModel = new CategoryModel();

  //
  categoriesModel.imgUrl = "https://images.pexels.com/photos/3225517/pexels-photo-3225517.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoriesModel.categoriesName = "Nature";
  categories.add(categoriesModel);
  categoriesModel = new CategoryModel();

  //
  categoriesModel.imgUrl = "https://images.pexels.com/photos/1413412/pexels-photo-1413412.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoriesModel.categoriesName = "Bikes";
  categories.add(categoriesModel);
  categoriesModel = new CategoryModel();

  //
  categoriesModel.imgUrl = "https://images.pexels.com/photos/1545743/pexels-photo-1545743.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoriesModel.categoriesName = "Car";
  categories.add(categoriesModel);
  categoriesModel = new CategoryModel();

  return categories;
}