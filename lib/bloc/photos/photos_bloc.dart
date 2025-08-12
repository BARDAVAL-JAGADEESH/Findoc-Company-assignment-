import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../api/api_client.dart';
import '../../models/photo.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final ApiClient apiClient;

  PhotosBloc({required this.apiClient}) : super(PhotosInitial()) {
    on<FetchPhotosEvent>(_onFetchPhotosEvent);
  }

  FutureOr<void> _onFetchPhotosEvent(
      FetchPhotosEvent event, Emitter<PhotosState> emit) async {
    emit(PhotosLoading());
    try {
      final photos = await apiClient.fetchPhotos();
      emit(PhotosLoaded(photos: photos));
    } catch (e) {
      emit(PhotosError(message: e.toString()));
    }
  }
}