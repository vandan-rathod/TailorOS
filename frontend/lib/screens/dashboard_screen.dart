import 'package:flutter/material.dart';
import 'dart:io';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  State<DashboardScreen> createState() => _DashboardScreenState();
}

class ShortcutCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ShortcutCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<ShortcutCard> createState() => _ShortcutCardState();
}

class _ShortcutCardState extends State<ShortcutCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
      },
      onExit: (_) {
        setState(() => isHovered = false);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 180,
          height: 180,
          transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: isHovered ? 15 : 5,
                spreadRadius: isHovered ? 12 : 0,
                color: Colors.black12,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 60),
              const SizedBox(height: 15),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool expanded;
  final VoidCallback onTap;

  const SideBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),

        child: Row(
          children: [
            Icon(icon),

            Expanded(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: expanded ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(label, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSideBarExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TailorOS"),

        actions: [
          const Center(child: Text("ANIL")),

          const SizedBox(width: 15),

          TextButton(
            onPressed: () {
              exit(0);
            },
            child: const Text("Logout"),
          ),

          const SizedBox(width: 10),
        ],
      ),
      body: Row(
        children: [
          MouseRegion(
            onEnter: (_) {
              setState(() {
                isSideBarExpanded = true;
              });
            },

            onExit: (_) {
              setState(() {
                isSideBarExpanded = false;
              });
            },

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),

              width: isSideBarExpanded ? 220 : 70,

              color: Colors.black12,

              child: Column(
                children: [
                  const SizedBox(height: 20),

                  SideBarItem(
                    icon: Icons.home_filled,
                    label: "dashboard",
                    expanded: isSideBarExpanded,
                    onTap: () {},
                  ),

                  SideBarItem(
                    icon: Icons.people_outline_outlined,
                    label: "Customers",
                    expanded: isSideBarExpanded,
                    onTap: () {},
                  ),

                  SideBarItem(
                    icon: Icons.shopping_bag,
                    label: "Orders",
                    expanded: isSideBarExpanded,
                    onTap: () {},
                  ),

                  SideBarItem(
                    icon: Icons.straighten,
                    label: "Measurements",
                    expanded: isSideBarExpanded,
                    onTap: () {},
                  ),

                  SideBarItem(
                    icon: Icons.pie_chart,
                    label: "Reports",
                    expanded: isSideBarExpanded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Card(
                    elevation: 4,

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),

                      child: TextField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "Search customers, orders, measurements...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 40),

                Wrap(
                  spacing: 25,
                  runSpacing: 25,
                  alignment: WrapAlignment.center,
                  children: [
                    ShortcutCard(
                      icon: Icons.people,
                      title: "Customers",
                      onTap: () {},
                    ),

                    ShortcutCard(
                      icon: Icons.straighten,
                      title: "Measurements",
                      onTap: () {},
                    ),

                    ShortcutCard(
                      icon: Icons.inventory,
                      title: "Orders",
                      onTap: () {},
                    ),

                    ShortcutCard(
                      icon: Icons.payments,
                      title: "Payments",
                      onTap: () {},
                    ),
                  ],
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
