part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoad extends NoteState {}

final class NoteSuccess extends NoteState {
  Note? note;
  NoteSuccess({required this.note});
}

final class NoteFail extends NoteState {
  String fail;
  NoteFail(this.fail);
}
