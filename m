From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
Date: Mon,  9 Oct 2017 17:22:46 -0700
Message-ID: <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
List-Id: linux-arch.vger.kernel.org

Now that smp_read_barrier_depends() is implied by READ_ONCE(), adding
READ_ONCE() to assoc_array_ptr_to_leaf() and __assoc_array_ptr_to_meta()
allows the several smp_read_barrier_depends() calls to be removed from
lib/assoc_array.c.  This commit makes this change.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 include/linux/assoc_array_priv.h |  5 +++--
 lib/assoc_array.c                | 20 ++------------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/include/linux/assoc_array_priv.h b/include/linux/assoc_array_priv.h
index 711275e6681c..b47308bf1f99 100644
--- a/include/linux/assoc_array_priv.h
+++ b/include/linux/assoc_array_priv.h
@@ -135,13 +135,14 @@ static inline bool assoc_array_ptr_is_node(const struct assoc_array_ptr *x)
 
 static inline void *assoc_array_ptr_to_leaf(const struct assoc_array_ptr *x)
 {
-	return (void *)((unsigned long)x & ~ASSOC_ARRAY_PTR_TYPE_MASK);
+	return (void *)((unsigned long)READ_ONCE(x) & /* Address dependency. */
+		~ASSOC_ARRAY_PTR_TYPE_MASK);
 }
 
 static inline
 unsigned long __assoc_array_ptr_to_meta(const struct assoc_array_ptr *x)
 {
-	return (unsigned long)x &
+	return (unsigned long)READ_ONCE(x) & /* Address dependency. */
 		~(ASSOC_ARRAY_PTR_SUBTYPE_MASK | ASSOC_ARRAY_PTR_TYPE_MASK);
 }
 static inline
diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index fe7953aead82..52845f5cbf19 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -38,12 +38,10 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 	if (assoc_array_ptr_is_shortcut(cursor)) {
 		/* Descend through a shortcut */
 		shortcut = assoc_array_ptr_to_shortcut(cursor);
-		smp_read_barrier_depends();
 		cursor = READ_ONCE(shortcut->next_node);
 	}
 
 	node = assoc_array_ptr_to_node(cursor);
-	smp_read_barrier_depends();
 	slot = 0;
 
 	/* We perform two passes of each node.
@@ -55,15 +53,9 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 	 */
 	has_meta = 0;
 	for (; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
-		ptr = READ_ONCE(node->slots[slot]);
+		ptr = READ_ONCE(node->slots[slot]); /* Address dependency. */
 		has_meta |= (unsigned long)ptr;
 		if (ptr && assoc_array_ptr_is_leaf(ptr)) {
-			/* We need a barrier between the read of the pointer
-			 * and dereferencing the pointer - but only if we are
-			 * actually going to dereference it.
-			 */
-			smp_read_barrier_depends();
-
 			/* Invoke the callback */
 			ret = iterator(assoc_array_ptr_to_leaf(ptr),
 				       iterator_data);
@@ -86,8 +78,6 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 
 continue_node:
 	node = assoc_array_ptr_to_node(cursor);
-	smp_read_barrier_depends();
-
 	for (; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
 		ptr = READ_ONCE(node->slots[slot]);
 		if (assoc_array_ptr_is_meta(ptr)) {
@@ -105,7 +95,6 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 
 	if (assoc_array_ptr_is_shortcut(parent)) {
 		shortcut = assoc_array_ptr_to_shortcut(parent);
-		smp_read_barrier_depends();
 		cursor = parent;
 		parent = READ_ONCE(shortcut->back_pointer);
 		slot = shortcut->parent_slot;
@@ -216,8 +205,6 @@ assoc_array_walk(const struct assoc_array *array,
 
 consider_node:
 	node = assoc_array_ptr_to_node(cursor);
-	smp_read_barrier_depends();
-
 	slot = segments >> (level & ASSOC_ARRAY_KEY_CHUNK_MASK);
 	slot &= ASSOC_ARRAY_FAN_MASK;
 	ptr = READ_ONCE(node->slots[slot]);
@@ -254,7 +241,6 @@ assoc_array_walk(const struct assoc_array *array,
 	cursor = ptr;
 follow_shortcut:
 	shortcut = assoc_array_ptr_to_shortcut(cursor);
-	smp_read_barrier_depends();
 	pr_devel("shortcut to %d\n", shortcut->skip_to_level);
 	sc_level = level + ASSOC_ARRAY_LEVEL_STEP;
 	BUG_ON(sc_level > shortcut->skip_to_level);
@@ -330,8 +316,7 @@ void *assoc_array_find(const struct assoc_array *array,
 	    assoc_array_walk_found_terminal_node)
 		return NULL;
 
-	node = result.terminal_node.node;
-	smp_read_barrier_depends();
+	node = READ_ONCE(result.terminal_node.node);  /* Address dependency. */
 
 	/* If the target key is available to us, it's has to be pointed to by
 	 * the terminal node.
@@ -344,7 +329,6 @@ void *assoc_array_find(const struct assoc_array *array,
 			 * actually going to dereference it.
 			 */
 			leaf = assoc_array_ptr_to_leaf(ptr);
-			smp_read_barrier_depends();
 			if (ops->compare_object(leaf, index_key))
 				return (void *)leaf;
 		}
-- 
2.5.2
