import 'package:flutter/material.dart';
import '../models/kategori_model.dart';

class KategoriScreen extends StatefulWidget {
  const KategoriScreen({super.key});

  @override
  State<KategoriScreen> createState() => _KategoriScreenState();
}

class _KategoriScreenState extends State<KategoriScreen> {
  // Mock data to simulate the database
  final List<Kategori024> _kategoriList = [
    Kategori024(id: 'K001', nama: 'Elektronik', status: 'Aktif', keterangan: '10'),
    Kategori024(id: 'K002', nama: 'Pakaian', status: 'Aktif', keterangan: '20'),
    Kategori024(id: 'K003', nama: 'Makanan', status: 'Non-Aktif', keterangan: '5'),
  ];

  // Controllers for form fields
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

  void _resetForm() {
    _namaController.clear();
    _statusController.clear();
    _keteranganController.clear();
  }

  void _addKategori() {
    _resetForm();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Data Kategori024'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Nama Kategori', _namaController),
              const SizedBox(height: 10),
              _buildTextField('Status', _statusController),
              const SizedBox(height: 10),
              _buildTextField('Keterangan', _keteranganController, isNumber: true),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_namaController.text.isNotEmpty) {
                setState(() {
                  // Generate a simple ID
                  String newId = 'K${(_kategoriList.length + 1).toString().padLeft(3, '0')}';
                  _kategoriList.add(Kategori024(
                    id: newId,
                    nama: _namaController.text,
                    status: _statusController.text,
                    keterangan: _keteranganController.text,
                  ));
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data berhasil ditambahkan')),
                );
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _editKategori(Kategori024 item) {
    _namaController.text = item.nama;
    _statusController.text = item.status;
    _keteranganController.text = item.keterangan;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Data Kategori024'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Nama Kategori', _namaController),
              const SizedBox(height: 10),
              _buildTextField('Status', _statusController),
              const SizedBox(height: 10),
              _buildTextField('Keterangan', _keteranganController, isNumber: true),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                item.nama = _namaController.text;
                item.status = _statusController.text;
                item.keterangan = _keteranganController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data berhasil diubah')),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _deleteKategori(Kategori024 item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Yakin kode kategori024 ini dihapus?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              setState(() {
                _kategoriList.remove(item);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data berhasil dihapus')),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Kategori024'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header similar to card-header in AdminLTE
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Data Kategori024',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: _addKategori,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Data'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),

              // Table
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Kode')),
                        DataColumn(label: Text('Nama Kategori')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Keterangan')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: _kategoriList.asMap().entries.map((entry) {
                        int index = entry.key + 1;
                        Kategori024 item = entry.value;
                        return DataRow(cells: [
                          DataCell(Text(index.toString())),
                          DataCell(Text(item.id)),
                          DataCell(Text(item.nama)),
                          DataCell(Text(item.status)),
                          DataCell(Text(item.keterangan)),
                          DataCell(Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _editKategori(item),
                                icon: const Icon(Icons.edit, size: 16),
                                label: const Text('Edit'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  minimumSize: const Size(0, 30),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                onPressed: () => _deleteKategori(item),
                                icon: const Icon(Icons.delete, size: 16),
                                label: const Text('Hapus'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  minimumSize: const Size(0, 30),
                                ),
                              ),
                            ],
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
