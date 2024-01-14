part of 'add_phone_bloc.dart';

@freezed
class AddPhoneEvent with _$AddPhoneEvent {
  const factory AddPhoneEvent.started() = _Started;
}