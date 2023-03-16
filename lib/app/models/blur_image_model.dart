// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BlurImage {
  final String hash;
  final String url;

  BlurImage({
    required this.hash,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hash': hash,
      'url': url,
    };
  }

  factory BlurImage.fromMap(Map<String, dynamic> map) {
    return BlurImage(
      hash: map['hash'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BlurImage.fromJson(String source) => BlurImage.fromMap(json.decode(source) as Map<String, dynamic>);
}
