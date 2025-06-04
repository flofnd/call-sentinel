// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_summary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CallSummaryAdapter extends TypeAdapter<CallSummary> {
  @override
  final int typeId = 0;

  @override
  CallSummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CallSummary(
      caller: fields[0] as String,
      summary: fields[1] as String,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CallSummary obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.caller)
      ..writeByte(1)
      ..write(obj.summary)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallSummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
