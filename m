From: Mark Rutland <mark.rutland@arm.com>
Subject: [RFCv2 4/4] bpf: inhibit speculated out-of-bounds pointers
Date: Fri,  5 Jan 2018 14:57:50 +0000
Message-ID: <20180105145750.53294-5-mark.rutland@arm.com>
References: <20180105145750.53294-1-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180105145750.53294-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: dan.j.williams@intel.com, elena.reshetova@intel.com, corbet@lwn.net, alan@linux.intel.com, peterz@infradead.org, will.deacon@arm.com, gregkh@linuxfoundation.org, tglx@linutronix.de, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-arch.vger.kernel.org

Note: this patch is an *example* use of the nospec API. It is understood
that this is incomplete, etc.

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
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/bpf/arraymap.c | 20 +++++++++++++-------
 kernel/bpf/cpumap.c   |  5 ++---
 kernel/bpf/devmap.c   |  3 ++-
 kernel/bpf/sockmap.c  |  3 ++-
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 7c25426d3cf5..deaad334a100 100644
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
@@ -153,11 +158,14 @@ static void *percpu_array_map_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
+	void __percpu *pptr;
 
 	if (unlikely(index >= array->map.max_entries))
 		return NULL;
 
-	return this_cpu_ptr(array->pptrs[index]);
+	pptr = nospec_array_ptr(array->pptrs, index, array->map.max_entries);
+
+	return this_cpu_ptr(pptr);
 }
 
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
@@ -302,7 +310,6 @@ const struct bpf_map_ops array_map_ops = {
 	.map_lookup_elem = array_map_lookup_elem,
 	.map_update_elem = array_map_update_elem,
 	.map_delete_elem = array_map_delete_elem,
-	.map_gen_lookup = array_map_gen_lookup,
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
@@ -610,8 +617,8 @@ static void *array_of_map_lookup_elem(struct bpf_map *map, void *key)
 	return READ_ONCE(*inner_map);
 }
 
-static u32 array_of_map_gen_lookup(struct bpf_map *map,
-				   struct bpf_insn *insn_buf)
+static u32 __maybe_unused array_of_map_gen_lookup(struct bpf_map *map,
+						  struct bpf_insn *insn_buf)
 {
 	u32 elem_size = round_up(map->value_size, 8);
 	struct bpf_insn *insn = insn_buf;
@@ -644,5 +651,4 @@ const struct bpf_map_ops array_of_maps_map_ops = {
 	.map_fd_get_ptr = bpf_map_fd_get_ptr,
 	.map_fd_put_ptr = bpf_map_fd_put_ptr,
 	.map_fd_sys_lookup_elem = bpf_map_fd_sys_lookup_elem,
-	.map_gen_lookup = array_of_map_gen_lookup,
 };
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index ce5b669003b2..6769a0e30c8c 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -551,13 +551,12 @@ void cpu_map_free(struct bpf_map *map)
 struct bpf_cpu_map_entry *__cpu_map_lookup_elem(struct bpf_map *map, u32 key)
 {
 	struct bpf_cpu_map *cmap = container_of(map, struct bpf_cpu_map, map);
-	struct bpf_cpu_map_entry *rcpu;
 
 	if (key >= map->max_entries)
 		return NULL;
 
-	rcpu = READ_ONCE(cmap->cpu_map[key]);
-	return rcpu;
+	return READ_ONCE(*nospec_array_ptr(cmap->cpu_map, key,
+					   map->max_entries));
 }
 
 static void *cpu_map_lookup_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index ebdef54bf7df..5a1050d270a0 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -254,7 +254,8 @@ struct net_device  *__dev_map_lookup_elem(struct bpf_map *map, u32 key)
 	if (key >= map->max_entries)
 		return NULL;
 
-	dev = READ_ONCE(dtab->netdev_map[key]);
+	dev = READ_ONCE(*nospec_array_ptr(dtab->netdev_map, key,
+					  map->max_entries));
 	return dev ? dev->dev : NULL;
 }
 
diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 5ee2e41893d9..e912de3cd4ce 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -630,7 +630,8 @@ struct sock  *__sock_map_lookup_elem(struct bpf_map *map, u32 key)
 	if (key >= map->max_entries)
 		return NULL;
 
-	return READ_ONCE(stab->sock_map[key]);
+	return READ_ONCE(*nospec_array_ptr(stab->sock_map, key,
+					   map->max_entries));
 }
 
 static int sock_map_delete_elem(struct bpf_map *map, void *key)
-- 
2.11.0
