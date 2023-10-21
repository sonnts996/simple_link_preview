/*
 Created by Thanh Son on 10/4/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import '../../data/models/link_preview.model.dart';

/// The interface to read metadata from weblink.
abstract class LinkPreviewRepo {
  /// The interface to read metadata from weblink.
  LinkPreviewRepo(this.url) {
    uri = Uri.parse(url);
  }

  /// The web link need to get metadata
  final String url;

  /// The web link as Uri
  late final Uri uri;

  /// The web title, which will be added at runtime,
  /// null if not detected.
  String? title;

  /// The web description, which will be added at runtime
  /// null if not detected.
  String? description;

  /// The web description, which will be added at runtime
  /// null if not detected.
  String? image;

  /// The function that performs checking and detecting metadata from url
  Future<LinkPreview> getPreview();
}
