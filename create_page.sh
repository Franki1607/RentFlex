#!/bin/bash

# Vérifie si un argument a été fourni
if [ $# -eq 0 ]; then
  echo "Veuillez fournir un nom de page."
  exit 1
fi
model_name=$1

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  model_name_class_name="$(echo $model_name | sed 's/_\([a-z]\)/\U\1/g;s/^./\U&/')"
elif [[ "$OSTYPE" == "darwin23" ]]; then
  model_name_class_name=""
  for part in $(echo "$model_name" | tr '_' ' '); do
    model_name_class_name="${model_name_class_name}$(echo $part | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')"
  done
else
  echo $OSTYPE
  echo "Système d'exploitation non pris en charge."
  exit 1
fi


# Créer le dossier de la page
mkdir lib/pages/"$1"_page

# Créer le dossier de contrôleurs
mkdir lib/pages/"$1"_page/controllers

# Créer le fichier home_binding.dart avec le contenu spécifié
cat <<EOT > lib/pages/"$1"_page/controllers/"$1"_binding.dart
import 'package:get/get.dart';
import '${1}_controller.dart';

class ${model_name_class_name}Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${model_name_class_name}Controller>(() => ${model_name_class_name}Controller());
  }
}
EOT

# Créer le fichier home_controller.dart avec le contenu spécifié
cat <<EOT > lib/pages/"$1"_page/controllers/"$1"_controller.dart
import 'package:get/get.dart';

class ${model_name_class_name}Controller extends GetxController {
  void navigateBack() => Get.back();
}
EOT

# Créer le fichier index.dart avec le contenu spécifié
cat <<EOT > lib/pages/"$1"_page/index.dart
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/${1}_controller.dart';

class ${model_name_class_name}Page extends GetWidget<${model_name_class_name}Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<${model_name_class_name}Controller>(
          builder: (_) => Placeholder(),
        ));
  }
}
EOT

echo "La page $model_name_class_name a été créée avec succès."
