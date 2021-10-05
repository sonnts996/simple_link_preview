import 'package:simple_link_preview/simple_link_preview.dart';

void main() async{
  var preview = await SimpleLinkPreview.getPreview('https://pub.dev/');
  print('Link preview: $preview');
}
