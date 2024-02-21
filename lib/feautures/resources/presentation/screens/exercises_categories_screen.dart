import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/feautures/resources/domain/entities/exercise_entity.dart';
import 'package:startup/feautures/resources/presentation/providers/exercises_providers.dart';
import 'package:startup/feautures/resources/presentation/screens/exercise_details.dart';

class ExercisesCategoriesScreen extends ConsumerWidget {
   ExercisesCategoriesScreen({Key? key, required this.category}) : super(key: key);
   final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(exercisesByCategoryProvider(category));
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFEEEEEE),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffEEEEEE),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            title:  Text("Exercises for " + category,style: AppTextStyles.font_poppins.copyWith(fontSize: 20,fontWeight: FontWeight.w400),),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  child: exercises.when(
                      data: (exercises){
                        return Expanded(
                          child: ListView.separated(
                              separatorBuilder: (BuildContext context, int index) => SizedBox(height: 12),
                              itemCount: exercises.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                ExerciseEntity exercise = exercises[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ExerciseDetails(exercise: exercise)),
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
                                              Text(exercise.name, style: AppTextStyles.font_poppins.copyWith(fontSize: 18,fontWeight: FontWeight.w700),),
                                              SizedBox(height: 6),
                                              Text(exercise.description, style: AppTextStyles.font_lato.copyWith(fontSize: 14,fontWeight: FontWeight.w100,), overflow: TextOverflow.ellipsis,maxLines:3),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 8,),
                                        Expanded(
                                          flex: 1,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(exercise.image),
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
              error: (error, stackTrace) => Text('Error: $error'),))

              ],
            ),
          ),
        ));
  }
}
