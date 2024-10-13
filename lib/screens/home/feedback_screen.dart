// lib/screens/home/feedback_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/feedback_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/feedback.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'general_comment';
  String? _text;

  @override
  Widget build(BuildContext context) {
    final feedbackProvider = Provider.of<FeedbackProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final token = authProvider.token; // May be null for anonymous feedback

    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Feedback'),
      ),
      body: feedbackProvider.isSubmitting
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _category,
                      decoration: InputDecoration(labelText: 'Category'),
                      items: [
                        {'value': 'bug_report', 'text': 'Bug Report'},
                        {'value': 'feature_request', 'text': 'Feature Request'},
                        {'value': 'general_comment', 'text': 'General Comment'},
                      ]
                          .map((item) => DropdownMenuItem(
                                child: Text(item['text']!),
                                value: item['value'],
                              ))
                          .toList(),
                      onChanged: (value) => _category = value!,
                    ),
                    CustomTextField(
                      labelText: 'Your Feedback',
                      maxLines: 5,
                      onSaved: (value) => _text = value,
                    ),
                    SizedBox(height: 16),
                    CustomButton(
                      text: 'Submit',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final feedback = FeedbackModel(
                            id: '',
                            userId: authProvider.user?.id,
                            category: _category,
                            text: _text!,
                            status: 'pending',
                            timestamp: DateTime.now(),
                          );
                          final success = await feedbackProvider.submitFeedback(
                              feedback, token);
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Feedback submitted. Thank you!')),
                            );
                            Navigator.pop(context);
                          } else {
                            // Handle submission failure
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Submission failed. Please try again.')),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
