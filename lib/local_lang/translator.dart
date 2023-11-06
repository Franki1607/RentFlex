import 'lang/fr_fr.dart';
import 'package:get/get.dart';

import 'lang/en_us.dart';

class Translator extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {'en_US': en_US, 'fr_FR': fr_FR};

}