class SearchListResponse {
  bool? status;
  List<SearchData>? data;
  String? message;

  SearchListResponse({this.status, this.data, this.message});

  factory SearchListResponse.fromJson(Map<String, dynamic> json) {
    return SearchListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List
          ? List<SearchData>.from(
              json['data'].map((e) => SearchData.fromJson(e)),
            )
          : [],
      message: json['message'] is String ? json['message'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}

class SearchData {
  int id;
  int userId;
  int profileId;
  String searchQuery;
  String type;
  int searchId;
  String fileUrl;

  SearchData({
    this.id = -1,
    this.userId = -1,
    this.profileId = -1,
    this.searchQuery = "",
    this.type = "",
    this.searchId = -1,
    this.fileUrl = "",
  });

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(
      id: _parseInt(json['id']),
      userId: _parseInt(json['user_id']),
      profileId: _parseInt(json['profile_id']),
      searchQuery: json['search_query'] is String ? json['search_query'] : "",
      type: json['type'] is String ? json['type'] : "",
      searchId: _parseInt(json['search_id']),
      fileUrl: json['file_url'] is String ? json['file_url'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'profile_id': profileId,
      'search_query': searchQuery,
      'type': type,
      'search_id': searchId,
      'file_url': fileUrl,
    };
  }

  // Helper method to safely parse int from dynamic value
  static int _parseInt(dynamic value) {
    if (value == null) return -1;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value) ?? -1;
    }
    if (value is num) return value.toInt();
    return -1;
  }
}
