import 'package:flutter/material.dart';

void main() {
  runApp(MeuTodoListApp());
}

class MeuTodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List 💜',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.purple.shade50,
      ),
      home: TodoListHomePage(),
    );
  }
}

// Classe modelo Tarefa
class Tarefa {
  String titulo;
  bool concluida;

  Tarefa({required this.titulo, this.concluida = false});
}

class TodoListHomePage extends StatefulWidget {
  @override
  _TodoListHomePageState createState() => _TodoListHomePageState();
}

class _TodoListHomePageState extends State<TodoListHomePage> {
  List<Tarefa> tarefas = [];
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  
  String _filtroAtual = 'Todas';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _adicionarTarefa() {
    if (_controller.text.trim().isEmpty) return;

    final novaTarefa = Tarefa(titulo: _controller.text.trim());

    setState(() {
      tarefas.insert(0, novaTarefa);
    });

    _listKey.currentState?.insertItem(0, duration: Duration(milliseconds: 300));
    _controller.clear();
  }

  void _alternarConcluida(int index, bool? valor) {
    setState(() {
      tarefas[index].concluida = valor ?? false;
    });
  }

  void _removerTarefa(int index) {
    final tarefaRemovida = tarefas[index];
    
    setState(() {
      tarefas.removeAt(index);
    });
    
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItemCard(tarefaRemovida, animation, index),
      duration: Duration(milliseconds: 300),
    );
  }

  void _limparConcluidas() {
    for (int i = tarefas.length - 1; i >= 0; i--) {
      if (tarefas[i].concluida) {
        _removerTarefa(i);
      }
    }
  }

  void _editarTarefa(int index) {
    TextEditingController editController = TextEditingController(text: tarefas[index].titulo);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('✏️ Editar Tarefa', style: TextStyle(color: Colors.deepPurple)),
          content: TextField(
            controller: editController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Novo título... ✨',
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('❌ Cancelar', style: TextStyle(color: Colors.pinkAccent)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              onPressed: () {
                if (editController.text.trim().isNotEmpty) {
                  setState(() {
                    tarefas[index].titulo = editController.text.trim();
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('💾 Salvar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItemCard(Tarefa tarefa, Animation<double> animation, int index) {
    if (_filtroAtual == 'Pendentes' && tarefa.concluida) return SizedBox.shrink();
    if (_filtroAtual == 'Concluídas' && !tarefa.concluida) return SizedBox.shrink();

    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // Cores suaves combinando com o tema
        color: tarefa.concluida ? Colors.purple.shade100 : Colors.white,
        elevation: tarefa.concluida ? 0 : 3,
        shadowColor: Colors.deepPurple.shade200,
        child: ListTile(
          leading: Checkbox(
            activeColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            value: tarefa.concluida,
            onChanged: (valor) => _alternarConcluida(index, valor),
          ),
          title: Text(
            tarefa.titulo,
            style: TextStyle(
              decoration: tarefa.concluida ? TextDecoration.lineThrough : TextDecoration.none,
              color: tarefa.concluida ? Colors.deepPurple.shade300 : Colors.deepPurple.shade900,
              fontWeight: tarefa.concluida ? FontWeight.normal : FontWeight.w600,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit_note, color: Colors.deepPurpleAccent),
                tooltip: 'Editar',
                onPressed: () => _editarTarefa(index),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.pinkAccent),
                tooltip: 'Remover',
                onPressed: () => _removerTarefa(index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int total = tarefas.length;
    int concluidas = tarefas.where((t) => t.concluida).length;
    int pendentes = total - concluidas;

    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Tarefas 📝', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep_rounded),
            onPressed: concluidas > 0 ? _limparConcluidas : null, 
            tooltip: 'Limpar Concluídas 🧹',
          ),
        ],
      ),
      body: Column(
        children: [
          // Painel de Estatísticas
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24), 
                bottomRight: Radius.circular(24)
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('📊 Total: $total', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('⏳ Pendentes: $pendentes', style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
                    Text('✅ Feitas: $concluidas', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🔍 Mostrar: ', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade400,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: DropdownButton<String>(
                        value: _filtroAtual,
                        dropdownColor: Colors.deepPurple.shade400,
                        iconEnabledColor: Colors.white,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        underline: SizedBox(), // Remove a linha padrão
                        items: ['Todas', 'Pendentes', 'Concluídas'].map((String valor) {
                          return DropdownMenuItem<String>(
                            value: valor,
                            child: Text(valor),
                          );
                        }).toList(),
                        onChanged: (novoValor) {
                          setState(() {
                            _filtroAtual = novoValor!;
                          });
                          if (_listKey.currentState != null) {
                             _listKey.currentState!.setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Campo de Texto
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.deepPurple.shade900),
                    decoration: InputDecoration(
                      hintText: 'Qual é a próxima tarefa? 🚀',
                      hintStyle: TextStyle(color: Colors.deepPurple.shade300),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                    onSubmitted: (_) => _adicionarTarefa(),
                  ),
                ),
                SizedBox(width: 12),
                FloatingActionButton(
                  backgroundColor: Colors.deepPurpleAccent,
                  onPressed: _adicionarTarefa,
                  child: Icon(Icons.add_task),
                  elevation: 4,
                  tooltip: 'Adicionar ✨',
                ),
              ],
            ),
          ),
          
          // Lista de Tarefas
          Expanded(
            child: tarefas.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('📭', style: TextStyle(fontSize: 48)),
                        SizedBox(height: 16),
                        Text(
                          'Tudo tranquilo por aqui! ✨',
                          style: TextStyle(fontSize: 18, color: Colors.deepPurple.shade300, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                : AnimatedList(
                    key: _listKey,
                    initialItemCount: tarefas.length,
                    padding: EdgeInsets.only(bottom: 20),
                    itemBuilder: (context, index, animation) {
                      return _buildItemCard(tarefas[index], animation, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
