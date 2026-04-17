import 'package:flutter/material.dart';
import '../services/admin_service.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _adminService = AdminService();
  List<String> _adminUIDs = [];
  int _adminCount = 0;

  @override
  void initState() {
    super.initState();
    _loadAdmins();
  }

  void _loadAdmins() async {
    final admins = await _adminService.getAdminList();
    setState(() {
      _adminUIDs = admins;
      _adminCount = admins.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Admin Stats
              Text(
                'Admin Management',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              
              // Admin Count Card
              Card(
                elevation: 2,
                color: Colors.red[50],
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Admins', style: TextStyle(color: Colors.grey[600])),
                          Text('$_adminCount / 6', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red[700])),
                        ],
                      ),
                      Icon(Icons.admin_panel_settings, size: 48, color: Colors.red[700]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              
              // Admin List
              Text(
                'Active Admins',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _adminUIDs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red[700],
                        child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
                      ),
                      title: Text('Admin ${index + 1}'),
                      subtitle: Text(_adminUIDs[index], style: TextStyle(fontSize: 10)),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => _removeAdmin(_adminUIDs[index]),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24),
              
              // Content Management
              Text(
                'Content Management',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              _buildAdminAction('Travel Ideas', 'Add/Edit/Delete travel ideas', Icons.flight_takeoff),
              _buildAdminAction('Rentals', 'Manage rental listings', Icons.home),
              _buildAdminAction('Stories', 'Publish/Review stories', Icons.book),
              _buildAdminAction('Photos', 'Moderate user photos', Icons.image),
              SizedBox(height: 24),
              
              // Audit Logs
              Text(
                'Audit Logs',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: Icon(Icons.history, color: Colors.blue[700]),
                  title: Text('View Admin Audit Logs'),
                  subtitle: Text('All admin actions logged'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => _showAuditLogs(),
                ),
              ),
              SizedBox(height: 24),
              
              // Export Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _exportAuditLogs,
                  icon: Icon(Icons.download),
                  label: Text('Export Audit Logs (CSV)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminAction(String title, String subtitle, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[700]),
        title: Text(title),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }

  void _removeAdmin(String uid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Admin'),
        content: Text('Are you sure you want to remove this admin?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')), 
          TextButton(
            onPressed: () async {
              await _adminService.removeAdmin(uid);
              _loadAdmins();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Admin removed')));
            },
            child: Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAuditLogs() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Audit Logs'),
        content: Text('Admin action logs will be displayed here'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))],
      ),
    );
  }

  void _exportAuditLogs() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Exporting audit logs...')));
  }
}