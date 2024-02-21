import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:startup/config/utils/const.dart';
import 'package:startup/feautures/therapist_directory/domain/entities/therapist_entity.dart';
import 'package:startup/feautures/therapist_directory/presentation/providers/payment_providers.dart';
import 'package:startup/feautures/therapist_directory/presentation/providers/therapist_providers.dart';

class BookTherapistsScreen  extends ConsumerStatefulWidget {
  BookTherapistsScreen ({Key? key, required this.therapist}) : super(key: key);
  final Therapist therapist;

  @override
  _BookTherapistsScreenState createState() => _BookTherapistsScreenState();

}

class _BookTherapistsScreenState extends ConsumerState<BookTherapistsScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController(text: DateFormat('dd-MMM').format(DateTime.now()));
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final razorpayProvider = ref.watch(razorpayPaymentProvider);
    print(widget.therapist.therapistId);
    //final selectedDate = ref.watch(selectedDateProvider);
    final availableTimeSlots = ref.watch(availableTimeSlotsProvider(widget.therapist.therapistId!));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFEEEEEE),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Icon(Icons.arrow_back_outlined, color: Color(0xff3A4454),),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Book Session', style: GoogleFonts.poppins(
          textStyle: TextStyle(color: Color(0xff3A4454),

              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name', style: GoogleFonts.lato(
                textStyle: TextStyle(color: Color(0xff3A4454),
                    letterSpacing: 0.8,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),
              ),),
              SizedBox(height: 8,),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F6FA),
                  hintText: 'Enter your name',
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.people_alt_outlined),
                ),
                style: TextStyle(
                  color: Color(0xff3A4454),
                  fontSize: 14, // Adjust the font size as desired
                ),
              ),
              SizedBox(height: 16,),
              Text(
                'Email', style: GoogleFonts.lato(
                textStyle: TextStyle(color: Color(0xff3A4454),
                    letterSpacing: 0.8,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),
              ),),
              SizedBox(height: 8,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F6FA),
                  hintText: 'Enter your email',
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.people_alt_outlined),
                ),
                style: TextStyle(
                  color: Color(0xff3A4454),
                  fontSize: 14, // Adjust the font size as desired
                ),
              ),
              SizedBox(height: 16,),
              Text(
                'Date', style: GoogleFonts.lato(
                textStyle: TextStyle(color: Color(0xff3A4454),
                    letterSpacing: 0.8,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),
              ),),
              SizedBox(height: 8,),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F6FA),
                  hintText: 'Date',
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.calendar_today_sharp, color: Color(0xff3A4454)),

                ),
                style: TextStyle(
                  color: Color(0xff3A4454),
                  fontSize: 14, // Adjust the font size as desired
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate:DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Color(0xff008080), // header background color
                          hintColor: Color(0xff3A4454), // selection color
                          colorScheme: ColorScheme.light(primary: Color(0Xff008080)),
                          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                        ),
                        child: child!,
                      );
                    },
                  );
                  print(pickedDate);
                  if (pickedDate != null) {
                    // Format the picked date to the desired display format
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate);
                    ref.read(selectedDateProvider.notifier).state = formattedDate;
                    print(formattedDate);
                    ref.refresh(availableTimeSlotsProvider(widget.therapist.therapistId!));

                    print(widget.therapist.name);
                    setState(() {
                      dateController.text = formattedDate;
                      //dateFormattedForFirestore = DateFormat('MM-dd').format(pickedDate);
                    });
                    //print(dateFormattedForFirestore);
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              SizedBox(height: 16,),
              Consumer(
                builder: (context, watch, child) {
                  return availableTimeSlots.when(
                    data: (timeSlots) {
                      if(timeSlots.length>0) {
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 2.5,
                          ),
                          itemCount: timeSlots.length, // Total number of buttons is now based on the number of slots
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 2,
                                    color: Color(0xFF27405A),
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: Color(0xFFEEEEEE),
                              ),
                              onPressed: () {
                                // Handle button press with the corresponding time slot
                                print('Button $index pressed. Time slot: ${timeSlots[index]}');
                              },
                              child: Text(
                                timeSlots[index], // Use the time slot text as the button text
                                style: AppTextStyles.font_lato.copyWith(fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                        );
                      } else if(timeSlots.length == 0) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE), // Background color
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 2, color: Color(0xFF27405A)), // Border properties
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'No slots available',
                              style: AppTextStyles.font_lato.copyWith(fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.w600),
                            ),
                          ),
                        );

                      } else{
                        return Container();
                      }
                    },
                    error: (error, stacktrace) => Text('Error in gridview: ' + error.toString()),
                    loading: () => CircularProgressIndicator(),
                  );
                }
              ),

            ],
          ),
        ),
      )),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(30),
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(primary: null),
          ),
          child: ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty || dateController.text.isEmpty || emailController.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: "Fill mandatory fields",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              } else {
                // All fields are filled, proceed with payment
                ref.read(razorpayPaymentProvider).startPayment();
              }
            },
            child: Text('Book Now', style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily, fontWeight: FontWeight.w700,fontSize: 22),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF27405A),
              fixedSize: Size(width*0.8, height*0.075),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
            ),
          ),
        ),
      ),
    );
  }
}


