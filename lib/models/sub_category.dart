class SubCategoryModel {
  String? docId;
  String? catId;
  String? title;

  SubCategoryModel({
    this.docId,
    required this.catId,
    required this.title,
  });

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    docId = json['\$id'];
    catId = json['catId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // data['docId'] = docId;
    data['title'] = title;
    data['catId'] = catId;
    return data;
  }
}
