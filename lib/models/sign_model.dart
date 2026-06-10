class SignModel {
  final int? id;
  final String name;
  final String category;
  final String imageUrl;
  final String description;

  SignModel({
    this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  factory SignModel.fromMap(Map<String, dynamic> map) {
    return SignModel(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      imageUrl: map['imageUrl'],
      description: map['description'],
    );
  }
}
