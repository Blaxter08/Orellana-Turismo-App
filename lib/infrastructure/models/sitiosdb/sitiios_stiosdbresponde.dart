
class Fields {
  final Description description;
  final Description img;
  final Category category;
  final Description name;
  final Category services;

  Fields({
    required this.description,
    required this.img,
    required this.category,
    required this.name,
    required this.services,
  });

  factory Fields.fromMap(Map<String, dynamic> json) => Fields(
    description: Description.fromMap(json["description"]),
    img: Description.fromMap(json["img"]),
    category: Category.fromMap(json["category"]),
    name: Description.fromMap(json["name"]),
    services: Category.fromMap(json["services"]),
  );

  Map<String, dynamic> toMap() => {
    "description": description.toMap(),
    "img": img.toMap(),
    "category": category.toMap(),
    "name": name.toMap(),
    "services": services.toMap(),
  };
}

class Category {
  final ArrayValue arrayValue;

  Category({
    required this.arrayValue,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    arrayValue: ArrayValue.fromMap(json["arrayValue"]),
  );

  Map<String, dynamic> toMap() => {
    "arrayValue": arrayValue.toMap(),
  };
}

class ArrayValue {
  final List<Description> values;

  ArrayValue({
    required this.values,
  });

  factory ArrayValue.fromMap(Map<String, dynamic> json) => ArrayValue(
    values: List<Description>.from(json["values"].map((x) => Description.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "values": List<dynamic>.from(values.map((x) => x.toMap())),
  };
}

class Description {
  final String stringValue;

  Description({
    required this.stringValue,
  });

  factory Description.fromMap(Map<String, dynamic> json) => Description(
    stringValue: json["stringValue"],
  );

  Map<String, dynamic> toMap() => {
    "stringValue": stringValue,
  };
}
