class UserModel {
  final int userId;
  final double height;
  final double weight;
  final int createTime;

  UserModel(this.userId, this.height, this.weight, this.createTime);

  factory UserModel.fromJson(dynamic json) => UserModel(
      json["userId"], json["height"], json["weight"], json["createTime"]);

  @override
  String toString() {
    return 'UserModel{userId: $userId, height: $height, weight: $weight, createTime: $createTime}';
  }
}
