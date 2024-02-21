class Therapist {
  final String? therapistId;
  final String? name;
  final String? expertise;
  final String? therapistPictureUrl;
  final int? cost;
  final Map<String, List<String>>? availability;
  final String? experience;
  final String? qualification;
  final String? aboutTherapist;
  final String? language;
  final String? totalPatients;
  final String? introVideoUrl;

  Therapist( {
    this.therapistPictureUrl,
    this.therapistId,
    this.name,
    this.expertise,
    this.cost,
    this.language,
    this.availability,
    this.experience,
    this.qualification,
    this.aboutTherapist,
    this.introVideoUrl,
    this.totalPatients,
  });

  // Convert Therapist instance to a map (handling potential null values)
  Map<String, dynamic> toMap() {
    return {
      'therapistId': therapistId,
      'name': name,
      'expertise': expertise,
      'cost': cost,
      'availability': availability,
      'language': language,
      'therapistPictureUrl,': therapistPictureUrl,
      'experience': experience,
      'qualification': qualification,
      'aboutTherapist': aboutTherapist,
      'introVideoUrl' : introVideoUrl,
      'toalPatients' : totalPatients,
    };
  }

  // Create Therapist instance from a map (handling potential null values)
  static Therapist fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return Therapist(); // Handle null map
    }
    return Therapist(
      therapistId: map['therapistId'] as String?,
      name: map['name'] as String?,
      expertise: map['expertise'] as String?,
      cost: map['cost'] as int?,
      availability: (map['availability'] as Map?)?.map(
            (key, value) => MapEntry(key, (value as List<dynamic>).cast<String>()),
      ),
      experience: map['experience'] as String?,
      language: map['language'] as String?,
      qualification: map['qualification'] as String?,
      aboutTherapist: map['aboutTherapist'] as String?,
      introVideoUrl: map['introVideoUrl'] as String?,
      therapistPictureUrl: map['therapistPictureUrl'] as String?,
      totalPatients: map['totalPatients'] as String?,
    );
  }
}
