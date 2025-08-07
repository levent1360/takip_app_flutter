class PaginatedResponseModel<T> {
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final List<T> data;
  final List<String>? markalar;

  PaginatedResponseModel({
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.data,
    this.markalar,
  });

  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponseModel(
      totalCount: json['totalCount'] ?? 0,
      pageNumber: json['pageNumber'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => fromJsonT(item as Map<String, dynamic>))
              .toList() ??
          [],
      markalar: (json['markalar'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}
