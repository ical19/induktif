class SearchingModel {
  String? judul;
  String? model;
  String? owner;
  String? idLinkJudul;
  String? linkModel;
  String? linkOwner;
  Map<String, String>? headers;
  Map<String, String>? cookiesWeb;

  SearchingModel(
      {this.judul,
      this.model,
      this.owner,
      this.idLinkJudul,
      this.headers,
      this.cookiesWeb});
}
