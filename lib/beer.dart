class Beer {
  final int id;
  final String name;
  final String tagLine;
  final String description;
  final String imageUrl;

  Beer.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        name = jsonMap['name'],
        tagLine = jsonMap['tagline'],
        description = jsonMap['description'],
        imageUrl = jsonMap['image_url'];
}
