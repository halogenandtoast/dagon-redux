#include <stdlib.h>
#include "list.h"
#include "dagon.h"

dagon_value dagon_list_new() {
  dagon_list* list = malloc(sizeof(dagon_list));
  list->len = 0;
  list->head = NULL;
  return (dagon_value) list;
}

void dagon_list_append(dagon_value list, dagon_value item) {
  dagon_list* _list = (dagon_list *) list;
  dagon_list_entry* entry = malloc(sizeof(dagon_list_entry));
  entry->item = item;
  entry->next = NULL;

  if(_list->head == NULL) {
    _list->head = entry;
  } else {
    dagon_list_entry* current = _list->head;
    while(current->next != NULL) {
      current = current->next;
    }
    current->next = entry;
  }

  _list->len++;
}
