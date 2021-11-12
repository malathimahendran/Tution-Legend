class Watchedvideos{
  String videoid;
  int duration;
  Watchedvideos( {required this.videoid, required this.duration}) ;
  Map<String, dynamic> toMap() {
    return {
      'videoid': videoid,
      'duration': duration,
    };
  }
}