/*
 Created by Thanh Son on 10/4/2021.
 Copyright (c) 2021 . All rights reserved.
*/
class LinkPreview {
  const LinkPreview({
    required this.url,
    this.image,
    this.title,
    this.description,
  });

  final String? title;
  final String url;
  final String? image;
  final String? description;

  LinkPreview copyWith({
    String? url,
    String? image,
    String? title,
    String? description,
  }) {
    return LinkPreview(
        url: url ?? this.url,
        image: image ?? this.image,
        title: title ?? this.title,
        description: description ?? this.description);
  }

  @override
  String toString() {
    // TODO: implement toString
    var map = {
      'url': url,
      'title': title,
      'image': image,
      'description': description,
    };
    return map.toString();
  }
}
