import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

@freezed
class UserResponse with _$UserResponse {
  factory UserResponse({
    @JsonKey(name: 'items') List<User>? users,
    @JsonKey(name: 'total_count') int? totalCount,
    @JsonKey(name: 'incomplete_results') bool? incompleteResults,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
