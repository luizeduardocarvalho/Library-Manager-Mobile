import 'package:flutter/material.dart';
import 'package:library_manager/constants.dart';

class ManageBookForm extends StatefulWidget {

  final Function(String bookCode, String lentToName) onSubmit;
  final bool isBorrow;

  ManageBookForm(this.onSubmit, this.isBorrow);

  @override
  _ManageBookFormState createState() => _ManageBookFormState();
}

class _ManageBookFormState extends State<ManageBookForm> {

  String _bookCode;
  String _lentToName;

  void _submit() {
    FocusScope.of(context).unfocus();
    widget.onSubmit(_bookCode, _lentToName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: kMenuCardButtonColor,
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  key: ValueKey('code'),
                  decoration: kInputFieldDecoration.copyWith(
                    labelText: 'Code'
                  ),
                  onChanged: (value) {
                    setState(() {
                      _bookCode = value;
                    });
                  },
                ),
                if(widget.isBorrow)
                TextFormField(
                  key: ValueKey('lend_to_name'),
                  decoration: kInputFieldDecoration.copyWith(
                      labelText: 'Lend to'
                  ),
                  onChanged: (value) {
                    setState(() {
                      _lentToName = value;
                    });
                  },
                ),
                SizedBox(height: 12.0,),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return kSenacBlueDarker;
                        return kSenacBlue; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: _submit,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
