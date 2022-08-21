class kategoriler {
  String kategori_id;
  String kategori_ad;

  kategoriler(this.kategori_id, this.kategori_ad);

  factory kategoriler.fromJson(String key, Map<dynamic, dynamic> json) {
    return kategoriler(key, json["kategori_ad"] as String);
  }
}
