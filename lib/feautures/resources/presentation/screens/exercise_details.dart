import 'package:flutter/material.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/feautures/resources/domain/entities/exercise_entity.dart';

class ExerciseDetails extends StatefulWidget {
  ExerciseDetails({Key? key, required this.exercise}) : super(key: key);
  final ExerciseEntity exercise;

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffF5F5F5),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.exercise.name,style: AppTextStyles.font_poppins.copyWith(fontSize: 26,fontWeight: FontWeight.w700),),
                  SizedBox(height: 24,),
                  Text(widget.exercise.description,style: AppTextStyles.font_lato.copyWith(fontSize: 18,fontWeight: FontWeight.w500,height: 1.3),),
                  SizedBox(height: 32,),
                  Text("Steps",style: AppTextStyles.font_poppins.copyWith(fontSize: 20,fontWeight: FontWeight.w600)),
                  SizedBox(height: 8,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.exercise.steps.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. ${widget.exercise.steps[index]}',
                          style: AppTextStyles.font_lato.copyWith(fontSize: 18, fontWeight: FontWeight.w400,height: 1.4),
                        ),
                        SizedBox(height: 3.5,),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Image.network(widget.exercise.image),
                  ),
                  SizedBox(height: 32,),
                  Text("Benefits",style: AppTextStyles.font_poppins.copyWith(fontSize: 20,fontWeight: FontWeight.w600)),
                  SizedBox(height: 8,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.exercise.benefits.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. ${widget.exercise.benefits[index]}',
                          style: AppTextStyles.font_lato.copyWith(fontSize: 18, fontWeight: FontWeight.w400,height: 1.4),
                        ),
                        SizedBox(height: 3.5,),
                      ],
                    ),
                  ),
                  SizedBox(height: 32,),
                  Text("Variations",style: AppTextStyles.font_poppins.copyWith(fontSize: 20,fontWeight: FontWeight.w600)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.exercise.variations.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. ${widget.exercise.variations[index]}',
                          style: AppTextStyles.font_lato.copyWith(fontSize: 18, fontWeight: FontWeight.w400,height: 1.4),
                        ),
                        SizedBox(height: 3.5,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
