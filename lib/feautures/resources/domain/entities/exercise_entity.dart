class ExerciseEntity {
  final String name;
  final String description;
  final String duration;
  final List<String> steps;
  final List<String> benefits;
  final List<String> variations;
  final String category;
  final String image;

  ExerciseEntity({
    required this.name,
    required this.description,
    required this.duration,
    required this.steps,
    required this.benefits,
    required this.variations,
    required this.category,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'duration': duration,
      'steps': steps,
      'benefits': benefits,
      'variations': variations,
      'category': category,
      'imageUrl': image,
    };
  }

  factory ExerciseEntity.fromMap(Map<String, dynamic> map) {
    return ExerciseEntity(
      name: map['name'],
      description: map['description'],
      duration: map['duration'],
      steps: List<String>.from(map['steps']),
      benefits: List<String>.from(map['benefits']),
      variations: List<String>.from(map['variations']),
      category: map['category'],
      image: map['imageUrl'],
    );
  }
}
