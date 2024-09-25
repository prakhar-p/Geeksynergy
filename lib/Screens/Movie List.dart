import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List movies = [];
  bool isLoading = true;
  String apiKey = '3cc0d8a9';

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  // Function to fetch movies from OMDb API
  Future<void> fetchMovies() async {
    final url = 'http://www.omdbapi.com/?apikey=$apiKey&s=batman&type=movie';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        movies = data['Search'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Home'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Company Info') {
                Navigator.pushNamed(context, '/company');
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Company Info'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                movie['Poster'] != "N/A"
                    ? movie['Poster']
                    : 'https://via.placeholder.com/92x138.png?text=No+Image',
                fit: BoxFit.cover,
              ),
              title: Text(movie['Title']),
              subtitle: Text('Year: ${movie['Year']}'),
            ),
          );
        },
      ),
    );
  }
}
