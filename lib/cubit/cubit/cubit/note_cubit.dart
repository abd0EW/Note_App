import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Models/Note.dart';
import 'package:meta/meta.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("Users");

  Future add(Note note) async {
    emit(NoteLoad());
    try {
      await collectionReference.add({
        "username": note.notes,
        "age": note.age,
        "iduser": FirebaseAuth.instance.currentUser!.uid,
      });

      emit(NoteSuccess(note: note));
    } catch (e) {
      emit(NoteFail(e.toString()));
    }
  }

  Future<QuerySnapshot<Object?>> getNotes() {
    return collectionReference
        .where("iduser", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  Future edit(Note note) async {
    emit(NoteLoad());
    try {
      await FirebaseFirestore.instance.collection("Notes").doc(note.id).update({
        "username": note.upd,
        "age": note.age,
        "iduser": FirebaseAuth.instance.currentUser!.uid,
      });
      emit(NoteSuccess(note: note));
    } catch (e) {
      emit(NoteFail(e.toString()));
    }
  }

  Future delete(Note note) async {
    emit(NoteLoad());
    try {
      await FirebaseFirestore.instance
          .collection("Notes")
          .doc(note.id)
          .delete();
      emit(NoteSuccess(note: note));
    } catch (e) {
      emit(NoteFail(e.toString()));
    }
  }
}
