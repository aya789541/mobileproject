import 'package:flutter/material.dart';

class MatrixQuestion {
  final int iD;
  final String question;
  final Map<String, dynamic> spec;
  final int next;

  MatrixQuestion({
    required this.iD,
    required this.question,
    required this.spec,
    required this.next,
  });
}

class MatrixQuestionWidget extends StatefulWidget {
  final MatrixQuestion question;
  final Function(String, dynamic) onSaveResponse;

  const MatrixQuestionWidget(
      {Key? key, required this.question, required this.onSaveResponse})
      : super(key: key);

  @override
  _MatrixQuestionWidgetState createState() => _MatrixQuestionWidgetState();
}

class _MatrixQuestionWidgetState extends State<MatrixQuestionWidget> {
  Map<String, Set<String>> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    // Initialise la map des options sélectionnées avec des ensembles vides pour chaque ligne
    for (var row in widget.question.spec['rows']) {
      selectedOptions[row] = <String>{};
    }
  }

  void updateResponse(String row, String col, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedOptions[row]?.add(col);
      } else {
        selectedOptions[row]?.remove(col);
      }
      // Appelle onSaveResponse avec l'ID de la question et les options sélectionnées mises à jour
      widget.onSaveResponse(widget.question.iD.toString(), selectedOptions);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Titre de la question centré
    Widget questionTitle = Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          widget.question.question,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );

    // Crée les lignes du tableau pour la grille de la matrice
    List<TableRow> tableRows = [
      TableRow(
        children: [
          const SizedBox(
              width: 120), // Espace pour l'alignement du nom de la ligne
          for (var col in widget.question.spec['columns'])
            Text(
              col,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
        ],
      ),
    ];

    // Lignes de cases à cocher
    for (var row in widget.question.spec['rows']) {
      List<Widget> rowWidgets = [
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(row, style: const TextStyle(fontSize: 16)),
        ),
      ];

      for (var col in widget.question.spec['columns']) {
        rowWidgets.add(
          TableCell(
            child: Checkbox(
              value: selectedOptions[row]?.contains(col) ?? false,
              onChanged: (bool? value) {
                updateResponse(row, col, value ?? false);
              },
            ),
          ),
        );
      }

      tableRows.add(TableRow(children: rowWidgets));
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          questionTitle,
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: tableRows,
          ),
        ],
      ),
    );
  }
}
