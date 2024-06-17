class ImageModel {
  final int id;
  final String filename;
  final String filteredFilename;

  ImageModel({required this.id, required this.filename, required this.filteredFilename});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      filename: json['filename'],
      filteredFilename: json['filtered_filename'],
    );
  }
}
