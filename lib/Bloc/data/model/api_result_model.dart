// Dada Ki jay Ho

class ApiResultModel {
  List<Media> slides;

  ApiResultModel({required this.slides});

  factory ApiResultModel.fromJson(Map<String, dynamic> json) {
    List<Media> slides = [];
    if (json['slides'] != null) {
      json['slides'].forEach((v) {
        slides.add(Media.fromJson(v));
      });
    }
    return ApiResultModel(slides: slides);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['totalResults'] = this.totalResults;
  //   if (this.articles != null) {
  //     data['articles'] = this.articles.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Media {
  String type;
  String title;
  String mediaUrl;

  Media({
    required this.type,
    required this.title,
    required this.mediaUrl,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    String type = json['type'] ?? "Type is not given";
    String title = json['title'] ?? "Title is not given";
    String mediaUrl = json['mediaUrl'] ?? "media URL not found";

    return Media(type: type, title: title, mediaUrl: mediaUrl);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['title'] = title;
    data['mediaUrl'] = mediaUrl;
    return data;
  }
}
