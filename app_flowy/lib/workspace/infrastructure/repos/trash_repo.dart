import 'dart:async';
import 'dart:typed_data';
import 'package:app_flowy/workspace/domain/i_trash.dart';
import 'package:app_flowy/workspace/infrastructure/repos/helper.dart';
import 'package:dartz/dartz.dart';
import 'package:flowy_sdk/dispatch/dispatch.dart';
import 'package:flowy_sdk/protobuf/flowy-dart-notify/subject.pb.dart';
import 'package:flowy_sdk/protobuf/flowy-workspace-infra/trash_create.pb.dart';
import 'package:flowy_sdk/protobuf/flowy-workspace/errors.pb.dart';
import 'package:flowy_sdk/protobuf/flowy-workspace/observable.pb.dart';
import 'package:flowy_sdk/rust_stream.dart';

class TrashRepo {
  Future<Either<RepeatedTrash, WorkspaceError>> readTrash() {
    return WorkspaceEventReadTrash().send();
  }

  Future<Either<Unit, WorkspaceError>> putback(String trashId) {
    final id = TrashIdentifier.create()..id = trashId;

    return WorkspaceEventPutbackTrash(id).send();
  }

  Future<Either<Unit, WorkspaceError>> deleteViews(List<Tuple2<String, TrashType>> trashList) {
    final items = trashList.map((trash) {
      return TrashIdentifier.create()
        ..id = trash.value1
        ..ty = trash.value2;
    });

    final trashIdentifiers = TrashIdentifiers(items: items);
    return WorkspaceEventDeleteTrash(trashIdentifiers).send();
  }

  Future<Either<Unit, WorkspaceError>> restoreAll() {
    return WorkspaceEventRestoreAll().send();
  }

  Future<Either<Unit, WorkspaceError>> deleteAll() {
    return WorkspaceEventDeleteAll().send();
  }
}

class TrashListenerRepo {
  StreamSubscription<SubscribeObject>? _subscription;
  TrashUpdatedCallback? _trashUpdated;
  late WorkspaceNotificationParser _parser;

  void startListening({TrashUpdatedCallback? trashUpdated}) {
    _trashUpdated = trashUpdated;
    _parser = WorkspaceNotificationParser(callback: _bservableCallback);
    _subscription = RustStreamReceiver.listen((observable) => _parser.parse(observable));
  }

  void _bservableCallback(WorkspaceNotification ty, Either<Uint8List, WorkspaceError> result) {
    switch (ty) {
      case WorkspaceNotification.TrashUpdated:
        if (_trashUpdated != null) {
          result.fold(
            (payload) {
              final repeatedTrash = RepeatedTrash.fromBuffer(payload);
              _trashUpdated!(left(repeatedTrash.items));
            },
            (error) => _trashUpdated!(right(error)),
          );
        }
        break;
      default:
        break;
    }
  }

  Future<void> close() async {
    await _subscription?.cancel();
  }
}
