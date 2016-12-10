#include "node.h"
#include "list.h"
#include "stdlib.h"

static dagon_node* dagon_node_new(dagon_node_t type) {
  dagon_node* node = malloc(sizeof(dagon_node));
  node->type = type;
  return node;
}

static dagon_node* dagon_ptr_node_new(dagon_node_t type, void* ptr) {
  dagon_node* node = dagon_node_new(type);
  node->v1.ptr = ptr;
  return node;
}

dagon_node* dagon_sval_node_new(dagon_node_t type, char* sval) {
  dagon_node* node = dagon_node_new(type);
  node->v1.sval = sval;
  return node;
}

dagon_node* dagon_list_node_new() {
  dagon_value list = dagon_list_new();
  return dagon_ptr_node_new(LIST_NODE, (void*) list);
}

dagon_node* dagon_class_definition_node_new(char* name, dagon_node* definitions) {
  dagon_node* node = dagon_node_new(CLASS_NODE);
  node->v1.sval = name;
  node->v2.ptr = definitions;
  return node;
}

dagon_node* dagon_method_definition_node_new(char* name, dagon_node* args, dagon_node* body) {
  dagon_node* node = dagon_node_new(METHOD_NODE);
  node->v1.sval = name;
  node->v2.ptr = args;
  node->v3.ptr = args;
  return node;
}

dagon_node* dagon_block_node_new(dagon_node* block) {
  return dagon_ptr_node_new(BLOCK_NODE, block);
}

dagon_node* dagon_string_node_new(char* str) {
  return dagon_sval_node_new(STRING_NODE, str);
}

dagon_node* dagon_assignment_node_new(dagon_node* lhs, dagon_node* rhs) {
  dagon_node* node = dagon_node_new(ASSIGN_NODE);
  node->v1.ptr = lhs;
  node->v2.ptr = rhs;
  return node;
}

dagon_node* dagon_variable_node_new(char* name) {
  return dagon_sval_node_new(VAR_NODE, name);
}

dagon_node* dagon_instance_variable_node_new(char* name) {
  return dagon_sval_node_new(IVAR_NODE, name);
}

dagon_node* dagon_class_new_node(char* klass, dagon_node* args) {
  dagon_node* node = dagon_node_new(OBJ_INIT_NODE);
  node->v1.sval = klass;
  node->v2.ptr = args;
  return node;
}

dagon_node* dagon_method_call_node(dagon_node* obj, char* method, dagon_node* args) {
  dagon_node* node = dagon_node_new(METHOD_CALL_NODE);
  node->v1.ptr = obj;
  node->v2.sval = method;
  node->v3.ptr = args;
  return node;
}

dagon_node* dagon_self_method_call_node(char* method, dagon_node* args) {
  dagon_node* node = dagon_node_new(SELF_METHOD_CALL_NODE);
  node->v1.sval = method;
  node->v2.ptr = args;
  return node;
}

void dagon_list_node_append(dagon_node* list_node, dagon_node* item) {
  dagon_list_append((dagon_value) list_node->v1.ptr, (dagon_value) item);
}
