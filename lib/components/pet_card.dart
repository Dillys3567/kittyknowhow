import 'package:flutter/material.dart';

class PetCard extends StatefulWidget {
  final String image;
  final String petName;
  final String petBreed;
  final String petAge;
  const PetCard(
      {super.key,
      required this.image,
      required this.petName,
      required this.petBreed,
      required this.petAge});

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(-6656375),
      child: Column(
        children: [
          Card(
              child: Image.asset(
            widget.image,
          )),
          ListTile(
            trailing: Icon(
              Icons.edit,
              color: Colors.white,
              size: 25,
            ),
            title: Text(
              widget.petName,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'IndieFlower',
                  fontWeight: FontWeight.w900,
                  fontSize: 25),
            ),
            subtitle: Text(
              '${widget.petBreed}\n${widget.petAge} years old',
              style: TextStyle(
                  color: Colors.white,
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
