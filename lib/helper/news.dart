import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/article_view.dart';
import 'package:http/http.dart' as http;

import 'article_model.dart';

class News{
  List<ArticleModel> news = [];

Future<void> getNews(BuildContext context) async{
  String url =
      "https://newsapi.org/v2/top-headlines?country=hk&category=business&apiKey=40560e18118a455d8d24617c82ba7b9d";

  var response = await http.get(Uri.parse(url));

  var jsondata = jsonDecode(response.body);


  try{
    if(jsondata["status"] == "ok"){
      jsondata["articles"].forEach((element){

        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element["content"],

          );

          news.add(articleModel);
        }
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsondata["status"])));
    }
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));


  }

}




}

class CategoryNewsClass{
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async{
    String url = "https://newsapi.org/v2/top-headlines?category=$category&country=hk&category=business&apiKey=40560e18118a455d8d24617c82ba7b9d";

    var response = await http.get(Uri.parse( url));

    var jsondata = jsonDecode(response.body);

    if(jsondata["status"] == "ok"){
      jsondata["articles"].forEach((element){

        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element["content"],

          );

          news.add(articleModel);
        }
      });
    }

  }




}