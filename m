Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:52740 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423505AbXEANnI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 May 2007 09:43:08 -0400
Subject: [PATCH] Increase slab redzone to 64bits.
From: David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain
Date: Tue, 01 May 2007 14:43:00 +0100
Message-Id: <1178026980.2875.68.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

There are two problems with the existing redzone implementation.

Firstly, it's causing misalignment of structures which contain a 64-bit
integer, such as netfilter's 'struct ipt_entry' -- causing netfilter
modules to fail to load because of the misalignment. (In particular, the
first check in net/ipv4/netfilter/ip_tables.c::check_entry_size_and_hooks())

I considered just fixing this by setting ARCH_KMALLOC_MINALIGN to
__alignof__(uint64_t) in the default case where the architecture hasn't
already set it -- but that would disable redzone checks on those
architectures.

When investigating this, I noticed that on 64-bit platforms we're using
a 32-bit value of RED_ACTIVE/RED_INACTIVE in the 64-bit memory location
set aside for the redzone. Which means that the four bytes immediately
before or after the allocated object at 0x00,0x00,0x00,0x00 for LE and
BE machines, respectively. Which is probably not the most useful choice
of poison value.

One way to fix both of those at once is just to switch to 64-bit
redzones in all cases. Patch below; better ideas on a postcard to...

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/linux/poison.h b/include/linux/poison.h
index 3e628f9..e69982e 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -15,8 +15,8 @@
  * Magic nums for obj red zoning.
  * Placed in the first word before and the first word after an obj.
  */
-#define	RED_INACTIVE	0x5A2CF071UL	/* when obj is inactive */
-#define	RED_ACTIVE	0x170FC2A5UL	/* when obj is active */
+#define	RED_INACTIVE	0x5A2CF0715A2CF071ULL	/* when obj is inactive */
+#define	RED_ACTIVE	0x170FC2A5170FC2A5ULL	/* when obj is active */
 
 /* ...and for poisoning */
 #define	POISON_INUSE	0x5a	/* for use-uninitialised poisoning */
diff --git a/mm/slab.c b/mm/slab.c
index 4cbac24..92413cb 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -149,10 +149,11 @@
  * Usually, the kmalloc caches are cache_line_size() aligned, except when
  * DEBUG and FORCED_DEBUG are enabled, then they are BYTES_PER_WORD aligned.
  * Some archs want to perform DMA into kmalloc caches and need a guaranteed
- * alignment larger than BYTES_PER_WORD. ARCH_KMALLOC_MINALIGN allows that.
- * Note that this flag disables some debug features.
+ * alignment larger than the alignment of a uint64_t. ARCH_KMALLOC_MINALIGN
+ * allows that.
+ * Note that increasing this value may disable some debug features.
  */
-#define ARCH_KMALLOC_MINALIGN 0
+#define ARCH_KMALLOC_MINALIGN __alignof__(uint64_t)
 #endif
 
 #ifndef ARCH_SLAB_MINALIGN
@@ -527,19 +528,19 @@ static int obj_size(struct kmem_cache *cachep)
 	return cachep->obj_size;
 }
 
-static unsigned long *dbg_redzone1(struct kmem_cache *cachep, void *objp)
+static unsigned long long *dbg_redzone1(struct kmem_cache *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
-	return (unsigned long*) (objp+obj_offset(cachep)-BYTES_PER_WORD);
+	return (unsigned long long*) (objp+obj_offset(cachep)-8);
 }
 
-static unsigned long *dbg_redzone2(struct kmem_cache *cachep, void *objp)
+static unsigned long long *dbg_redzone2(struct kmem_cache *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
 	if (cachep->flags & SLAB_STORE_USER)
-		return (unsigned long *)(objp + cachep->buffer_size -
-					 2 * BYTES_PER_WORD);
-	return (unsigned long *)(objp + cachep->buffer_size - BYTES_PER_WORD);
+		return (unsigned long long *)(objp + cachep->buffer_size - 8 -
+					      BYTES_PER_WORD);
+	return (unsigned long long *) (objp + cachep->buffer_size - 8);
 }
 
 static void **dbg_userword(struct kmem_cache *cachep, void *objp)
@@ -552,8 +553,8 @@ static void **dbg_userword(struct kmem_cache *cachep, void *objp)
 
 #define obj_offset(x)			0
 #define obj_size(cachep)		(cachep->buffer_size)
-#define dbg_redzone1(cachep, objp)	({BUG(); (unsigned long *)NULL;})
-#define dbg_redzone2(cachep, objp)	({BUG(); (unsigned long *)NULL;})
+#define dbg_redzone1(cachep, objp)	({BUG(); (unsigned long long *)NULL;})
+#define dbg_redzone2(cachep, objp)	({BUG(); (unsigned long long *)NULL;})
 #define dbg_userword(cachep, objp)	({BUG(); (void **)NULL;})
 
 #endif
@@ -1760,7 +1761,7 @@ static void print_objinfo(struct kmem_cache *cachep, void *objp, int lines)
 	char *realobj;
 
 	if (cachep->flags & SLAB_RED_ZONE) {
-		printk(KERN_ERR "Redzone: 0x%lx/0x%lx.\n",
+		printk(KERN_ERR "Redzone: 0x%llx/0x%llx.\n",
 			*dbg_redzone1(cachep, objp),
 			*dbg_redzone2(cachep, objp));
 	}
@@ -2227,7 +2228,7 @@ kmem_cache_create (const char *name, size_t size, size_t align,
 	 * is greater than BYTES_PER_WORD.
 	 */
 	if (flags & SLAB_RED_ZONE || flags & SLAB_STORE_USER)
-		ralign = BYTES_PER_WORD;
+		ralign = __alignof__(unsigned long long);
 
 	/* 2) arch mandated alignment */
 	if (ralign < ARCH_SLAB_MINALIGN) {
@@ -2238,7 +2239,7 @@ kmem_cache_create (const char *name, size_t size, size_t align,
 		ralign = align;
 	}
 	/* disable debug if necessary */
-	if (ralign > BYTES_PER_WORD)
+	if (ralign > __alignof__(unsigned long long))
 		flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 	/*
 	 * 4) Store it.
@@ -2259,8 +2260,8 @@ kmem_cache_create (const char *name, size_t size, size_t align,
 	 */
 	if (flags & SLAB_RED_ZONE) {
 		/* add space for red zone words */
-		cachep->obj_offset += BYTES_PER_WORD;
-		size += 2 * BYTES_PER_WORD;
+		cachep->obj_offset += sizeof(unsigned long long);
+		size += 2 * sizeof(unsigned long long);
 	}
 	if (flags & SLAB_STORE_USER) {
 		/* user store requires one word storage behind the end of
@@ -2829,7 +2830,7 @@ static void kfree_debugcheck(const void *objp)
 
 static inline void verify_redzone_free(struct kmem_cache *cache, void *obj)
 {
-	unsigned long redzone1, redzone2;
+	unsigned long long redzone1, redzone2;
 
 	redzone1 = *dbg_redzone1(cache, obj);
 	redzone2 = *dbg_redzone2(cache, obj);
@@ -2845,7 +2846,7 @@ static inline void verify_redzone_free(struct kmem_cache *cache, void *obj)
 	else
 		slab_error(cache, "memory outside object was overwritten");
 
-	printk(KERN_ERR "%p: redzone 1:0x%lx, redzone 2:0x%lx.\n",
+	printk(KERN_ERR "%p: redzone 1:0x%llx, redzone 2:0x%llx.\n",
 			obj, redzone1, redzone2);
 }
 
@@ -3062,7 +3063,7 @@ static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
 			slab_error(cachep, "double free, or memory outside"
 						" object was overwritten");
 			printk(KERN_ERR
-				"%p: redzone 1:0x%lx, redzone 2:0x%lx\n",
+				"%p: redzone 1:0x%llx, redzone 2:0x%llx\n",
 				objp, *dbg_redzone1(cachep, objp),
 				*dbg_redzone2(cachep, objp));
 		}


-- 
dwmw2

