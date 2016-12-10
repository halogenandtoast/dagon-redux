#ifndef _DAGON_H_
#define _DAGON_H_

typedef enum {
  STRING_NODE
} dagon_node_t;

typedef struct {
  dagon_node_t type;
} dagon_node;

typedef struct {
  dagon_node* node;
} dagon_env;

#endif
