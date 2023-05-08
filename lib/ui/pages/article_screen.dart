import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:vitaflow/core/models/article/article_model.dart';
import 'package:vitaflow/core/viewmodels/article/article_provider.dart';
import 'package:vitaflow/core/viewmodels/connection/connection.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/loading/LoadingSingleBox.dart';
import 'package:vitaflow/ui/widgets/news_item.dart';
import 'package:vitaflow/ui/widgets/top_bar.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ChangeNotifierProvider(
            create: (create) => ArticleProvider(),
            child: const ArticleScreenBody()));
  }
}

class ArticleScreenBody extends StatelessWidget {
  const ArticleScreenBody({Key? key}) : super(key: key);

  Future<void> refreshHome(BuildContext context) async {
    final articles = ArticleProvider.instance(context);

    articles.clearArticles();

    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionProvider>(builder: (context, connectionProv, _) {
      if (connectionProv.internetConnected == false) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Tidak Ada Koneksi Internet"),
              ElevatedButton(
                onPressed: () => refreshHome(context),
                child: const Text("Refresh"),
              )
            ],
          ),
        );
      }

      return SafeArea(
        child: RefreshIndicator(
          onRefresh: () => refreshHome(context),
          child: Column(
            children: [
              const MainTopBar(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defMargin),
                      child: Text(
                        'Vita Insight',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: headerSize),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    _MainArticleListWidget(),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(defMargin),
                      child: Text(
                        'Artikel Minggu Ini',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: headerSize),
                      ),
                    ),
                    _ArticleTheWeek(),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class _MainArticleListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder: (context, articleProv, _) {
        if (articleProv.newestArticles == null && !articleProv.onSearch) {
          // get categories provider
          articleProv.getArticles();
          // if the categories haven't been loaded yet, show a skeleton loading
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const LoadingSingleBox(),
          );
        } else if (articleProv.newestArticles == null && articleProv.onSearch) {
          // if the categories are being searched, show a skeleton loading
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const LoadingSingleBox(),
          );
        }
        if (articleProv.newestArticles!.isEmpty) {
          // if the categories have been loaded, show the category chips
          return Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text('Tidak ada Artikel ditemukan'),
            ),
          );
        }
        return CarouselSlider(
          options: CarouselOptions(
            height: 25.h,
            viewportFraction: 0.9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
          items: articleProv.newestArticles?.map((value) {
            return Builder(
              builder: (BuildContext context) {
                return NewsBanner(article: value);
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class NewsBanner extends StatelessWidget {
  const NewsBanner({
    super.key,
    required this.article,
  });

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defRadius),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(defRadius),
              child: Image.network(
                'https://freshmart.oss-ap-southeast-5.aliyuncs.com/images/images/${article.image}',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Positioned(
                child: Container(
              margin: EdgeInsets.all(1.5.h),
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 0.5.h),
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(defMargin)),
              child: Text(
                'Category ',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: captionSize),
              ),
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 10.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(defRadius),
                        bottomRight: Radius.circular(defRadius)),
                    gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black87,
                          Colors.black54,
                          Colors.black12,
                          Colors.transparent
                        ])),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.all(1.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${article.readingTime} menit baca',
                      style: GoogleFonts.poppins(
                          fontSize: captionSize, color: Colors.white),
                    ),
                    Text(
                      article.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class _ArticleTheWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder: (context, articleProv, _) {
        if (articleProv.articles == null && !articleProv.onSearch) {
          // get categories provider
          articleProv.getArticles();
          // if the categories haven't been loaded yet, show a skeleton loading
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const LoadingArticle(),
          );
        } else if (articleProv.articles == null && articleProv.onSearch) {
          // if the categories are being searched, show a skeleton loading
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const LoadingArticle(),
          );
        }
        if (articleProv.articles!.isEmpty) {
          // if the categories have been loaded, show the category chips
          return Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text('Tidak ada Artikel ditemukan'),
            ),
          );
        }
        return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: articleProv.articles!.length,
            itemBuilder: (c, i) {
              return NewsItem(
                article: articleProv.articles![i],
              );
            });
      },
    );
  }
}
