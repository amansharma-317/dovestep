import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/feautures/hotline/presentation/providers/hotline_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timer_count_down/timer_count_down.dart';

class HotlineScreen extends StatefulWidget {
  @override
  _HotlineScreenState createState() => _HotlineScreenState();
}

class _HotlineScreenState extends State<HotlineScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _longPressed = false;
  bool _timerVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  void _startTimer() {
    setState(() {
      _timerVisible = true;
    });
  }

  void _cancelTimer() {
    setState(() {
      _timerVisible = false;
    });
  }

  void _redirectToDialpad() async {
    final Uri url = Uri(
      scheme: 'tel',
      path: '1-8008914416'
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Long Press Button",
                  style: AppTextStyles.font_poppins.copyWith(fontSize: 26,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Consumer(
                  builder: (context, ref, child) {
                    final hotlineCount = ref.watch(hotlineCountProvider);
                    return Visibility(
                      visible: _timerVisible,
                      child: Countdown(
                        seconds: 3,
                        build: (_, double time) => Text(
                          "Timer: ${time.toInt()+1} seconds",
                          style: AppTextStyles.font_poppins.copyWith(),
                        ),
                        interval: Duration(milliseconds: 100),
                        onFinished: () async {
                          hotlineCount.when(
                            data: (int count) async{
                              if(count < 2){
                                _redirectToDialpad();
                                print('hello');
                                await ref.read(hotlineCallProvider.future);
                              }else {
                                Fluttertoast.showToast(
                                  msg: "You have exceeded the daily limit!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );

                              }
                            },
                            loading: () => CircularProgressIndicator(), // Show a loading indicator
                            error: (error, stackTrace) => Text('Error fetching count'),
                          );

                        },
                      ),
                    );
                  }
                ),
                SizedBox(height: 8,),
                GestureDetector(
                  onLongPressStart: (details) {
                    _controller.repeat(reverse: true);
                    setState(() {
                      _longPressed = true;
                    });
                    _startTimer();
                  },
                  onLongPressEnd: (details) {
                    _controller.stop();
                    setState(() {
                      _longPressed = false;
                    });
                    _cancelTimer();
                  },
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: Container(
                          width: 500,
                          height: 500,
                          decoration: BoxDecoration(
                            color: Color(0xFFC60404),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.touch_app,
                                  size: 200,
                                  color: Colors.white,
                                ),
                                ClipPath(
                                  clipper: WaveClipper(
                                    animation: _controller,
                                  ),
                                  child: Container(
                                    width: 400,
                                    height: 400,
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class WaveClipper extends CustomClipper<Path> {
  final Animation<double> animation;

  WaveClipper({required this.animation});

  @override
  Path getClip(Size size) {
    final path = Path();
    final y = size.height * (1 - animation.value);
    path.moveTo(0, y);
    path.lineTo(size.width * 0.25, y);
    path.quadraticBezierTo(
        size.width * 0.375, y - 30 * (1 - animation.value), size.width * 0.5, y);
    path.quadraticBezierTo(
        size.width * 0.625, y + 30 * (1 - animation.value), size.width * 0.75, y);
    path.lineTo(size.width, y);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
