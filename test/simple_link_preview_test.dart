import 'package:simple_link_preview/simple_link_preview.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Simple Link Preview', () async {
    var preview = await SimpleLinkPreview.getPreview('https://pub.dev/');
    expect(preview?.url, 'https://pub.dev/');
    expect(preview?.title?.isNotEmpty, true);
    expect(preview?.description?.isNotEmpty, true);
    expect(preview?.image?.isNotEmpty, true);
  });
}
