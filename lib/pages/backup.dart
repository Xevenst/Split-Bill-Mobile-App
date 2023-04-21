//              Padding(
//               padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
//               child: TextFormField(
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
//                 ],
//                 keyboardType: TextInputType.name,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Name',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//               child: TextFormField(
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
//                 ],
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   suffixText: "Rupiah",
//                   labelText: 'Bank Account No.',
//                 ),
//               ),
//             ),