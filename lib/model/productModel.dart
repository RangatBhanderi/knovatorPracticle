

class PostModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostModel({this.userId, this.id, this.title, this.body});

  // Convert a PostModel object to a Map object
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  // Convert a Map object to a PostModel object
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  // Convert a list of JSON objects into a list of PostModel objects
  static List<PostModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PostModel.fromMap(json)).toList();
  }

  // Convert a list of PostModel objects to a list of maps
  static List<Map<String, dynamic>> toJsonList(List<PostModel> posts) {
    return posts.map((post) => post.toMap()).toList();
  }
}
