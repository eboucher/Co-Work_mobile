import 'package:cowork_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';


class FormBlock extends StatefulWidget {
  @override
  _FormBlockState createState() => _FormBlockState();
}

class _FormBlockState extends State<FormBlock> {
  @override
  Widget build(BuildContext context) {
    return AllFieldsForm();
  }
}

class AllFieldsFormBloc extends FormBloc<String, String> {
  // ignore: close_sinks
  final text1 = TextFieldBloc();
  // ignore: close_sinks
  final boolean1 = BooleanFieldBloc();
  // ignore: close_sinks
  final boolean2 = BooleanFieldBloc();
  // ignore: close_sinks
  final select1 = SelectFieldBloc(
    items: ['Call Room', 'Cozy Lounge', 'Meeting Room'],
  );
  // ignore: close_sinks
  final select2 = SelectFieldBloc(
    items: ['Call Room', 'Cozy Lounge', 'Meeting Room'],
  );
  // ignore: close_sinks
  final multiSelect1 = MultiSelectFieldBloc<String, dynamic>(
    items: ['Call Room', 'Cozy Lounge', 'Meeting Room'],
  );
  // ignore: close_sinks
  final date1 = InputFieldBloc<DateTime, Object>();
  // ignore: close_sinks
  final dateAndTime1 = InputFieldBloc<DateTime, Object>();
  // ignore: close_sinks
  final time1 = InputFieldBloc<TimeOfDay, Object>();
  // ignore: close_sinks
  final time2 = InputFieldBloc<TimeOfDay, Object>();

  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      text1,
      boolean1,
      boolean2,
      select1,
      select2,
      multiSelect1,
      date1,
      dateAndTime1,
      time1,
      time2,
    ]);
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}

class AllFieldsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          // ignore: close_sinks
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xff2446a6),
                title: Text(APP_TITLE),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed:() => Navigator.pop(context),
                ),
              ),
              body: FormBlocListener<AllFieldsFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SuccessScreen()));
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse)));
                },

                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text1,
                          decoration: InputDecoration(
                            labelText: 'Location: République',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                        ),
                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.date1,
                          format: DateFormat('dd-mm-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: 'Booking date',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: TimeFieldBlocBuilder(
                                timeFieldBloc: formBloc.time1,
                                format: DateFormat('hh:mm a'),
                                initialTime: TimeOfDay.now(),
                                decoration: InputDecoration(
                                  labelText: 'Start',
                                  prefixIcon: Icon(Icons.access_time),
                                ),
                              ),
                            ),
                            Container(width: 10),
                            Expanded(
                              child: TimeFieldBlocBuilder(
                                timeFieldBloc: formBloc.time2,
                                format: DateFormat('hh:mm a'),
                                initialTime: TimeOfDay.now(),
                                decoration: InputDecoration(
                                  labelText: 'End',
                                  prefixIcon: Icon(Icons.access_time),
                                ),
                              ),
                            ),
                          ]
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select1,
                          decoration: InputDecoration(
                            labelText: 'Select room type',
                            prefixIcon: Icon(Icons.home_work_outlined),
                          ),
                          itemBuilder: (context, value) => value,
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select1,
                          decoration: InputDecoration(
                            labelText: 'Select room',
                            prefixIcon: Icon(Icons.home_work_outlined),
                          ),
                          itemBuilder: (context, value) => value,
                        ),
                        CheckboxGroupFieldBlocBuilder<String>(
                          multiSelectFieldBloc: formBloc.multiSelect1,
                          itemBuilder: (context, item) => item,
                          decoration: InputDecoration(
                            labelText: 'CheckboxGroupFieldBlocBuilder',
                            prefixIcon: SizedBox(),
                          ),
                        ),
                        SwitchFieldBlocBuilder(
                          booleanFieldBloc: formBloc.boolean2,
                          body: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('CheckboxFieldBlocBuilder'),
                          ),
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: formBloc.boolean1,
                          body: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('CheckboxFieldBlocBuilder'),
                          ),
                        ),
                        RaisedButton(
                            child: const Text(
                                'Book',
                                style: TextStyle(fontSize: 16)
                            ),
                            onPressed: null
                            ,
                            disabledTextColor: Colors.white60,
                            disabledColor: Colors.blueAccent
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (_) => LoadingDialog(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => AllFieldsForm())),
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
