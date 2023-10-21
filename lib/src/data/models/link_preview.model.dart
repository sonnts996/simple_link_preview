/*
 Created by Thanh Son on 10/4/2021.
 Copyright (c) 2021 . All rights reserved.
*/
/// The returned object contains metadata information
class LinkPreview {
  /// The returned object contains metadata information
  const LinkPreview({
    required this.url,
    this.image,
    this.title,
    this.description,
  });

  /// The weblink title. Null if cannot find the image
  final String? title;

  /// The weblink url, this is your url
  final String url;

  /// The weblink image. Null if cannot find the image
  final String? image;

  /// The  weblink description. Null if cannot find the image
  final String? description;

  /// Clone new object
  LinkPreview copyWith({
    String? url,
    String? image,
    String? title,
    String? description,
  }) =>
      LinkPreview(
          url: url ?? this.url,
          image: image ?? this.image,
          title: title ?? this.title,
          description: description ?? this.description);

  @override
  String toString() {
    var map = {
      '"url"': '"$url"',
      '"title"': '"$title"',
      '"image"': '"$image"',
      '"description"': '"$description"',
    };
    return map.toString();
  }
}
