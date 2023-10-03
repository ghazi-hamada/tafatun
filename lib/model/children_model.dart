class ChildrenModel {
  String? name;
  String? id;
  ChildrenModel({
    this.name,
    this.id,
  });
  ChildrenModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    return _data;
  }
}
