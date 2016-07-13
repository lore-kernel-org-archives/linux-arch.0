From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] locking/qrwlock: Let qrwlock has same layout
 regardless of the endian
Date: Wed, 13 Jul 2016 21:54:23 +0200
Message-ID: <20160713195423.GD30921@twins.programming.kicks-ass.net>
References: <1466403652-2931-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59906 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcGMTy1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jul 2016 15:54:27 -0400
Content-Disposition: inline
In-Reply-To: <1466403652-2931-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, arnd@arndb.de, Waiman.Long@hpe.com

On Mon, Jun 20, 2016 at 02:20:52PM +0800, Pan Xinhui wrote:
> This patch aims to get rid of endianness in queued_write_unlock(). We
> want to set  __qrwlock->wmode to NULL, however the address is not
> &lock->cnts in big endian machine. That causes queued_write_unlock()
> write NULL to the wrong field of __qrwlock.
> 
> Actually qrwlock can have same layout, IOW we can remove the #if
> __little_endian in struct __qrwlock. With such modification, we only
> need define some _QW* and _QR* with corresponding values in different
> endian systems.
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> Acked-by: Waiman Long <Waiman.Long@hpe.com>
> ---

Urgh, I hate this stuff :/

OK, so I poked at this a bit and I ended up with the below; but now
qrwlock and qspinlock are inconsistent; although I suspect qspinlock is
similarly busted wrt endian muck.

Not sure what to do..

--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -25,13 +25,31 @@
 #include <asm-generic/qrwlock_types.h>
 
 /*
- * Writer states & reader shift and bias
+ * Writer states & reader shift and bias.
+ *
+ *       | +0 | +1 | +2 | +3 |
+ *   ----+----+----+----+----+
+ *    LE | 12 | 34 | 56 | 78 | 0x12345678
+ *   ----+----+----+----+----+
+ *    BE | 78 | 56 | 34 | 12 | 0x12345678
+ *   ----+----+----+----+----+
+ *       | wr |      rd      |
+ *       +----+----+----+----+
+ *
  */
-#define	_QW_WAITING	1		/* A writer is waiting	   */
-#define	_QW_LOCKED	0xff		/* A writer holds the lock */
-#define	_QW_WMASK	0xff		/* Writer mask		   */
+#ifdef	__LITTLE_ENDIAN
 #define	_QR_SHIFT	8		/* Reader count shift	   */
-#define _QR_BIAS	(1U << _QR_SHIFT)
+#define	_QW_SHIFT	0		/* Writer mode shift	*/
+#else
+#define	_QR_SHIFT	0		/* Reader count shift	   */
+#define	_QW_SHIFT	24		/* Writer mode shift	*/
+#endif
+
+#define	_QW_WAITING	(0x01U << _QW_SHIFT)	/* A writer is waiting	   */
+#define	_QW_LOCKED	(0xffU << _QW_SHIFT)	/* A writer holds the lock */
+#define	_QW_WMASK	(0xffU << _QW_SHIFT)	/* Writer mask		   */
+
+#define	_QR_BIAS	(0x01U << _QR_SHIFT)
 
 /*
  * External function declarations
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -22,26 +22,6 @@
 #include <linux/hardirq.h>
 #include <asm/qrwlock.h>
 
-/*
- * This internal data structure is used for optimizing access to some of
- * the subfields within the atomic_t cnts.
- */
-struct __qrwlock {
-	union {
-		atomic_t cnts;
-		struct {
-#ifdef __LITTLE_ENDIAN
-			u8 wmode;	/* Writer mode   */
-			u8 rcnts[3];	/* Reader counts */
-#else
-			u8 rcnts[3];	/* Reader counts */
-			u8 wmode;	/* Writer mode   */
-#endif
-		};
-	};
-	arch_spinlock_t	lock;
-};
-
 /**
  * rspin_until_writer_unlock - inc reader count & spin until writer is gone
  * @lock  : Pointer to queue rwlock structure
@@ -124,10 +104,10 @@ void queued_write_lock_slowpath(struct q
 	 * or wait for a previous writer to go away.
 	 */
 	for (;;) {
-		struct __qrwlock *l = (struct __qrwlock *)lock;
+		u8 *wr = (u8 *)lock;
 
-		if (!READ_ONCE(l->wmode) &&
-		   (cmpxchg_relaxed(&l->wmode, 0, _QW_WAITING) == 0))
+		if (!READ_ONCE(*wr) &&
+		    (cmpxchg_relaxed(wr, 0, _QW_WAITING >> _QW_SHIFT) == 0))
 			break;
 
 		cpu_relax_lowlatency();
