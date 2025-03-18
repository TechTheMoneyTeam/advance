import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dto/post_dto.dart';
import '../providers/async_value.dart';
import '../providers/post_provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    final PostProvider1 postProvider = Provider.of<PostProvider1>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            
            onPressed: () => postProvider.fetchPost([1, 2, 3]),
            icon: const Icon(Icons.update),
          ),
        ],
      ),

 
      body: Center(child: _buildBody(postProvider)),
    );
  }

  Widget _buildBody(PostProvider1 postProvider) {
    final postValue = postProvider.postValue;

    if (postValue == null) {
      return const Text('Tap refresh to display posts');
    }

    switch (postValue.state) {
      case AsyncValueState.loading:
        return const CircularProgressIndicator();

      case AsyncValueState.error:
        return Text('Error: ${postValue.error}'); 

      case AsyncValueState.success:
        return PostList(posts: postValue.data!);
    }
  }
}

class PostList extends StatelessWidget {
  const PostList({super.key, required this.posts});

  final List<Post1> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index]);
      },
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post1 post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.body),
    );
  }
}
