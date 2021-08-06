import 'package:flutter/material.dart';
import 'package:newsapp/article_view.dart';
import 'package:newsapp/helper/article_model.dart';
import 'helper/news.dart';
import 'home.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({Key? key, required this.category}) : super(key: key);
  final String category;


  @override

  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {

    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "ShingJai"),
                TextSpan(text:
                "News",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            )

        ),

        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
            child: Container(
        child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BlogTile(
                        imageUrl: articles[index].urlToImage!,
                        title: articles[index].title!,
                        desc: articles[index].description!,
                        url: articles[index].url!,
                      );
                    }),
              )
            ],
        ),
      ),
          ),
    );
  }
}

