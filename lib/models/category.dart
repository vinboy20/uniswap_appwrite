class CategoryModel {
  String? docId;
  String? title;
  String? image;
  String? imageId;

  CategoryModel({
    this.docId,
    required this.title,
    required this.image,
    this.imageId,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    docId = json['\$id'];
    title = json['title'];
    image = json['image'];
    imageId = json['imageId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    return data;
  }

  // factory CategoryModel.fromJson(Map<String, dynamic> json) {
  //   return CategoryModel(
  //     docId: json['\$id'] ?? '', // Provide a default value if null
  //     title: json['title'] ?? 'No Title', // Provide a default value if null
  //     image: json['image'], // This can be null
  //   );
  // }
}
