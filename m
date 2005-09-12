Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <432596EA.3020502@yahoo.com.au>
Date: Tue, 13 Sep 2005 00:55:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: [PATCH 3/3][RFC] remove rcuref.h
References: <432595D5.1090502@yahoo.com.au> <4325965A.2010608@yahoo.com.au>
In-Reply-To: <4325965A.2010608@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------040209020703040004020106"
To: Dipankar Sarma <dipankar@in.ibm.com>, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040209020703040004020106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/3

So this is something like how one would go about removing rcuref.h.

Now I'm not proposing this for inclusion just yet. Obviously it needs
to have the atomic_ primitives supported on all architectures and
be reviewed by Dipankar and lkml...

-- 
SUSE Labs, Novell Inc.


--------------040209020703040004020106
Content-Type: text/plain;
 name="rcu-file-use-atomic-primitives.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rcu-file-use-atomic-primitives.patch"

Index: linux-2.6/include/linux/rcuref.h
===================================================================
--- linux-2.6.orig/include/linux/rcuref.h
+++ /dev/null
@@ -1,220 +0,0 @@
-/*
- * rcuref.h
- *
- * Reference counting for elements of lists/arrays protected by
- * RCU.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
- * Copyright (C) IBM Corporation, 2005
- *
- * Author: Dipankar Sarma <dipankar@in.ibm.com>
- *	   Ravikiran Thirumalai <kiran_th@gmail.com>
- *
- * See Documentation/RCU/rcuref.txt for detailed user guide.
- *
- */
-
-#ifndef _RCUREF_H_
-#define _RCUREF_H_
-
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-
-/*
- * These APIs work on traditional atomic_t counters used in the
- * kernel for reference counting. Under special circumstances
- * where a lock-free get() operation races with a put() operation
- * these APIs can be used. See Documentation/RCU/rcuref.txt.
- */
-
-#ifdef __HAVE_ARCH_CMPXCHG
-
-/**
- * rcuref_inc - increment refcount for object.
- * @rcuref: reference counter in the object in question.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference
- * in a lock-free reader-side critical section.
- */
-static inline void rcuref_inc(atomic_t *rcuref)
-{
-	atomic_inc(rcuref);
-}
-
-/**
- * rcuref_dec - decrement refcount for object.
- * @rcuref: reference counter in the object in question.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference
- * in a lock-free reader-side critical section.
- */
-static inline void rcuref_dec(atomic_t *rcuref)
-{
-	atomic_dec(rcuref);
-}
-
-/**
- * rcuref_dec_and_test - decrement refcount for object and test
- * @rcuref: reference counter in the object.
- * @release: pointer to the function that will clean up the object
- *	     when the last reference to the object is released.
- *	     This pointer is required.
- *
- * Decrement the refcount, and if 0, return 1. Else return 0.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference
- * in a lock-free reader-side critical section.
- */
-static inline int rcuref_dec_and_test(atomic_t *rcuref)
-{
-	return atomic_dec_and_test(rcuref);
-}
-
-/*
- * cmpxchg is needed on UP too, if deletions to the list/array can happen
- * in interrupt context.
- */
-
-/**
- * rcuref_inc_lf - Take reference to an object in a read-side
- * critical section protected by RCU.
- * @rcuref: reference counter in the object in question.
- *
- * Try and increment the refcount by 1.  The increment might fail if
- * the reference counter has been through a 1 to 0 transition and
- * is no longer part of the lock-free list.
- * Returns non-zero on successful increment and zero otherwise.
- */
-static inline int rcuref_inc_lf(atomic_t *rcuref)
-{
-	int c, old;
-	c = atomic_read(rcuref);
-	while (c && (old = cmpxchg(&rcuref->counter, c, c + 1)) != c)
-		c = old;
-	return c;
-}
-
-#else				/* !__HAVE_ARCH_CMPXCHG */
-
-extern spinlock_t __rcuref_hash[];
-
-/*
- * Use a hash table of locks to protect the reference count
- * since cmpxchg is not available in this arch.
- */
-#ifdef	CONFIG_SMP
-#define RCUREF_HASH_SIZE	4
-#define RCUREF_HASH(k) \
-	(&__rcuref_hash[(((unsigned long)k)>>8) & (RCUREF_HASH_SIZE-1)])
-#else
-#define	RCUREF_HASH_SIZE	1
-#define RCUREF_HASH(k) 	&__rcuref_hash[0]
-#endif				/* CONFIG_SMP */
-
-/**
- * rcuref_inc - increment refcount for object.
- * @rcuref: reference counter in the object in question.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference in a lock-free
- * reader-side critical section.
- */
-static inline void rcuref_inc(atomic_t *rcuref)
-{
-	unsigned long flags;
-	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
-	rcuref->counter += 1;
-	spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
-}
-
-/**
- * rcuref_dec - decrement refcount for object.
- * @rcuref: reference counter in the object in question.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference in a lock-free
- * reader-side critical section.
- */
-static inline void rcuref_dec(atomic_t *rcuref)
-{
-	unsigned long flags;
-	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
-	rcuref->counter -= 1;
-	spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
-}
-
-/**
- * rcuref_dec_and_test - decrement refcount for object and test
- * @rcuref: reference counter in the object.
- * @release: pointer to the function that will clean up the object
- *	     when the last reference to the object is released.
- *	     This pointer is required.
- *
- * Decrement the refcount, and if 0, return 1. Else return 0.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference in a lock-free
- * reader-side critical section.
- */
-static inline int rcuref_dec_and_test(atomic_t *rcuref)
-{
-	unsigned long flags;
-	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
-	rcuref->counter--;
-	if (!rcuref->counter) {
-		spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
-		return 1;
-	} else {
-		spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
-		return 0;
-	}
-}
-
-/**
- * rcuref_inc_lf - Take reference to an object of a lock-free collection
- * by traversing a lock-free list/array.
- * @rcuref: reference counter in the object in question.
- *
- * Try and increment the refcount by 1.  The increment might fail if
- * the reference counter has been through a 1 to 0 transition and
- * object is no longer part of the lock-free list.
- * Returns non-zero on successful increment and zero otherwise.
- */
-static inline int rcuref_inc_lf(atomic_t *rcuref)
-{
-	int ret;
-	unsigned long flags;
-	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
-	if (rcuref->counter)
-		ret = rcuref->counter++;
-	else
-		ret = 0;
-	spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
-	return ret;
-}
-
-
-#endif /* !__HAVE_ARCH_CMPXCHG */
-
-#endif /* __KERNEL__ */
-#endif /* _RCUREF_H_ */
Index: linux-2.6/fs/aio.c
===================================================================
--- linux-2.6.orig/fs/aio.c
+++ linux-2.6/fs/aio.c
@@ -29,7 +29,6 @@
 #include <linux/highmem.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
-#include <linux/rcuref.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -500,7 +499,7 @@ static int __aio_put_req(struct kioctx *
 	/* Must be done under the lock to serialise against cancellation.
 	 * Call this aio_fput as it duplicates fput via the fput_work.
 	 */
-	if (unlikely(rcuref_dec_and_test(&req->ki_filp->f_count))) {
+	if (unlikely(atomic_dec_and_test(&req->ki_filp->f_count))) {
 		get_ioctx(ctx);
 		spin_lock(&fput_lock);
 		list_add(&req->ki_list, &fput_head);
Index: linux-2.6/fs/file_table.c
===================================================================
--- linux-2.6.orig/fs/file_table.c
+++ linux-2.6/fs/file_table.c
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(get_empty_filp);
 
 void fastcall fput(struct file *file)
 {
-	if (rcuref_dec_and_test(&file->f_count))
+	if (atomic_dec_and_test(&file->f_count))
 		__fput(file);
 }
 
@@ -166,7 +166,7 @@ struct file fastcall *fget(unsigned int 
 	rcu_read_lock();
 	file = fcheck_files(files, fd);
 	if (file) {
-		if (!rcuref_inc_lf(&file->f_count)) {
+		if (!atomic_inc_not_zero(&file->f_count)) {
 			/* File object ref couldn't be taken */
 			rcu_read_unlock();
 			return NULL;
@@ -198,7 +198,7 @@ struct file fastcall *fget_light(unsigne
 		rcu_read_lock();
 		file = fcheck_files(files, fd);
 		if (file) {
-			if (rcuref_inc_lf(&file->f_count))
+			if (atomic_inc_not_zero(&file->f_count))
 				*fput_needed = 1;
 			else
 				/* Didn't get the reference, someone's freed */
@@ -213,7 +213,7 @@ struct file fastcall *fget_light(unsigne
 
 void put_filp(struct file *file)
 {
-	if (rcuref_dec_and_test(&file->f_count)) {
+	if (atomic_dec_and_test(&file->f_count)) {
 		security_file_free(file);
 		file_kill(file);
 		file_free(file);
Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h
+++ linux-2.6/include/linux/fs.h
@@ -9,7 +9,6 @@
 #include <linux/config.h>
 #include <linux/limits.h>
 #include <linux/ioctl.h>
-#include <linux/rcuref.h>
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -604,7 +603,7 @@ extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
 #define file_list_unlock() spin_unlock(&files_lock);
 
-#define get_file(x)	rcuref_inc(&(x)->f_count)
+#define get_file(x)	atomic_inc(&(x)->f_count)
 #define file_count(x)	atomic_read(&(x)->f_count)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)

--------------040209020703040004020106--
Send instant messages to your online friends http://au.messenger.yahoo.com 
