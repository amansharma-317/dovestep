import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/config/utils/const.dart';

class MyBookings extends ConsumerWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  child: Text('My Bookings', style: AppTextStyles.font_poppins.copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.25, fontSize: 24),),
                ),
                SizedBox(height: 16,),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xff88AB8E).withOpacity(0.25),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // First row content
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('04:00', style: AppTextStyles.font_lato.copyWith(fontWeight: FontWeight.w600),),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text('Aman Sharma', style: AppTextStyles.font_poppins.copyWith(fontWeight: FontWeight.w600),),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text('\$600', style: AppTextStyles.font_lato.copyWith(fontWeight: FontWeight.w200),),
                                  ),
                                  SizedBox(height: 8,),
                                ],
                              ),

                              SizedBox(height: 16,),
                              // Second row content
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('03:00', style: AppTextStyles.font_lato.copyWith(fontWeight: FontWeight.w100),),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text('Career', style: AppTextStyles.font_poppins.copyWith(fontWeight: FontWeight.w400),),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text('Pending', style: AppTextStyles.font_lato.copyWith(fontWeight: FontWeight.values.first, fontSize: 14, color: Colors.red),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16,),
                      ],
                    );

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
