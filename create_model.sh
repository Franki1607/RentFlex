#!/bin/bash

# Define list of attribute types
attribute_types=("int" "double" "String" "bool" "List<int>" "List<double>" "List<String>" "List<bool>" "List<dynamic>" "Other(specify)")

model_name=$1
hive_type_id=$2


# Ask for model name
if [ -z "$model_name" ]; then
  read -p "Enter model name: " model_name
fi

if [ -z "$hive_type_id" ]; then
  read -p "Enter hive type id: " hive_type_id
fi


model_name_class_name=""
for part in $(echo "$model_name" | tr '_' ' '); do
  model_name_class_name="${model_name_class_name}$(echo $part | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')"
done
echo "Creating $model_name_class_name model..."

# Start model definition
save_path="lib/models/"
model_definition="import 'package:hive/hive.dart';\n\n"
model_definition+="part '$model_name.g.dart';\n\n"
model_definition+="@HiveType(typeId: $hive_type_id)\n"
model_definition+="class $model_name_class_name {\n"

# Define fields
fields_definition=""

# Start constructor definition
constructor_definition="\n\n  $model_name_class_name({"

# Define fromMap factory method
from_map_definition="\n  factory $model_name_class_name.fromMap(Map<String, dynamic> map) {\n"
from_map_definition+="    return $model_name_class_name(\n"

# Define toMap method
to_map_definition="\n  Map<String, dynamic> toMap() {\n"
to_map_definition+="    return {\n"

# Ask for attributes until user enters empty value
while true; do
  # Ask for attribute name
  echo -e ""
  read -p "Enter attribute name (leave empty to finish): " attribute_name

  # Stop asking for attributes if user enters empty value
  if [ -z "$attribute_name" ]; then
    break
  fi

  # Ask user to select attribute type
  echo "Select attribute type for $attribute_name:"
  for i in "${!attribute_types[@]}"; do
    echo "$i. ${attribute_types[$i]}"
  done
  # Ask for attribute type number or Attribute type name and check number is less than attribute types length or attribut type name is not number
  while true; do
    read -p "Type number: " attribute_type_number
    if [[ "$attribute_type_number" =~ ^[0-9]+$ ]]; then
      if [ "$attribute_type_number" -lt "${#attribute_types[@]}" ]; then
        break
      fi
    else
      for i in "${!attribute_types[@]}"; do
        if [ "${attribute_types[$i]}" == "$attribute_type_number" ]; then
          attribute_type_number=$i
          break 2
        fi
      done
    fi
    echo "Invalid attribute type number"
  done

  if [ "$attribute_type_number" -eq "$[${#attribute_types[@]}-1]" ]; then
    read -p "\nEnter attribute type: " attribute_type
  else
    attribute_type=${attribute_types[$attribute_type_number]}
  fi

  # Ask if attribute is required
  read -p "Is $attribute_name required? (Y/n) " is_required
  if [[ "$is_required" != "n" ]]; then
    is_required=true
  else
    is_required=false
  fi

  # Define field
  field_definition="\n  @HiveField(${fields_count:=0})"
  field_definition+="\n  $attribute_type ${attribute_name};"

  # Add field to model definition
  model_definition+="$field_definition"

  # Add field to constructor definition
  constructor_definition+="${is_required:+required }this.$attribute_name,"

  # Add field to fromMap factory method
  from_map_definition+="      ${attribute_name}: map['$attribute_name'],\n"

  # Add field to toMap method
  to_map_definition+="      '${attribute_name}': $attribute_name,\n"

  ((fields_count++))
done

# End constructor definition
constructor_definition+="});"

# End model definition
model_definition+="$constructor_definition\n"

# End fromMap factory method
from_map_definition+="    );\n  }\n"

# End toMap method
to_map_definition+="    };\n  }\n"

# Add fromMap and toMap methods to model definition
model_definition+="$from_map_definition"
model_definition+="$to_map_definition"
model_definition+="}"

# Create model file
echo -e "$model_definition" > "$save_path$model_name.dart"

echo "Model created successfully!"