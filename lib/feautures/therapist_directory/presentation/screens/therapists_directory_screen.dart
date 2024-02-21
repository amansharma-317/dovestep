import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/feautures/therapist_directory/domain/entities/therapist_entity.dart';
import 'package:startup/feautures/therapist_directory/presentation/providers/therapist_providers.dart';
import 'package:startup/feautures/therapist_directory/presentation/screens/about_therapists_screen.dart';

class TherapistsDirectoryScreen extends ConsumerWidget {
  const TherapistsDirectoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundImage: AssetImage("assets/images/profileicon.png"),),
                    Spacer(),
                    Icon(Icons.notifications_none,size: 32,),
                  ],
                ),
                SizedBox(height: 24,),
                Text("Book a session",style: AppTextStyles.font_poppins.copyWith(fontSize: 26),),
                SizedBox(height: 16,),
                Consumer(
                    builder: (context, watch, child) {
                      final therapistsAsyncValue = ref.watch(therapistsProvider);
                      return therapistsAsyncValue.when(
                        data: (therapists) {
                          print(therapists.length);
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: therapists.length,
                            itemBuilder: (context, index) {
                             Therapist therapist = therapists[index];
                              return Column(
                                children: [
                                  GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                      color: Color(0x3088AB8E),
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        //height: height*0.25,
                                        width: width,
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                      child: AspectRatio(
                                                        aspectRatio: 1.0,
                                                        child: CircleAvatar(
                                                          backgroundImage: NetworkImage(therapist.therapistPictureUrl!), ),
                                                      )
                                                  ),
                                                ),
                                                SizedBox(width: 16,),
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 8,),
                                                        Text(
                                                          therapist.name!,style: AppTextStyles.font_lato.copyWith(fontSize: 16,fontWeight: FontWeight.w800),
                                                        ),
                                                        SizedBox(height: 4,),
                                                        FittedBox(
                                                          child: Text(
                                                              therapist.expertise!,style: TextStyle(fontFamily: GoogleFonts.rubik().fontFamily,fontStyle: FontStyle.italic,fontWeight: FontWeight.w700)
                                                          ),
                                                        ),
                                                        SizedBox(height: 1,),
                                                        FittedBox(
                                                          child: Text(
                                                            therapist.qualification!,style: TextStyle(fontFamily: GoogleFonts.rubik().fontFamily,fontStyle: FontStyle.normal,),
                                                          ),
                                                        ),
                                                        SizedBox(height: 1,),
                                                        FittedBox(
                                                          child: Text(
                                                            therapist.experience! + "+ years of experience",style: TextStyle(fontFamily: GoogleFonts.rubik().fontFamily,fontStyle: FontStyle.normal,),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 4,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: Image.asset("assets/images/77bc53e4-1844-4e85-88d8-20d3c116d291.png",fit: BoxFit.fill,)),
                                                      SizedBox(width: 8,),
                                                      Expanded(
                                                          flex: 4,
                                                          child: FittedBox(child: Text(therapist.language!,style: AppTextStyles.font_lato.copyWith(fontWeight: FontWeight.w400),maxLines: 2,))),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  flex:3,
                                                  child: Container(
                                                    height: height*0.060,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Color(0xFF27405A),
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                          elevation: 0,
                                                        ),
                                                        onPressed: (){
                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutTherapistsScreen(therapist: therapists[index])));
                                                        }, child: FittedBox(child: Text("Book @" + therapist.cost!.toString() + "/-",style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily, fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutTherapistsScreen(therapist: therapists[index])));
                                    },
                                  ),
                                ],
                              );

                            },
                          );
                        },
                        loading: () => CircularProgressIndicator(),
                        error: (error, stackTrace) => Text('Error: $error'),
                      );
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
