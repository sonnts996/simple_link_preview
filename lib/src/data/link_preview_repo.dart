/*
 Created by Thanh Son on 10/4/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'package:http/http.dart' as http;
import 'package:metadata_fetch_plus/metadata_fetch_plus.dart' as fetch;
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

import '../contants/attributes.dart';
import '../domain/repository/link_preview_repo.dart';
import 'models/link_preview.model.dart';

/// The extension object reads metadata from the weblink.
class LinkPreviewRepoV1 extends LinkPreviewRepo {
  /// The [LinkPreviewRepoV1]'s constructor
  LinkPreviewRepoV1(String url) : super(url);

  @override
  Future<LinkPreview> getPreview() async {
    // TODO: implement getPreview
    // throw Exception('Invalid url') if url is not valid
    // Otherwise, return a valid LinkPreview.
    if (!uri.isAbsolute) throw Exception('Invalid url');

    var meta = await fetchMeta(url)
        .catchError((error) => fetchMeta(uri.host).catchError((error2) {
              description = error2.message;
              return null;
            }));

    if (meta == null) {
      return LinkPreview(
        url: url,
        title: url,
        description: description,
        image: image,
      );
    }

    title = meta.title;
    image = meta.image;
    description = meta.description;

    if (title == null || image == null || description == null) {
      var doc = await readHttp(uri);
      getMeta(doc);
    }

    return LinkPreview(
      url: url,
      title: title,
      description: description,
      image: image,
    );
  }

  /// Use fetch to get a faster metadata
  Future<fetch.Metadata?> fetchMeta(String url) =>
      fetch.MetadataFetch.extract(url);

  /// read html from uri
  Future<HtmlDocument> readHttp(Uri uri) async {
    var contents = await http.read(uri);
    return parseHtmlDocument(contents);
  }

  /// parsing data from meta tag
  void getMeta(HtmlDocument doc) {
    var head = doc.head;
    if (head != null) {
      var t = head.querySelector('title')?.innerText;
      title = t ?? doc.title;

      var metas = head.querySelectorAll('meta');
      for (var meta in metas) {
        var attr = meta.attributes;
        if (title == null) {
          if (_validMetaTitleElement(meta)) {
            title = attr['content'];
          }
        }
        if (_validMetaDescriptionElement(meta)) {
          description = attr['content'];
        }
        if (_validMetaImageElement(meta)) {
          var img = attr['content'];
          if (img != null) {
            var temp = Uri.parse(img);
            if (temp.isAbsolute) {
              image = img;
            } else {
              image = Uri.https(uri.host, img).toString();
            }
          } else {
            image = img;
          }
        }
      }
    } else {
      title = doc.title;
    }
  }

  /// check meta tag contains description content
  bool _validMetaDescriptionElement(Element meta) {
    var attr = meta.attributes;
    var name = attr['name'] ?? '';
    var property = attr['property'] ?? '';
    var itemprop = attr['itemprop'] ?? '';
    return Attributes.description.contains(name) ||
        Attributes.description.contains(property) ||
        Attributes.description.contains(itemprop);
  }

  /// check meta tag contains title content
  bool _validMetaTitleElement(Element meta) {
    var attr = meta.attributes;
    var name = attr['name'] ?? '';
    var property = attr['property'] ?? '';
    var itemprop = attr['itemprop'] ?? '';
    return Attributes.title.contains(name) ||
        Attributes.title.contains(property) ||
        Attributes.title.contains(itemprop);
  }

  /// check meta tag contains image content
  bool _validMetaImageElement(Element meta) {
    var attr = meta.attributes;
    var name = attr['name'] ?? '';
    var property = attr['property'] ?? '';
    var itemprop = attr['itemprop'] ?? '';
    return Attributes.image.contains(name) ||
        Attributes.image.contains(property) ||
        Attributes.image.contains(itemprop);
  }
}
