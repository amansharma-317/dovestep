import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:startup/feautures/resources/domain/entities/exercise_entity.dart';

class xyz extends StatefulWidget {
  @override
  State<xyz> createState() => _xyzState();
}

class _xyzState extends State<xyz> {
  final ExerciseEntity sampleExercise = ExerciseEntity(
    name: 'Alternate-Nostril Breathing',
    description: 'Alternate-nostril breathing (nadi shodhana) involves blocking off one nostril at a time as you breathe through the other, alternating between nostrils in a regular pattern.It\'s best to practice this type of anxiety-relieving breathing in a seated position in order to maintain your posture.',
    duration: '15-20 minutes',
    steps: [
      ' 1. Position your right hand by bending your pointer and middle fingers into your palm, leaving your thumb, ring finger, and pinky extended. This is known as Vishnu mudra in yoga.',
      ' 2. Close your eyes or softly gaze downward.',
      ' 3. Inhale and exhale to begin.',
      ' 4. Close off your right nostril with your thumb.',
      ' 5. Inhale through your left nostril.',
      ' 6. Close off your left nostril with your ring finger.',
      ' 7. Open and exhale through your right nostril.',
      ' 8. Inhale through your right nostril.',
      ' 9. Close off your right nostril with your thumb.',
      '10. Open and exhale through your left nostril.',
      '11. Inhale through your left nostril.',
      '12. Reapeat upto 10-15rounds of this breathing pattern.'


    ],
    benefits: [
      '1. Help ease stress and anxiety',
      '2. Help people to relax.',
      '3. Lower blood pressure..',
      '4. Improve brain function, including helping with memory and movement.',
    ],
    variations: [
      '1.var 1',
      '2.var 2',
    ],
    category: 'Anxiety',
    image: 'https://cdn.shopify.com/s/files/1/2241/0819/files/Screenshot_46_480x480.png?v=1607120591',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Exercise to Firestore'),
      ),
      body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                await FirebaseFirestore.instance.collection('exercises').add(
                    sampleExercise.toMap());
                print('Exercise added to Firestore.');
              } catch (e) {
                print('Error adding exercise to Firestore: $e');
              }
            },
            child: Text('Add Sample Exercise'),
          )
      ),
    );
  }
}







