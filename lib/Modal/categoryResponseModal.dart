class CategoryRespnseModal {
  String? category;
  String? data;

  CategoryRespnseModal({this.category, this.data});

  CategoryRespnseModal.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category'] = category;
    data['data'] = data;
    return data;
  }
}
