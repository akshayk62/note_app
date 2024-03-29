import 'package:hive/hive.dart';
import 'package:note_2/models/todomodel.dart';


class Notoservice{

Box <Todo>? _notos;
 
 Future <void> openbox ()async {

  await Hive.openBox<Todo>('todos');  

 }

 Future <void> closebox () async{
       await _notos!.close();

 }


Future<void> add (Todo Noto  ) async{
if(_notos == null){
  await openbox();
}
else{
  await _notos!.add(Noto);
}

}

Future <List<Todo>> getall ()async{

  if(_notos == null){
    await openbox();
  }
  
     return _notos!.values.toList();
  
}

Future <void> update(Todo Noto , int index) async{
   
   if(_notos == null){
    await _notos!.close();
   }

   await _notos!.putAt(index, Noto);
}
 

 Future <void> delete(int index ) async{
  if(_notos == null){
await openbox();
  
  }
  else{
 await _notos!.deleteAt(index);

  }
 }


}

