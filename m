Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Global spinlock vs local bit spin locks
From: Nick Piggin <nickpiggin@yahoo.com.au>
Content-Type: multipart/mixed; boundary="=-GZ0Bqzx5/LGDqurDwtVm"
Date: Fri, 17 Jun 2005 14:21:32 +1000
Message-Id: <1118982092.5261.44.camel@npiggin-nld.site>
Mime-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>, anton@samba.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Keilty <Peter.Keilty@hp.com>
List-ID: <linux-arch.vger.kernel.org>


--=-GZ0Bqzx5/LGDqurDwtVm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Peter Keilty is running into some scalability problems with buffer
head based IO. There are a couple of global spinlocks in the buffer
completion path, and they're showing up on 16-way IA64 systems.

Replacing these locks with a bit spin lock in the buffer head status
field has been shown to eliminate the bouncing problem. We want to
go with this unless anyone has an objection to the cost.

There is a cost (though I haven't been able to measure a signficant
change), but I think it will be outweighed by the the reduction in
cacheline contention on even small SMPs doing IO.

Any input would be appreciated.

If anyone wants to run some tests, possibly the easiest would be to
make ext2 on loopback on tmpfs (to test scalability, have one loop
device for each CPU in the system and bind the loop threads to each
CPU). Make sure ext2 block size is < PAGE_SIZE.



--=-GZ0Bqzx5/LGDqurDwtVm
Content-Disposition: attachment; filename=page_uptodate_lock-bh_lock.patch
Content-Type: text/x-patch; name=page_uptodate_lock-bh_lock.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use a bit spin lock in the first buffer of the page to synchronise
asynch IO buffer completions, instead of the global page_uptodate_lock,
which is showing some scalabilty problems.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2005-05-06 17:41:50.000000000 +1000
+++ linux-2.6/fs/buffer.c	2005-05-06 17:42:03.000000000 +1000
@@ -538,9 +538,8 @@ static void free_more_memory(void)
  */
 static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 {
-	static DEFINE_SPINLOCK(page_uptodate_lock);
 	unsigned long flags;
-	struct buffer_head *tmp;
+	struct buffer_head *first, *tmp;
 	struct page *page;
 	int page_uptodate = 1;
 
@@ -561,7 +560,9 @@ static void end_buffer_async_read(struct
 	 * two buffer heads end IO at almost the same time and both
 	 * decide that the page is now completely done.
 	 */
-	spin_lock_irqsave(&page_uptodate_lock, flags);
+	first = page_buffers(page);
+	local_irq_save(flags);
+	bit_spin_lock(BH_Uptd_Lock, &first->b_state);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
@@ -574,7 +575,8 @@ static void end_buffer_async_read(struct
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	bit_spin_unlock(BH_Uptd_Lock, &first->b_state);
+	local_irq_restore(flags);
 
 	/*
 	 * If none of the buffers had errors and they are all
@@ -586,7 +588,8 @@ static void end_buffer_async_read(struct
 	return;
 
 still_busy:
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	bit_spin_unlock(BH_Uptd_Lock, &first->b_state);
+	local_irq_restore(flags);
 	return;
 }
 
@@ -597,9 +600,8 @@ still_busy:
 void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 {
 	char b[BDEVNAME_SIZE];
-	static DEFINE_SPINLOCK(page_uptodate_lock);
 	unsigned long flags;
-	struct buffer_head *tmp;
+	struct buffer_head *tmp, *first;
 	struct page *page;
 
 	BUG_ON(!buffer_async_write(bh));
@@ -619,7 +621,10 @@ void end_buffer_async_write(struct buffe
 		SetPageError(page);
 	}
 
-	spin_lock_irqsave(&page_uptodate_lock, flags);
+	first = page_buffers(page);
+	local_irq_save(flags);
+	bit_spin_lock(BH_Uptd_Lock, &first->b_state);
+
 	clear_buffer_async_write(bh);
 	unlock_buffer(bh);
 	tmp = bh->b_this_page;
@@ -630,12 +635,14 @@ void end_buffer_async_write(struct buffe
 		}
 		tmp = tmp->b_this_page;
 	}
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	bit_spin_unlock(BH_Uptd_Lock, &first->b_state);
+	local_irq_restore(flags);
 	end_page_writeback(page);
 	return;
 
 still_busy:
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	bit_spin_unlock(BH_Uptd_Lock, &first->b_state);
+	local_irq_restore(flags);
 	return;
 }
 
Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h	2005-05-06 17:39:54.000000000 +1000
+++ linux-2.6/include/linux/buffer_head.h	2005-05-06 17:42:03.000000000 +1000
@@ -19,6 +19,8 @@ enum bh_state_bits {
 	BH_Dirty,	/* Is dirty */
 	BH_Lock,	/* Is locked */
 	BH_Req,		/* Has been submitted for I/O */
+	BH_Uptd_Lock,	/* Only used by the first bh in a page, to serialise
+			   IO completion of other buffers in the page */
 
 	BH_Mapped,	/* Has a disk mapping */
 	BH_New,		/* Disk mapping was newly created by get_block */


--=-GZ0Bqzx5/LGDqurDwtVm
Content-Disposition: attachment; filename=page_uptodate_lock-bh_lock.patch
Content-Type: text/x-patch; name=page_uptodate_lock-bh_lock.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use a bit spin lock in the first buffer of the page to synchronise
asynch IO buffer completions, instead of the global page_uptodate_lock,
which is showing some scalabilty problems.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2005-05-06 17:41:50.000000000 +1000
+++ linux-2.6/fs/buffer.c	2005-05-06 17:42:03.000000000 +1000
@@ -538,9 +538,8 @@ static void free_more_memory(void)
  */
 static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 {
-	static DEFINE_SPINLOCK(page_uptodate_lock);
 	unsigned long flags;
-	struct buffer_head *tmp;
+	struct buffer_head *first, *tmp;
 	struct page *page;
 	int page_uptodate = 1;
 
@@ -561,7 +560,9 @@ static void end_buffer_async_read(struct
 	 * two buffer heads end IO at almost the same time and both
 	 * decide that the page is now completely done.
 	 */
-	spin_lock_irqsave(&page_uptodate_lock, flags);
+	first = page_buffers(page);
+	local_irq_save(flags);
+	bit_spin_lock(BH_Uptd_Lock, &first->b_state);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
@@ -574,7 +575,8 @@ static void end_buffer_async_read(struct
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	bit_spin_unlock(BH_Uptd_Lock, &first->b_state);
+	local_irq_restore(flags);
 
 	/*
 	 * If none of the buffers had errors and they are all
@@ -586,7 +588,8 @@ static void end_buffer_async_read(struct
 	return;
 
 still_busy:
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	bit_spin_unlock(BH_Uptd_Lock, &first->b_state);
+	local_irq_restore(flags);
 	return;
 }
 
@@ -597,9 +600,8 @@ still_busy:
 void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 {
 	char b[BDEVNAME_SIZE];
-	static DEFINE_SPINLOCK(page_uptodate_lock);
 	unsigned long flags;
-	struct buffer_head *tmp;
+	struct buffer_head *tmp, *first;
 	struct page *page;
 
 	BUG_ON(!buffer_async_write(bh));
@@ -619,7 +621,10 @@ void end_buffer_async_write(struct buffe
 		SetPageError(page);
 	}
 
-	spin_lock_irqsave(&page_uptodate_lock, flags);
+	first = page_buffers(page);
+	local_irq_save(flags);
+	bit_spin_lock(BH_Uptd_Lock, &first->b_state);
+
 	clear_buffer_async_write(bh);
 	unlock_buffer(bh);
 	tmp = bh->b_this_page;
@@ -630,12 +635,14 @@ void end_buffer_async_write(struct buffe
 		}
 		tmp = tmp->b_this_page;
 	}
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	bit_spin_unlock(BH_Uptd_Lock, &first->b_state);
+	local_irq_restore(flags);
 	end_page_writeback(page);
 	return;
 
 still_busy:
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	bit_spin_unlock(BH_Uptd_Lock, &first->b_state);
+	local_irq_restore(flags);
 	return;
 }
 
Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h	2005-05-06 17:39:54.000000000 +1000
+++ linux-2.6/include/linux/buffer_head.h	2005-05-06 17:42:03.000000000 +1000
@@ -19,6 +19,8 @@ enum bh_state_bits {
 	BH_Dirty,	/* Is dirty */
 	BH_Lock,	/* Is locked */
 	BH_Req,		/* Has been submitted for I/O */
+	BH_Uptd_Lock,	/* Only used by the first bh in a page, to serialise
+			   IO completion of other buffers in the page */
 
 	BH_Mapped,	/* Has a disk mapping */
 	BH_New,		/* Disk mapping was newly created by get_block */


--=-GZ0Bqzx5/LGDqurDwtVm--

Send instant messages to your online friends http://au.messenger.yahoo.com 
