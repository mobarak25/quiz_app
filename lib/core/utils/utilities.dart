import 'package:image_picker/image_picker.dart';

bool isNumeric(String s) {
  if (s == '') {
    return false;
  }
  return double.tryParse(s) != null;
}

class ImageFile {
  const ImageFile({required this.name, required this.file});

  final String name;
  final XFile file;
}

class VisitImage {
  const VisitImage({required this.id, required this.img});

  final int id;
  final String img;
}

// String svgUrl(String name) {
//   return "assets/images/svg/$name.svg";
// }

// String pngUrl(String name) {
//   return "assets/images/$name.png";
// }
