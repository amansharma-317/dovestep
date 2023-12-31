class MentalHealthAssessment {
  int moodStability; // Scale of 1 to 5 for mood stability
  int stressLevels; // Scale of 1 to 5 for stress levels
  int emotionalResilience; // Scale of 1 to 5 for emotional resilience
  int selfEsteem; // Scale of 1 to 5 for self-esteem
  int qualityOfSleep; // Scale of 1 to 5 for quality of sleep

  MentalHealthAssessment({
    required this.moodStability,
    required this.stressLevels,
    required this.emotionalResilience,
    required this.selfEsteem,
    required this.qualityOfSleep,
  });

  // Convert MentalHealthAssessment object to a Map
  Map<String, dynamic> toMap() {
    return {
      'moodStability': moodStability,
      'stressLevels': stressLevels,
      'emotionalResilience': emotionalResilience,
      'selfEsteem': selfEsteem,
      'qualityOfSleep': qualityOfSleep,
    };
  }

  // Create MentalHealthAssessment object from a Map
  factory MentalHealthAssessment.fromMap(Map<String, dynamic> map) {
    return MentalHealthAssessment(
      moodStability: map['moodStability'] ?? 0,
      stressLevels: map['stressLevels'] ?? 0,
      emotionalResilience: map['emotionalResilience'] ?? 0,
      selfEsteem: map['selfEsteem'] ?? 0,
      qualityOfSleep: map['qualityOfSleep'] ?? 0,
    );
  }
}
