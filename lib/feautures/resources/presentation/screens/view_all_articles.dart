import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/feautures/resources/domain/entities/article_entity.dart';
import 'package:startup/feautures/resources/presentation/providers/article_providers.dart';
import 'package:startup/feautures/resources/presentation/screens/article_content.dart';

class ViewAllArticles extends ConsumerWidget {
  const ViewAllArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final articles = ref.watch(articlesProvider);

    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFEEEEEE),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffEEEEEE),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            title:  Text("Articles",style: AppTextStyles.font_poppins.copyWith(fontSize: 20,fontWeight: FontWeight.w400),),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16,),
                Container(
                  child: articles.when(
                    data: (articles){
                    return Expanded(
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 12),
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            ArticleEntity article = articles[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ArticleContent(article: article)),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffF0F0F0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xffCCCCCC),// Shadow color
                                      spreadRadius: 0, // Spread radius
                                      blurRadius: 5, // Blur radius
                                      offset: Offset(0, 2), // Offset of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(article.title, style: AppTextStyles.font_poppins.copyWith(fontSize: 18,fontWeight: FontWeight.w700),),
                                          SizedBox(height: 6),
                                          Text(article.content, style: AppTextStyles.font_lato.copyWith(fontSize: 14,fontWeight: FontWeight.w100,), overflow: TextOverflow.ellipsis,maxLines:3),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8,),
                                    Expanded(
                                      flex: 1,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(article.authorImage),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    );
                  },
                    loading: () => CircularProgressIndicator(),
                    error: (error, stackTrace) => Text('Error: $error'),),
                ),


                /* Container(
                  child: ref.watch(articlesProvider).when(
                      data: (articles){
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              ArticleEntity article = articles[index];
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(article.title,style: AppTextStyles.font_lato,),
                                    SizedBox(height: 8,),
                                    Text(article.content, overflow: TextOverflow.ellipsis,maxLines:3),
                                    Row(
                                      children: [
                                        Text(article.authorName,style: AppTextStyles.font_poppins.copyWith(fontSize: 14,fontWeight: FontWeight.w100),),

                                        Spacer(),
                                        Text("12/12/2025",style: AppTextStyles.font_poppins.copyWith(fontSize: 14,fontWeight: FontWeight.w100)),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }
                        );
                      },
                    loading: () => CircularProgressIndicator(),
                    error: (error, stackTrace) => Text('Error: $error'),),
                ),*/
              ],
            ),
          ),
        ));
  }
}
