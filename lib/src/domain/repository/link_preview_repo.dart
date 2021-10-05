/*
 Created by Thanh Son on 10/4/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'package:simple_link_preview/src/data/models/link_preview.model.dart';

abstract class LinkPreviewRepo {
  LinkPreviewRepo(this.url) {
    uri = Uri.parse(url);
  }

  final String url;
  late final Uri uri;
  String? title;
  String? description;
  String? image;

  Future<LinkPreview?> getPreview();
}
