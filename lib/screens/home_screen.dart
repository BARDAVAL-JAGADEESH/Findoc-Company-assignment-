import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../api/api_client.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/photos/photos_bloc.dart';
import '../models/photo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PhotosBloc(apiClient: ApiClient())
            ..add(FetchPhotosEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Gallery',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: BlocBuilder<PhotosBloc, PhotosState>(
          builder: (context, state) {
            if (state is PhotosLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PhotosError) {
              return Center(child: Text(state.message));
            } else if (state is PhotosLoaded) {
              return _buildPhotoList(state.photos);
            }
            return const Center(child: Text('No photos to display'));
          },
        ),
      ),
    );
  }

  Widget _buildPhotoList(List<Photo> photos) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                imageUrl: photo.downloadUrl,
                placeholder: (context, url) => Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: double.infinity,
                height: MediaQuery.of(context).size.width / photo.aspectRatio,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Photo by ${photo.author}',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${photo.width} × ${photo.height}',
                      style: GoogleFonts.montserrat(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}