/*
 Created by Thanh Son on 10/4/2021.
 Copyright (c) 2021 . All rights reserved.
*/
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart' as fetch;
import 'package:simple_link_preview/src/contants/attributes.dart';
import 'package:simple_link_preview/src/data/models/link_preview.model.dart';
import 'package:simple_link_preview/src/domain/repository/link_preview_repo.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

class LinkPreviewRepoV1 extends LinkPreviewRepo {
  /// Extension object read metadata from web link.

  LinkPreviewRepoV1(String url) : super(url);

  @override
  Future<LinkPreview> getPreview() async {
    // TODO: implement getPreview
    // throw Exception('Invalid url') if url is not valid
    // Otherwise, return a valid LinkPreview.
    if (!uri.isAbsolute) throw Exception('Invalid url');

    var meta = await fetchMeta(url).catchError((error) {
      return fetchMeta(uri.host).catchError((error2) {
        description = error2.message;
        return null;
      });
    });

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

  Future<fetch.Metadata?> fetchMeta(String url) {
    // Use fetch to get a faster metadata
    return fetch.MetadataFetch.extract(url);
  }

  Future<HtmlDocument> readHttp(Uri uri) async {
    // read html from uri
    var contents = await http.read(uri);
    return parseHtmlDocument(contents);
  }

  void getMeta(HtmlDocument doc) {
    // parsing data from meta tag
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

  bool _validMetaDescriptionElement(Element meta) {
    // check meta tag contains description content
    var attr = meta.attributes;
    var name = attr['name'] ?? '';
    var property = attr['property'] ?? '';
    var itemprop = attr['itemprop'] ?? '';
    return Attributes.description.contains(name) ||
        Attributes.description.contains(property) ||
        Attributes.description.contains(itemprop);
  }

  bool _validMetaTitleElement(Element meta) {
    // check meta tag contains title content
    var attr = meta.attributes;
    var name = attr['name'] ?? '';
    var property = attr['property'] ?? '';
    var itemprop = attr['itemprop'] ?? '';
    return Attributes.title.contains(name) ||
        Attributes.title.contains(property) ||
        Attributes.title.contains(itemprop);
  }

  bool _validMetaImageElement(Element meta) {
    // check meta tag contains image content
    var attr = meta.attributes;
    var name = attr['name'] ?? '';
    var property = attr['property'] ?? '';
    var itemprop = attr['itemprop'] ?? '';
    return Attributes.image.contains(name) ||
        Attributes.image.contains(property) ||
        Attributes.image.contains(itemprop);
  }
}
