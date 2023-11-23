class QuestionList {
  final List<Question>? questions;

  const QuestionList({
    this.questions,
  });

  factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class Question {
  final String? question;
  final Answers? answers;
  final String? questionImageUrl;
  final String? correctAnswer;
  final int? score;

  Question({
    this.question,
    this.answers,
    this.questionImageUrl,
    this.correctAnswer,
    this.score,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answers:
            json["answers"] == null ? null : Answers.fromJson(json["answers"]),
        questionImageUrl: json["questionImageUrl"],
        correctAnswer: json["correctAnswer"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answers": answers?.toJson(),
        "questionImageUrl": questionImageUrl,
        "correctAnswer": correctAnswer,
        "score": score,
      };
}

class Answers {
  final String? a;
  final String? b;
  final String? c;
  final String? d;

  Answers({
    this.a,
    this.b,
    this.c,
    this.d,
  });

  factory Answers.fromJson(Map<String, dynamic> json) => Answers(
        a: json["A"],
        b: json["B"],
        c: json["C"],
        d: json["D"],
      );

  Map<String, dynamic> toJson() => {
        "A": a,
        "B": b,
        "C": c,
        "D": d,
      };
}
