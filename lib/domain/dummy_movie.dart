class DummyMovies {
  final String title;
  final String imageSource;

  DummyMovies(
    this.title,
    this.imageSource,
  );
}

List<DummyMovies> dummyData = [
  DummyMovies("Guardians of Galaxy", "assets/images/download.jpg"),
  DummyMovies("Thor: Love and Thunder", "assets/images/download.png"),
  DummyMovies("Avanger: End Game", "assets/images/download (1).jpg"),
  DummyMovies(
      "Harry Potter and The Secret Chamber", "assets/images/download (2).jpg"),
];
