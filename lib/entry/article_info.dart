///
/// des: 文章
///
class ArticleInfo {
  ArticleInfo({this.title, this.url, this.author, this.type, this.time}) {
    if (time == null) {
      this.time = DateTime.now();
    }
  }

  String? title;
  String? url;
  String? author;
  ArticleType? type;
  DateTime? time;
}
enum ArticleType {news, technology}