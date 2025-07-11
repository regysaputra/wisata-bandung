import 'package:flutter/material.dart';
import 'package:wisatabandung/model/tourism_place.dart';

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  const DetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 800) {
        return DetailWebPage(place: place);
      } else {
        return DetailMobilePage(place: place);
      }
    });
  }
}

class DetailMobilePage extends StatelessWidget {
  final TourismPlace place;
  const DetailMobilePage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image.asset(place.imageAsset),
                        SafeArea(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.arrow_back, color: Colors.white)
                                        )
                                    ),
                                    const FavoriteButton()
                                  ],
                                )
                            )
                        )
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          place.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'Staatliches',
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Icon(Icons.calendar_today),
                                SizedBox(height: 8.0),
                                Text(place.openDays)
                              ],
                            ),
                            Column(children: <Widget>[
                              Icon(Icons.access_time),
                              SizedBox(height: 8.0),
                              Text(place.openTime)
                            ],),
                            Column(children: <Widget>[
                              Icon(Icons.paid),
                              SizedBox(height: 8.0),
                              Text(place.ticketPrice)
                            ],),
                          ]),
                    ),
                    Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          place.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        )
                    ),
                    Container(
                        height: 150,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: place.imageUrls.map((url) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(url),
                                ),
                              );
                            }).toList()
                        )
                    )
                  ]
              )
          ),
        )
    );
  }
}

class DetailWebPage extends StatefulWidget {
  final TourismPlace place;
  DetailWebPage({super.key, required this.place});

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 64
        ),
        child: Center(
          child: SizedBox(
            width: 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Wisata Bandung',
                  style: TextStyle(
                      fontFamily: 'Staatliches',
                      fontSize: 32
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(widget.place.imageAsset),
                            ),
                            const SizedBox(height: 10),
                            Scrollbar(
                              controller: _scrollController,
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.only(bottom: 16),
                                child: ListView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  children: widget.place.imageUrls.map((url) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(url),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                    const SizedBox(width: 32),
                    Expanded(child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              widget.place.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'Staatliches'
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: <Widget>[
                                    const Icon(Icons.calendar_today),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      widget.place.openDays,
                                    )
                                  ],
                                ),
                                const FavoriteButton()
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const Icon(Icons.access_time),
                                const SizedBox(width: 8.0),
                                Text(
                                  widget.place.openTime,
                                )
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: <Widget>[
                                const Icon(Icons.monetization_on),
                                const SizedBox(width: 8.0),
                                Text(
                                  widget.place.ticketPrice,
                                )
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                widget.place.description,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Oxygen'
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        )
      )
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}


class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
    );
  }
}