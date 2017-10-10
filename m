From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Tue, 10 Oct 2017 08:52:37 -0700
Message-ID: <20171010155237.GE3521@linux.vnet.ibm.com>
References: <8079.1507628146@warthog.procyon.org.uk>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8368.1507629579@warthog.procyon.org.uk>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932142AbdJJPwp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Oct 2017 11:52:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9AFpSnB051264
        for <linux-arch@vger.kernel.org>; Tue, 10 Oct 2017 11:52:45 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dgy2fytxt-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 10 Oct 2017 11:52:43 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 10 Oct 2017 11:52:42 -0400
Content-Disposition: inline
In-Reply-To: <8368.1507629579@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>

On Tue, Oct 10, 2017 at 10:59:39AM +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > >  static inline void *assoc_array_ptr_to_leaf(const struct assoc_array_ptr *x)
> > >  {
> > > -	return (void *)((unsigned long)x & ~ASSOC_ARRAY_PTR_TYPE_MASK);
> > > +	return (void *)((unsigned long)READ_ONCE(x) & /* Address dependency. */
> > > +		~ASSOC_ARRAY_PTR_TYPE_MASK);
> > >  }
> > 
> > This is the wrong place to do this.  assoc_array_ptr_to_leaf() is effectively
> > no more than a special cast; it removes a metadata bit from a pointer.  x is
> > the value we're modifying, not *x, and x was read by the caller.
> 
> Also, x is not a pointer you can read from, so if READ_ONCE(x) ever effects a
> memory access, you might get an oops.

Agreed, and I got rid of it.

And thank you for looking this over!

And the patch again below, but this time also updating the commit log.

							Thanx, Paul

------------------------------------------------------------------------

commit 472850f320e8eb47cfb06420c128c3f2bb8ccf27
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Oct 9 11:39:57 2017 -0700

    lib/assoc_array: Remove smp_read_barrier_depends()
    
    Now that smp_read_barrier_depends() is implied by READ_ONCE(), the several
    smp_read_barrier_depends() calls may be removed from lib/assoc_array.c.
    This commit makes this change and marks the READ_ONCE() calls that head
    address dependencies.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Jonathan Corbet <corbet@lwn.net>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Alexander Kuleshov <kuleshovmail@gmail.com>

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index fe7953aead82..7e483294f7d7 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -38,12 +38,10 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 	if (assoc_array_ptr_is_shortcut(cursor)) {
 		/* Descend through a shortcut */
 		shortcut = assoc_array_ptr_to_shortcut(cursor);
-		smp_read_barrier_depends();
-		cursor = READ_ONCE(shortcut->next_node);
+		cursor = READ_ONCE(shortcut->next_node); /* Address dependency. */
 	}
 
 	node = assoc_array_ptr_to_node(cursor);
-	smp_read_barrier_depends();
 	slot = 0;
 
 	/* We perform two passes of each node.
@@ -55,15 +53,12 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
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
+			/* We need a barrier between the read of the pointer,
+			 * which is supplied by the above READ_ONCE().
 			 */
-			smp_read_barrier_depends();
-
 			/* Invoke the callback */
 			ret = iterator(assoc_array_ptr_to_leaf(ptr),
 				       iterator_data);
@@ -86,10 +81,8 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 
 continue_node:
 	node = assoc_array_ptr_to_node(cursor);
-	smp_read_barrier_depends();
-
 	for (; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
-		ptr = READ_ONCE(node->slots[slot]);
+		ptr = READ_ONCE(node->slots[slot]); /* Address dependency. */
 		if (assoc_array_ptr_is_meta(ptr)) {
 			cursor = ptr;
 			goto begin_node;
@@ -98,16 +91,15 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 
 finished_node:
 	/* Move up to the parent (may need to skip back over a shortcut) */
-	parent = READ_ONCE(node->back_pointer);
+	parent = READ_ONCE(node->back_pointer); /* Address dependency. */
 	slot = node->parent_slot;
 	if (parent == stop)
 		return 0;
 
 	if (assoc_array_ptr_is_shortcut(parent)) {
 		shortcut = assoc_array_ptr_to_shortcut(parent);
-		smp_read_barrier_depends();
 		cursor = parent;
-		parent = READ_ONCE(shortcut->back_pointer);
+		parent = READ_ONCE(shortcut->back_pointer); /* Address dependency. */
 		slot = shortcut->parent_slot;
 		if (parent == stop)
 			return 0;
@@ -147,7 +139,7 @@ int assoc_array_iterate(const struct assoc_array *array,
 					void *iterator_data),
 			void *iterator_data)
 {
-	struct assoc_array_ptr *root = READ_ONCE(array->root);
+	struct assoc_array_ptr *root = READ_ONCE(array->root); /* Address dependency. */
 
 	if (!root)
 		return 0;
@@ -194,7 +186,7 @@ assoc_array_walk(const struct assoc_array *array,
 
 	pr_devel("-->%s()\n", __func__);
 
-	cursor = READ_ONCE(array->root);
+	cursor = READ_ONCE(array->root);  /* Address dependency. */
 	if (!cursor)
 		return assoc_array_walk_tree_empty;
 
@@ -216,11 +208,9 @@ assoc_array_walk(const struct assoc_array *array,
 
 consider_node:
 	node = assoc_array_ptr_to_node(cursor);
-	smp_read_barrier_depends();
-
 	slot = segments >> (level & ASSOC_ARRAY_KEY_CHUNK_MASK);
 	slot &= ASSOC_ARRAY_FAN_MASK;
-	ptr = READ_ONCE(node->slots[slot]);
+	ptr = READ_ONCE(node->slots[slot]); /* Address dependency. */
 
 	pr_devel("consider slot %x [ix=%d type=%lu]\n",
 		 slot, level, (unsigned long)ptr & 3);
@@ -254,7 +244,6 @@ assoc_array_walk(const struct assoc_array *array,
 	cursor = ptr;
 follow_shortcut:
 	shortcut = assoc_array_ptr_to_shortcut(cursor);
-	smp_read_barrier_depends();
 	pr_devel("shortcut to %d\n", shortcut->skip_to_level);
 	sc_level = level + ASSOC_ARRAY_LEVEL_STEP;
 	BUG_ON(sc_level > shortcut->skip_to_level);
@@ -294,7 +283,7 @@ assoc_array_walk(const struct assoc_array *array,
 	} while (sc_level < shortcut->skip_to_level);
 
 	/* The shortcut matches the leaf's index to this point. */
-	cursor = READ_ONCE(shortcut->next_node);
+	cursor = READ_ONCE(shortcut->next_node); /* Address dependency. */
 	if (((level ^ sc_level) & ~ASSOC_ARRAY_KEY_CHUNK_MASK) != 0) {
 		level = sc_level;
 		goto jumped;
@@ -330,21 +319,19 @@ void *assoc_array_find(const struct assoc_array *array,
 	    assoc_array_walk_found_terminal_node)
 		return NULL;
 
-	node = result.terminal_node.node;
-	smp_read_barrier_depends();
+	node = READ_ONCE(result.terminal_node.node); /* Address dependency. */
 
 	/* If the target key is available to us, it's has to be pointed to by
 	 * the terminal node.
 	 */
 	for (slot = 0; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
-		ptr = READ_ONCE(node->slots[slot]);
+		ptr = READ_ONCE(node->slots[slot]); /* Address dependency. */
 		if (ptr && assoc_array_ptr_is_leaf(ptr)) {
 			/* We need a barrier between the read of the pointer
 			 * and dereferencing the pointer - but only if we are
 			 * actually going to dereference it.
 			 */
 			leaf = assoc_array_ptr_to_leaf(ptr);
-			smp_read_barrier_depends();
 			if (ops->compare_object(leaf, index_key))
 				return (void *)leaf;
 		}
