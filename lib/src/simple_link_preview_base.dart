// TODO: Put public facing types in this file.

import 'package:simple_link_preview/src/data/link_preview_repo.dart';
import 'package:simple_link_preview/src/data/models/link_preview.model.dart';
import 'package:simple_link_preview/src/domain/repository/link_preview_repo.dart';

/// Public SimpleLinkPreview
class SimpleLinkPreview {
  static Future<LinkPreview?> getPreview(String url) {
    // use LinkPreviewRepoV1 to get LinkPreview
    LinkPreviewRepo repository = LinkPreviewRepoV1(url);
    return repository.getPreview();
  }
}
