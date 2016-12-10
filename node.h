#ifndef _DAGON_NODE_H_
#define _DAGON_NODE_H_

typedef struct dagon_list {
  dagon_node* head;
  struct dagon_list* tail;
} dagon_list;

dagon_node* dagon_list_new();
dagon_node* dagon_class_definition_node_new(char*, dagon_node*);
dagon_node* dagon_method_definition_node_new(char*, dagon_node*, dagon_node*);
dagon_node* dagon_block_node_new(dagon_node*);
dagon_node* dagon_string_node_new(char*);
dagon_node* dagon_assignment_node_new(dagon_node*, dagon_node*);
dagon_node* dagon_variable_node_new(char*);
dagon_node* dagon_instance_variable_node_new(char*);
dagon_node* dagon_class_new_node(char*, dagon_node*);
dagon_node* dagon_method_call_node(dagon_node*, char*, dagon_node*);
dagon_node* dagon_self_method_call_node(char*, dagon_node*);
void dagon_list_append(dagon_node*, dagon_node*);

#endif
