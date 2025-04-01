

class MovieScreenItem {
  final bool adult;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  final String link;

  const MovieScreenItem( {required this.link, required this.adult, required this.originalLanguage, required this.originalTitle, required this.overview, required this.popularity, required this.posterPath, required this.title, required this.video, required this.voteAverage, required this.voteCount, });

}

const movieRouter = <MovieScreenItem>[
MovieScreenItem(
  link: '/movie',
adult: true, 
originalLanguage: 'originalLanguage' , 
originalTitle: 'originalTitle', 
overview: 'overview', 
popularity: 5, 
posterPath: 'posterPath', 

title: 'title', 
video: true, 
voteAverage: 10, 
voteCount: 10)
];