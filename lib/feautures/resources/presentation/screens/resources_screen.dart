import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup/feautures/resources/presentation/providers/article_providers.dart';
import 'package:startup/feautures/resources/presentation/providers/exercises_providers.dart';
import 'package:startup/feautures/resources/presentation/screens/article_content.dart';
import 'package:startup/feautures/resources/presentation/screens/exercises_categories_screen.dart';
import 'package:startup/feautures/resources/presentation/screens/view_all_articles.dart';
import 'package:startup/feautures/resources/presentation/widgets/article_card.dart';
import 'package:startup/feautures/resources/presentation/widgets/exercises_category_card.dart';
import '../../../../config/utils/const.dart';

class ResourcesScreen extends ConsumerWidget {
  ResourcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: SafeArea(child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 32,left: 16,right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("How Can We Support",style: AppTextStyles.font_poppins.copyWith(color: Color(0xFF000000),fontSize: 26,fontWeight: FontWeight.w700),),
              SizedBox(height: 8,),
              Text("You Today?",style: AppTextStyles.font_poppins.copyWith(color: Color(0xFF000000),fontSize: 26,fontWeight: FontWeight.w400),),
              SizedBox(height: 16,),
              Text("Find Help in Various Formats",style: AppTextStyles.font_lato.copyWith(color: Color(0x90000000),fontSize: 18,fontWeight: FontWeight.w300,letterSpacing: 1),),
              SizedBox(height: 24),

              //Articles
              Row(
                children: [
                  Text("Articles",style: AppTextStyles.font_poppins.copyWith(fontSize: 20,fontWeight: FontWeight.w400),),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewAllArticles()),
                      );
                    },
                    child: Row(
                      children: [
                        Text("View All",style: AppTextStyles.font_poppins.copyWith(fontWeight: FontWeight.w200,fontSize: 14),),
                        Icon(Icons.arrow_forward_rounded,size: 14,),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 8,),
              Container(
                height: height * 0.15,
                width: width,
                child: ref.watch(articlesProvider).when(
                  data: (articles) {
                    print('length of articles ' + articles.length.toString());
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ArticleContent(article: articles[index])),
                              );
                            },
                            child: Container(
                              width: width*0.4,
                                child: ArticleCard(index: index, title: articles[index].title,)
                            )
                        );
                      },
                    );
                  },
                  loading: () => CircularProgressIndicator(),
                  error: (error, stackTrace) => Text('Error: $error'),

                ),
              ),

              SizedBox(height: 16,),
              Text("Exercises",style: AppTextStyles.font_poppins.copyWith(fontSize: 20,fontWeight: FontWeight.w400),),
              SizedBox(height: 8,),
              ref.watch(exerciseCategoriesProvider).when(
                data: (categories) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1/1,
                    ),
                    itemBuilder: (context, index) {
                      //final category = categories[index];

                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExercisesCategoriesScreen(category: categories[index])),
                            );
                          },
                          child: ExercisesCategoryCard(index: index, categoryName: categories[index],),
                      );
                    },
                  );
                },
                loading: () => CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}