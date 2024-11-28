import 'package:equatable/equatable.dart';

class FileDataDto extends Equatable {
  final String originalName;
  final String fileName;
  final String location;

  const FileDataDto({
    required this.originalName,
    required this.fileName,
    required this.location,
  });

  // Factory constructor to create an instance from a Map
  factory FileDataDto.fromMap(Map<String, dynamic> map) {
    return FileDataDto(
      originalName: map['originalname'] as String,
      fileName: map['filename'] as String,
      location: map['location'] as String,
    );
  }

  // Convert the instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'originalname': originalName,
      'filename': fileName,
      'location': location,
    };
  }

  @override
  List<Object?> get props => [originalName, fileName, location];
}
