A library for Dart developers.

## Usage

A simple usage example:

```dart
import 'package:simple_link_preview/simple_link_preview.dart';

void main() async{
  var preview = await SimpleLinkPreview.getPreview('https://pub.dev');
  print('Link preview: $preview');
}
```

# The preview form:

```json
{
"url": "https://pub.dev/",
"title": "Dart packages",
"image": "https://pub.dev/static/img/pub-dev-icon-cover-image.png?hash=vg86r2r3mbs62hiv4ldop0ife5um2g5g",
"description": "Pub is the package manager for the Dart programming language, containing reusable libraries & packages for Flutter, AngularDart, and general Dart programs."
}
```


## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
