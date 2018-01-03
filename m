From: Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 4/4] bpf: inhibit speculated out-of-bounds pointers
Date: Wed,  3 Jan 2018 22:38:27 +0000
Message-ID: <20180103223827.39601-5-mark.rutland@arm.com>
References: <20180103223827.39601-1-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103223827.39601-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Under speculation, CPUs may mis-predict branches in bounds checks. Thus,
memory accesses under a bounds check may be speculated even if the
bounds check fails, providing a primitive for building a side channel.

The EBPF map code has a number of such bounds-checks accesses in
map_lookup_elem implementations. This patch modifies these to use the
nospec helpers to inhibit such side channels.

The JITted lookup_elem implementations remain potentially vulnerable,
and are disabled (with JITted code falling back to the C
implementations).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/bpf/arraymap.c | 21 ++++++++++++++-------
 kernel/bpf/cpumap.c   |  8 +++++---
 kernel/bpf/devmap.c   |  6 +++++-
 kernel/bpf/sockmap.c  |  6 +++++-
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 7c25426d3cf5..5090636da2c1 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -117,15 +117,20 @@ static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
+	void *ptr, *high;
 
 	if (unlikely(index >= array->map.max_entries))
 		return NULL;
 
-	return array->value + array->elem_size * index;
+	ptr = array->value + array->elem_size * index;
+	high = array->value + array->elem_size * array->map.max_entries;
+
+	return nospec_ptr(ptr, array->value, high);
 }
 
 /* emit BPF instructions equivalent to C code of array_map_lookup_elem() */
-static u32 array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+static u32 __maybe_unused array_map_gen_lookup(struct bpf_map *map,
+					       struct bpf_insn *insn_buf)
 {
 	struct bpf_insn *insn = insn_buf;
 	u32 elem_size = round_up(map->value_size, 8);
@@ -153,11 +158,15 @@ static void *percpu_array_map_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
+	void __percpu **pptrs, __percpu **high;
 
 	if (unlikely(index >= array->map.max_entries))
 		return NULL;
 
-	return this_cpu_ptr(array->pptrs[index]);
+	pptrs = array->pptrs + index;
+	high = array->pptrs + array->map.max_entries;
+
+	return this_cpu_ptr(nospec_load(pptrs, array->pptrs, high));
 }
 
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
@@ -302,7 +311,6 @@ const struct bpf_map_ops array_map_ops = {
 	.map_lookup_elem = array_map_lookup_elem,
 	.map_update_elem = array_map_update_elem,
 	.map_delete_elem = array_map_delete_elem,
-	.map_gen_lookup = array_map_gen_lookup,
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
@@ -610,8 +618,8 @@ static void *array_of_map_lookup_elem(struct bpf_map *map, void *key)
 	return READ_ONCE(*inner_map);
 }
 
-static u32 array_of_map_gen_lookup(struct bpf_map *map,
-				   struct bpf_insn *insn_buf)
+static u32 __maybe_unused array_of_map_gen_lookup(struct bpf_map *map,
+						  struct bpf_insn *insn_buf)
 {
 	u32 elem_size = round_up(map->value_size, 8);
 	struct bpf_insn *insn = insn_buf;
@@ -644,5 +652,4 @@ const struct bpf_map_ops array_of_maps_map_ops = {
 	.map_fd_get_ptr = bpf_map_fd_get_ptr,
 	.map_fd_put_ptr = bpf_map_fd_put_ptr,
 	.map_fd_sys_lookup_elem = bpf_map_fd_sys_lookup_elem,
-	.map_gen_lookup = array_of_map_gen_lookup,
 };
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index ce5b669003b2..52831b101d35 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -551,13 +551,15 @@ void cpu_map_free(struct bpf_map *map)
 struct bpf_cpu_map_entry *__cpu_map_lookup_elem(struct bpf_map *map, u32 key)
 {
 	struct bpf_cpu_map *cmap = container_of(map, struct bpf_cpu_map, map);
-	struct bpf_cpu_map_entry *rcpu;
+	struct bpf_cpu_map_entry **ptr, **high;
 
 	if (key >= map->max_entries)
 		return NULL;
 
-	rcpu = READ_ONCE(cmap->cpu_map[key]);
-	return rcpu;
+	ptr = cmap->cpu_map + key;
+	high = cmap->cpu_map + map->max_entries;
+
+	return READ_ONCE(*nospec_ptr(ptr, cmap->cpu_map, high));
 }
 
 static void *cpu_map_lookup_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index ebdef54bf7df..23b2b0547304 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -250,11 +250,15 @@ struct net_device  *__dev_map_lookup_elem(struct bpf_map *map, u32 key)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *dev;
+	struct bpf_dtab_netdev **ptr, **high;
 
 	if (key >= map->max_entries)
 		return NULL;
 
-	dev = READ_ONCE(dtab->netdev_map[key]);
+	ptr = dtab->netdev_map + key;
+	high = dtab->netdev_map + map->max_entries;
+
+	dev = READ_ONCE(*nospec_ptr(ptr, dtab->netdev_map, high));
 	return dev ? dev->dev : NULL;
 }
 
diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 5ee2e41893d9..ea59f6737751 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -626,11 +626,15 @@ static int sock_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 struct sock  *__sock_map_lookup_elem(struct bpf_map *map, u32 key)
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
+	struct sock **ptr, **high;
 
 	if (key >= map->max_entries)
 		return NULL;
 
-	return READ_ONCE(stab->sock_map[key]);
+	ptr = stab->sock_map + key;
+	high = stab->sock_map + map->max_entries;
+
+	return READ_ONCE(*nospec_ptr(ptr, stab->sock_map, high));
 }
 
 static int sock_map_delete_elem(struct bpf_map *map, void *key)
-- 
2.11.0
