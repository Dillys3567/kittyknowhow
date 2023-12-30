import 'package:flutter/material.dart';

class PetCard extends StatefulWidget {
  final String image;
  final String petName;
  final String petBreed;
  final String petAge;
  final String bio;
  final callback;
  final pictureCallback;
  const PetCard({
    super.key,
    required this.image,
    required this.petName,
    required this.petBreed,
    required this.petAge,
    required this.callback,
    required this.pictureCallback,
    this.bio = "",
  });

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(-6656375), width: 5),
          borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Column(
        children: [
          MaterialButton(
            onPressed: () {},
            onLongPress: widget.pictureCallback,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage.assetNetwork(
                    width: MediaQuery.of(context).size.width * 0.88,
                    height: MediaQuery.of(context).size.width * 0.88,
                    placeholder: 'assets/images/pawprint.png',
                    fit: BoxFit.fitHeight,
                    image: widget.image),
              ),
            ),
          ),
          ListTile(
            trailing: IconButton(
              onPressed: widget.callback,
              icon: Icon(
                Icons.edit,
                color: Color(-6656375),
                size: 25,
              ),
            ),
            title: Text(
              widget.petName,
              style: TextStyle(
                  color: Color(-6656375),
                  fontFamily: 'IndieFlower',
                  fontWeight: FontWeight.w900,
                  fontSize: 25),
            ),
            subtitle: Text(
              '${widget.petBreed}\n${widget.petAge} years old\n${widget.bio}',
              style: TextStyle(
                  color: Color(-6656375),
                  fontFamily: 'IndieFlower',
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
