import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/select_contacts/repository/select_contact_repository.dart';

final getContactsProvider = FutureProvider((ref){
final selectContactRepository = ref.watch(selectContactRepositoryProvider);
return selectContactRepository.getContacts();
});

final selectContactController = Provider((ref){
  
  final selectContactRepository = ref.watch(selectContactRepositoryProvider);

  return SelectContactController(
    ref: ref,
    selectContactRepository: selectContactRepository);

});

class SelectContactController{
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;

  SelectContactController({
    required this.ref,
    required this.selectContactRepository});

    void slectContact(Contact selectedContact, BuildContext context){
      selectContactRepository.selectContact(selectedContact, context);
    }



}
