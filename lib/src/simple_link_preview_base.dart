// TODO: Put public facing types in this file.

import 'data/link_preview_repo.dart';
import 'data/models/link_preview.model.dart';
import 'domain/repository/link_preview_repo.dart';

/// Public SimpleLinkPreview
class SimpleLinkPreview {
  /// use LinkPreviewRepoV1 to get LinkPreview
  static Future<LinkPreview?> getPreview(String url) {
    LinkPreviewRepo repository = LinkPreviewRepoV1(url);
    return repository.getPreview();
  }
}
