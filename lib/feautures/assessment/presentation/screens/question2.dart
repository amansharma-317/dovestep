import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup/feautures/assessment/presentation/providers/assessment_providers.dart';
import 'package:startup/feautures/assessment/presentation/screens/question3.dart';

class Question2 extends ConsumerWidget {
  const Question2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final answerProvider = Provider<int>((ref) => ref.watch(secondQuestionAnswerProvider));
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
                  '2/5',
                  style: GoogleFonts.lato(
                      fontSize: 24, fontWeight: FontWeight.w300
                  )
              ),
              SizedBox(height: 16,),
              Text(
                'Rate your stress levels on average.',
                style: GoogleFonts.poppins(
                    fontSize: 28, fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: 32,),

              Center(
                child: Container(
                  child: ElevatedButton(
                    onPressed: (){
                        ref.read(secondQuestionAnswerProvider.notifier).state = 1;
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => Question3())); // Direct push to Question3
                        },
                    child: Text('Very poor', style: GoogleFonts.lato(color: Colors.white, fontSize: 18),),
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
                    onPressed: (){
                      ref.read(secondQuestionAnswerProvider.notifier).state = 2;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Question3())); // Direct
                    },
                    child: Text('Slighty poor', style: GoogleFonts.lato(color: Colors.white, fontSize: 18),),
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
                    onPressed: (){
                      ref.read(secondQuestionAnswerProvider.notifier).state = 3;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Question3())); // Direct
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
                    onPressed: (){
                      ref.read(secondQuestionAnswerProvider.notifier).state = 4;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Question3())); // Direct
                    },
                    child: Text('Good', style: GoogleFonts.lato(color: Colors.white, fontSize: 18),),
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
                    onPressed: (){
                      ref.read(secondQuestionAnswerProvider.notifier).state = 5;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Question3())); // Direct
                    },
                    child: Text('Excellent', style: GoogleFonts.lato(color: Colors.white, fontSize: 18),),
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
