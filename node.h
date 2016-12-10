#ifndef _DAGON_NODE_H_
#define _DAGON_NODE_H_

typedef enum {
  LIST_NODE,
  CLASS_NODE,
  METHOD_NODE,
  BLOCK_NODE,
  STRING_NODE,
  ASSIGN_NODE,
  VAR_NODE,
  IVAR_NODE,
  OBJ_INIT_NODE,
  METHOD_CALL_NODE,
  SELF_METHOD_CALL_NODE
} dagon_node_t;

typedef struct {
  dagon_node_t type;
  union {
    void* ptr;
    char* sval;
  } v1;
  union {
    void* ptr;
    char* sval;
  } v2;
  union {
    void* ptr;
  } v3;
} dagon_node;

dagon_node* dagon_list_node_new();
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
void dagon_list_node_append(dagon_node*, dagon_node*);

#endif
