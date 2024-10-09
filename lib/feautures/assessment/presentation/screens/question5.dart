import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:startup/core/bottom_bar.dart';
import 'package:startup/feautures/assessment/presentation/providers/assessment_providers.dart';
import 'package:startup/feautures/auth/presentation/screens/dashboard.dart';

class Question5 extends ConsumerWidget {
  const Question5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final answerProvider = Provider<int>((ref) => ref.watch(fifthQuestionAnswerProvider));
    final repository = ref.read(assessmentRepositoryProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16,),
              Text(
                  '5/5',
                  style: GoogleFonts.lato(
                      fontSize: 24, fontWeight: FontWeight.w300
                  )
              ),
              SizedBox(height: 16,),
              Text(
                'Rate the quality of your sleep.',
                style: GoogleFonts.poppins(
                    fontSize: 28, fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: 32,),

              Center(
                child: Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      ref.read(fifthQuestionAnswerProvider.notifier).state = 1;
                      LoadingIndicator(
                          indicatorType: Indicator.orbit, /// Required, The loading type of the widget
                          colors: const [Colors.white],       /// Optional, The color collections
                          strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                          backgroundColor: Colors.black,      /// Optional, Background of the widget
                          pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
                      );
                      try {
                        final repository = ref.read(assessmentRepositoryProvider);
                        final responses = [
                          ref.read(firstQuestionAnswerProvider.notifier).state,
                          ref.read(secondQuestionAnswerProvider.notifier).state,
                          ref.read(thirdQuestionAnswerProvider.notifier).state,
                          ref.read(fourthQuestionAnswerProvider.notifier).state,
                          ref.read(fifthQuestionAnswerProvider.notifier).state,
                        ];

                        final isSuccess = await repository.saveAssessmentResponses(responses);

                        // Dismiss the loading indicator

                        if (isSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomBar()));
                        } else {
                          Fluttertoast.showToast(msg: 'Failure to save your data!');
                        }
                      } catch (e) {
                        // Dismiss the loading indicator if an error occurs
                        print('error : ' + e.toString());
                        Fluttertoast.showToast(msg: 'Failure to save your data!');
                      }
                    },
                    child: Text('Very low', style: GoogleFonts.lato(color: Colors.white, fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size(width*0.8, height*0.06),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0)
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16,),
              Center(
                child: Container(

                  child: ElevatedButton(
                    onPressed: () async {
                      ref.read(fifthQuestionAnswerProvider.notifier).state = 2;
                      LoadingIndicator(
                          indicatorType: Indicator.orbit, /// Required, The loading type of the widget
                          colors: const [Colors.white],       /// Optional, The color collections
                          strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                          backgroundColor: Colors.black,      /// Optional, Background of the widget
                          pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
                      );
                      try {
                        final repository = ref.read(assessmentRepositoryProvider);
                        final responses = [
                          ref.read(firstQuestionAnswerProvider.notifier).state,
                          ref.read(secondQuestionAnswerProvider.notifier).state,
                          ref.read(thirdQuestionAnswerProvider.notifier).state,
                          ref.read(fourthQuestionAnswerProvider.notifier).state,
                          ref.read(fifthQuestionAnswerProvider.notifier).state,
                        ];

                        final isSuccess = await repository.saveAssessmentResponses(responses);

                        // Dismiss the loading indicator

                        if (isSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomBar()));
                        } else {
                          Fluttertoast.showToast(msg: 'Failure to save your data!');
                        }
                      } catch (e) {
                        // Dismiss the loading indicator if an error occurs
                        print('error : ' + e.toString());
                        Fluttertoast.showToast(msg: 'Failure to save your data!');
                      }
                    },
                    child: Text('Low', style: GoogleFonts.lato(color: Colors.white, fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size(width*0.8, height*0.06),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0)
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16,),
              Center(
                child: Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      ref.read(fifthQuestionAnswerProvider.notifier).state = 3;
                      LoadingIndicator(
                          indicatorType: Indicator.orbit, /// Required, The loading type of the widget
                          colors: const [Colors.white],       /// Optional, The color collections
                          strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                          backgroundColor: Colors.black,      /// Optional, Background of the widget
                          pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
                      );
                      try {
                        final repository = ref.read(assessmentRepositoryProvider);
                        final responses = [
                          ref.read(firstQuestionAnswerProvider.notifier).state,
                          ref.read(secondQuestionAnswerProvider.notifier).state,
                          ref.read(thirdQuestionAnswerProvider.notifier).state,
                          ref.read(fourthQuestionAnswerProvider.notifier).state,
                          ref.read(fifthQuestionAnswerProvider.notifier).state,
                        ];

                        final isSuccess = await repository.saveAssessmentResponses(responses);

                        // Dismiss the loading indicator

                        if (isSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomBar()));
                        } else {
                          Fluttertoast.showToast(msg: 'Failure to save your data!');
                        }
                      } catch (e) {
                        // Dismiss the loading indicator if an error occurs
                        print('error : ' + e.toString());
                        Fluttertoast.showToast(msg: 'Failure to save your data!');
                      }
                    },
                    child: Text('Neutral', style: GoogleFonts.lato(color: Colors.white, fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size(width*0.8, height*0.06),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0)
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16,),
              Center(
                child: Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      ref.read(fifthQuestionAnswerProvider.notifier).state = 4;
                      LoadingIndicator(
                          indicatorType: Indicator.orbit, /// Required, The loading type of the widget
                          colors: const [Colors.white],       /// Optional, The color collections
                          strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                          backgroundColor: Colors.black,      /// Optional, Background of the widget
                          pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
                      );
                      try {
                        final repository = ref.read(assessmentRepositoryProvider);
                        final responses = [
                          ref.read(firstQuestionAnswerProvider.notifier).state,
                          ref.read(secondQuestionAnswerProvider.notifier).state,
                          ref.read(thirdQuestionAnswerProvider.notifier).state,
                          ref.read(fourthQuestionAnswerProvider.notifier).state,
                          ref.read(fifthQuestionAnswerProvider.notifier).state,
                        ];

                        final isSuccess = await repository.saveAssessmentResponses(responses);

                        // Dismiss the loading indicator

                        if (isSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomBar()));
                        } else {
                          Fluttertoast.showToast(msg: 'Failure to save your data!');
                        }
                      } catch (e) {
                        // Dismiss the loading indicator if an error occurs
                        print('error : ' + e.toString());
                        Fluttertoast.showToast(msg: 'Failure to save your data!');
                      }
                    },
                    child: Text('High', style: GoogleFonts.lato(color: Colors.white, fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size(width*0.8, height*0.06),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0)
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16,),
              Center(
                child: Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      ref.read(fifthQuestionAnswerProvider.notifier).state = 5;
                      LoadingIndicator(
                          indicatorType: Indicator.orbit, /// Required, The loading type of the widget
                          colors: const [Colors.white],       /// Optional, The color collections
                          strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                          backgroundColor: Colors.black,      /// Optional, Background of the widget
                          pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
                      );
                      try {
                        final repository = ref.read(assessmentRepositoryProvider);
                        final responses = [
                          ref.read(firstQuestionAnswerProvider.notifier).state,
                          ref.read(secondQuestionAnswerProvider.notifier).state,
                          ref.read(thirdQuestionAnswerProvider.notifier).state,
                          ref.read(fourthQuestionAnswerProvider.notifier).state,
                          ref.read(fifthQuestionAnswerProvider.notifier).state,
                        ];

                        final isSuccess = await repository.saveAssessmentResponses(responses);

                        // Dismiss the loading indicator

                        if (isSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomBar()));
                        } else {
                          Fluttertoast.showToast(msg: 'Failure to save your data!');
                        }
                      } catch (e) {
                        // Dismiss the loading indicator if an error occurs
                        print('error : ' + e.toString());
                        Fluttertoast.showToast(msg: 'Failure to save your data!');
                      }
                    },
                    child: Text('Very high', style: GoogleFonts.lato(color: Colors.white, fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size(width*0.8, height*0.06),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0)
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
