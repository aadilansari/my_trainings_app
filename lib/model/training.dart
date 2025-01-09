class Training {
  final String id;
  final String title;
  final String location;
  final String trainerName;
  final String date;
  final String time;
  final String status;
  final String venue;
  final String summary;
  final double rating;
  final String imageUrl;
  final double price;

  Training({
    required this.id,
    required this.title,
    required this.location,
    required this.trainerName,
    required this.date,
    required this.time,
    required this.status,
    required this.venue,
    required this.summary,
    required this.rating,
    required this.imageUrl,
    required this.price,
  });
  static List<Training> getSampleData() {
    return [
      Training(
        id: '1',
        title: 'Safe Scrum Master',
        location: 'West Des Moines',
        trainerName: 'Helen Gribble',
        date: 'Oct 11 - 13, 2019',
        time: '08:30 am - 12:30 pm',
        status: 'Filling Fast!',
        venue: 'Convention Hall, Greater Des Moines',
        summary: 'Learn the principles of Scrum and how to effectively implement them in your organization. This course covers agile methodologies, sprint planning, and team management.',
        rating: 4.6,
        imageUrl: 'https://picsum.photos/800/400',
        price: 825,
      ),
      Training(
        id: '2',
        title: 'Advanced Project Management',
        location: 'Chicago, IL',
        trainerName: 'Mark Johnson',
        date: 'Oct 15 - 17, 2019',
        time: '09:00 am - 01:00 pm',
        status: 'Early Bird',
        venue: 'Tech Hub Chicago',
        summary: 'Master advanced project management techniques and methodologies. Perfect for experienced project managers looking to enhance their skills.',
        rating: 4.8,
        imageUrl: 'https://picsum.photos/800/400',
        price: 950,
      ),
      Training(
        id: '3',
        title: 'Agile Development',
        location: 'Phoenix, AZ',
        trainerName: 'Sarah Smith',
        date: 'Oct 21 - 23, 2019',
        time: '10:00 am - 02:00 pm',
        status: 'Sold Out',
        venue: 'Tech Conference Center',
        summary: 'Understand the core principles of Agile development and learn how to implement them in your projects. This course covers Agile methodologies, sprint planning, and team management.',
        rating: 4.5,
        imageUrl: 'https://picsum.photos/800/400',
        price: 799,
      ),
      Training(
        id: '4',
        title: 'React Development',
        location: 'Dallas, TX',
        trainerName: 'Alex Brown',
        date: 'Oct 25 - 27, 2019',
        time: '11:00 am - 03:00 pm',
        status: 'Filling Fast!',
        venue: 'Tech Conference Center',
        summary: 'Learn React development from scratch. This course covers React components, state management, and advanced features like hooks and context API.',
        rating: 4.7,
        imageUrl: 'https://picsum.photos/800/400',
        price: 699,
      ),
      
      Training(
        id: '5',
        title: 'Data Science Bootcamp',
        location:  'San Diego, CA',
        trainerName: 'Emily Davis',
        date: 'Oct 30 - 31, 2019',
        time: '1:00 pm - 04:00 pm',
        status: 'Early Bird',
        venue: 'Tech Hub New York',
        summary:
            'Join our intensive data science bootcamp and learn the essentials of data analysis, visualization, and machine learning. This course is perfect for beginners and experienced professionals.',
        rating: 4.3,
        imageUrl: 'https://picsum.photos/800/400',
        price: 988,
      ),
      Training(
        id: '6',
        title: 'Flutter Bootcamp',
        location: 'San Francisco, CA',
        trainerName: 'Emily Davis',
        date: 'Oct 31 - Nov 1, 2019',
        time: '2:00 pm - 05:00 pm',
        status: 'Early Bird',
        venue: 'Tech Hub New York',
        summary:
            'Join our intensive flutter bootcamp and learn the essentials of mobile app development.',
        rating: 4.7,
        imageUrl: 'https://picsum.photos/800/400',
        price: 899,
      ),
      Training(
        id: '7',
        title: 'Learn time management',
        location: 'New York, ZK',
        trainerName: 'Emily Davis',
        date: 'Nov 1 - 2, 2019',
        time: '3:00 pm - 06:00 pm',
        status: 'Early Bird',
        venue: 'Tech Hub New York',
        summary:
            'Join our intensive time management bootcamp and learn the essentials of data analysis, visualization, and machine learning. This course is perfect for beginners and experienced professionals.',
        rating: 5.9,
        imageUrl: 'https://picsum.photos/800/400',
        price: 679,
      ),
     
    ];
  }

}
