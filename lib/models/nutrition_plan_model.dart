class NutritionPlan {
  String id;
  String title;
  String description;

  NutritionPlan({required this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  static NutritionPlan fromMap(Map<String, dynamic> map) {
    return NutritionPlan(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
