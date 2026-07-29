import 'package:flutter/material.dart';

class MentorHeaderCard extends StatelessWidget {
  final String name;
  final String designation;
  final String company;
  final double rating;
  final int experience;
  final int sessions;
  final int price;
  final String imageUrl;

  const MentorHeaderCard({
    super.key,
    required this.name,
    required this.designation,
    required this.company,
    required this.rating,
    required this.experience,
    required this.sessions,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF151B2E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(.08),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [

          Row(
            children: [

              Hero(
                tag: "mentor_profile",
                child: CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: null,
                  child: const Icon(
                    Icons.person,
                    size: 34,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(.18),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Icon(
                                Icons.verified,
                                color: Colors.green,
                                size: 15,
                              ),

                              SizedBox(width: 4),

                              Text(
                                "Verified",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      designation,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      company,
                      style: const TextStyle(
                        color: Color(0xFF4FC3F7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Row(
            children: [

              Expanded(
                child: _infoCard(
                  Icons.star,
                  rating.toString(),
                  Colors.amber,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _infoCard(
                  Icons.work_outline,
                  "$experience yrs",
                  Colors.green,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _infoCard(
                  Icons.people_outline,
                  "$sessions+",
                  Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF0F172A),
            ),
            child: Row(
              children: [

                const Icon(
                  Icons.currency_rupee,
                  color: Colors.green,
                ),

                Text(
                  "$price / Session",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "60 Minutes",
                    style: TextStyle(
                      color: Color(0xFF4FC3F7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(
      IconData icon,
      String value,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

          Icon(
            icon,
            color: color,
            size: 22,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}