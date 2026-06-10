class VideoLesson {
  final String title;
  final String duration;
  final String level;
  final bool isLocked;

  VideoLesson({required this.title, required this.duration, required this.level, required this.isLocked});
}

final List<VideoLesson> mockVideos = [
  VideoLesson(title: 'Introdução ao Alfabeto em Libras', duration: '12 min', level: 'Iniciante', isLocked: false),
  VideoLesson(title: 'Cumprimentos e Saudações', duration: '08 min', level: 'Iniciante', isLocked: false),
  VideoLesson(title: 'Expressões Faciais Gramaticais', duration: '15 min', level: 'Intermediário', isLocked: true),
  VideoLesson(title: 'Estrutura Sintática na Prática', duration: '22 min', level: 'Avançado', isLocked: true),
];
