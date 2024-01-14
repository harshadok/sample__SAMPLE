import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_phone_event.dart';
part 'add_phone_state.dart';
part 'add_phone_bloc.freezed.dart';

class AddPhoneBloc extends Bloc<AddPhoneEvent, AddPhoneState> {
  AddPhoneBloc() : super(_Initial()) {
    on<AddPhoneEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
