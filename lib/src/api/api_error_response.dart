import 'dart:convert';

// abstract class ApiError {
//   ApiError(this.status, this.title, this.traceId, this.type);

//   final int status;
//   final String title;
//   final String traceId;
//   final String type;
// }

class ApiErrorResponse {
  int status;
  String title;
  String traceId;
  String type;
  ApiErrorResponse({
    required this.status,
    required this.title,
    required this.traceId,
    required this.type,
  });

  ApiErrorResponse copyWith({
    int? status,
    String? title,
    String? traceId,
    String? type,
  }) {
    return ApiErrorResponse(
      status: status ?? this.status,
      title: title ?? this.title,
      traceId: traceId ?? this.traceId,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'title': title,
      'traceId': traceId,
      'type': type,
    };
  }

  factory ApiErrorResponse.fromMap(Map<String, dynamic> map) {
    return ApiErrorResponse(
      status: map['status'] as int,
      title: map['title'] as String,
      traceId: map['traceId'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiErrorResponse.fromJson(String source) =>
      ApiErrorResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ApiErrorResponse(status: $status, title: $title, traceId: $traceId, type: $type)';
  }

  @override
  bool operator ==(covariant ApiErrorResponse other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.title == title &&
        other.traceId == traceId &&
        other.type == type;
  }

  @override
  int get hashCode {
    return status.hashCode ^ title.hashCode ^ traceId.hashCode ^ type.hashCode;
  }
}
