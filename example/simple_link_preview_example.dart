import 'package:simple_link_preview/simple_link_preview.dart';

void main() async{
  var awesome = await SimpleLinkPreview.getPreview('https://www.google.com/');
  print('Link preview: $awesome');
}
