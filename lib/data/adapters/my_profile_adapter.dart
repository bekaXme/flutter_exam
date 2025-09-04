import 'package:hive/hive.dart';
import '../models/my_profile_model.dart';

@HiveType(typeId: 1)
class MyProfileModelAdapter extends TypeAdapter<MyProfileModel> {
  @override
  final int typeId = 1;

  @override
  MyProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyProfileModel(
      username: fields[0] as String,
      profilePhoto: fields[1] as String,
      presentation: fields[2] as String,
      recipesCount: fields[3] as int,
      followingCount: fields[4] as int,
      followersCount: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MyProfileModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.profilePhoto)
      ..writeByte(2)
      ..write(obj.presentation)
      ..writeByte(3)
      ..write(obj.recipesCount)
      ..writeByte(4)
      ..write(obj.followingCount)
      ..writeByte(5)
      ..write(obj.followersCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MyProfileModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}