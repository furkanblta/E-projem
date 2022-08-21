class Ktg {
  Ktg({required this.kategori_id, required this.kategori_ad});

  Ktg.fromJson(Map<String, Object?> json)
      : this(
          kategori_id: json['kategori_id']! as String,
          kategori_ad: json['kategori_ad']! as String,
        );

  final String kategori_id;
  final String kategori_ad;

  Map<String, Object?> toJson() {
    return {
      'kategori_id': kategori_id,
      'kategori_ad': kategori_ad,
    };
  }
}
