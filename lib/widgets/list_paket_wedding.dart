import 'package:admin/models/model_paket_wedding.dart';
import 'package:admin/providers/wedding_paket_provider.dart';
import 'package:admin/screens/paket_wedding/detail_paket_wedding_screen.dart';
import 'package:admin/utility/route_argument.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:admin/utility/client.dart' as client;

import '../../../utility/constants.dart';
import 'item_paket_wedding.dart';

class ListPaketWedding extends StatefulWidget {
  const ListPaketWedding({
    Key? key,
  }) : super(key: key);

  @override
  State<ListPaketWedding> createState() => _ListPaketWeddingState();
}

class _ListPaketWeddingState extends State<ListPaketWedding> {
  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      context.read<WeddingPaketProvider>().initPaketWedding();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExtendedImage.network(
          client.Client.baseImageUrl + "/uploads/2_f2cb97465d.jpeg",
          fit: BoxFit.cover,
          cache: true,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        SizedBox(height: defaultPadding),
        Text(
          "Bali Wedding Paket",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "The Wedding Package consists of details of things needed in a wedding event, such as catering, waiter team, boarding menu, make-up and clothing, documentation, entertainment (single organ, band, acoustics, dangdud etc.), Master of Ceremony (MC) , Decoration, Party Supplies.",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        SizedBox(height: defaultPadding),
        Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryPrimaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Paket Wedding",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // SizedBox(height: defaultPadding),
              // Chart(),
              Consumer<WeddingPaketProvider>(builder: (context, weddingPaketProvider, _) {
                return weddingPaketProvider.paketWedding.isEmpty
                    ? SizedBox.shrink()
                    : ListView.builder(
                        itemCount: weddingPaketProvider.paketWedding.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DetailPaketWeddingScreen.KEY,
                                arguments: RouteArgument<ModelPaketWedding>(
                                  passingData: weddingPaketProvider.paketWedding[index],
                                ),
                              );
                            },
                            child: ItemPaketWedding(
                              paketWedding: weddingPaketProvider.paketWedding[index],
                            ),
                          );
                        },
                      );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
