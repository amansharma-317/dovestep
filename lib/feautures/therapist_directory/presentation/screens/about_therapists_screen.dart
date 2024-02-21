import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/feautures/therapist_directory/domain/entities/therapist_entity.dart';
import 'package:startup/feautures/therapist_directory/presentation/screens/book_therapists_screen.dart';
import 'package:startup/feautures/therapist_directory/presentation/widgets/therapist_row_details.dart';
import 'package:video_player/video_player.dart';


class AboutTherapistsScreen extends StatefulWidget {
  AboutTherapistsScreen({Key? key,required this.therapist}) : super(key: key);
  final Therapist therapist;
  @override
  State<AboutTherapistsScreen> createState() => _AboutTherapistsScreenState();
}

class _AboutTherapistsScreenState extends State<AboutTherapistsScreen> {
  late VideoPlayerController _controller;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    print("hii" + widget.therapist.introVideoUrl!);
    _controller =  VideoPlayerController.networkUrl(Uri.parse(widget.therapist.introVideoUrl!),)
      ..initialize().then((_) {
        setState(() {
          print("hello " +widget.therapist.introVideoUrl!);
          _controller.play();
        });
      }).catchError((onError){
        print(onError.toString());
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
         body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0x5088AB8E),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  //height: height*0.25,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(backgroundImage: NetworkImage(widget.therapist.therapistPictureUrl!),radius: width*0.126,),
                          SizedBox(width: 16,),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8,),
                                Text(widget.therapist.name!,style: AppTextStyles.font_lato.copyWith(fontSize: height*0.023,fontWeight: FontWeight.w800),),
                                SizedBox(height: 8,),
                                Text(widget.therapist.expertise!,style: AppTextStyles.font_lato.copyWith(fontSize: 14,fontWeight: FontWeight.w400),),
                                SizedBox(height: 1,),
                                Text(widget.therapist.qualification!,style: TextStyle(fontFamily: GoogleFonts.rubik().fontFamily,fontStyle: FontStyle.normal,fontSize: 14,),),
                                SizedBox(height: 1,),
                                Text("English, Hindi",style: AppTextStyles.font_lato.copyWith(fontSize: 14,fontWeight: FontWeight.w400),),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16,),
                      TherapistsRowDetails(experience: widget.therapist.experience!, totalPatients: widget.therapist.totalPatients!,),
                      SizedBox(height: 8,),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: Text("About Doctor",style: AppTextStyles.font_lato.copyWith(fontWeight: FontWeight.w600, color: Color(0xff27405A))),
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: Text(widget.therapist.aboutTherapist!,style: AppTextStyles.font_lato.copyWith(fontSize: 17, height: 1.3,), textAlign: TextAlign.center,),
                ),
                SizedBox(height: 40,),

                //VIDEO - PLAYER
                _controller.value.isInitialized
                    ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        _PlayPauseOverlay(controller: _controller),
                        VideoProgressIndicator(_controller, allowScrubbing: true),
                      ],
                  ),
                ),
                    )
                    : CircularProgressIndicator(),
              ],
            ),
         ),

          bottomNavigationBar: Container(
            margin: EdgeInsets.all(30),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(primary: null),
              ),
              child: ElevatedButton(
                onPressed: ()  {
                  _controller.pause();
                  Navigator.of
                    (context).push(
                      MaterialPageRoute(builder: (context) => BookTherapistsScreen(therapist: widget.therapist)));
                },
                child: Text('Book Now', style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily, fontWeight: FontWeight.w700,fontSize: 22),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff27405A),
                  fixedSize: Size(width*0.8, height*0.075),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
              ),
            ),
          ),
    ));
  }
}

class _PlayPauseOverlay extends StatefulWidget {
  final VideoPlayerController controller;

  const _PlayPauseOverlay({required this.controller});

  @override
  _PlayPauseOverlayState createState() => _PlayPauseOverlayState();
}

class _PlayPauseOverlayState extends State<_PlayPauseOverlay> {
  late bool _isMuted;

  @override
  void initState() {
    super.initState();
    _isMuted = widget.controller.value.volume == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (widget.controller.value.isPlaying) {
                widget.controller.pause();
              } else {
                widget.controller.play();
              }
            });
          },
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          child: IconButton(
            icon: _isMuted ? Icon(Icons.volume_off) : Icon(Icons.volume_up),
            onPressed: () {
              setState(() {
                _isMuted = !_isMuted;
                widget.controller.setVolume(_isMuted ? 0 : 1.0);
              });
            },
          ),
        ),
      ],
    );
  }
}


