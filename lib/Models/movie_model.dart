class Movie {
  String name;
  String year;
  String duration;
  String rating;
  String imagePath;
  bool favourite;

  Movie({
    required this.name,
    required this.year,
    required this.duration,
    required this.rating,
    required this.imagePath,
    required this.favourite,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json["title"],
      year: json["year"],
      duration: json["timeline"],
      rating: json["rating"],
      imagePath: json["image"],
      favourite: false,
    );
  }
}
