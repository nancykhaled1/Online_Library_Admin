class UpdateBookRequest {

  String? name;
  int? numberOfCopies;
  int? numberInStock;
  String? publisher;
  String? writer;
  String? language;
  int? publishYear;
  String? edition;
  int? numPages;
  String? condition;
  int? weight;
  String? synopsis;
  String? mainImage;
  List<String>? gallery;

  UpdateBookRequest({
    this.name,
    this.mainImage,
    this.gallery,
     this.numberOfCopies,
     this.numberInStock,
     this.publisher,
     this.writer,
     this.language,
     this.publishYear,
     this.edition,
     this.synopsis,
     this.numPages,
     this.condition,
     this.weight,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['numberOfCopies'] = numberOfCopies;
    map['numberInStock'] = numberInStock;
    map['publisher'] = publisher;
    map['writer'] = writer;
    map['language'] = language;
    map['publishYear'] = publishYear;
    map['edition'] = edition;
    map['numPages'] = numPages;
    map['condition'] = condition;
    map['weight'] = weight;
    map['Synopsis'] = synopsis;
    map['mainImage'] = mainImage;
    map['gallery'] = gallery;
    return map;
  }

}
