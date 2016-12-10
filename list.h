#ifndef _DAGON_LIST_H_
#define _DAGON_LIST_H_

#include "dagon.h"

typedef struct dagon_list_entry {
  dagon_value item;
  struct dagon_list_entry* next;
} dagon_list_entry;

typedef struct dagon_list {
  int len;
  dagon_list_entry* head;
} dagon_list;

dagon_value dagon_list_new();
void dagon_list_append(dagon_value, dagon_value);

#endif
