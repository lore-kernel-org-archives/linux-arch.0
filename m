From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v3] locking/qrwlock: Let qrwlock has same layout regardless of the endian
Date: Mon, 20 Jun 2016 14:20:52 +0800
Message-ID: <1466403652-2931-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57795 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752515AbcFTGVT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Jun 2016 02:21:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5K6JW9Y100986
	for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2016 02:21:18 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23mywvecf2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2016 02:21:17 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Mon, 20 Jun 2016 00:21:16 -0600
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, arnd@arndb.de, Waiman.Long@hpe.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

This patch aims to get rid of endianness in queued_write_unlock(). We
want to set  __qrwlock->wmode to NULL, however the address is not
&lock->cnts in big endian machine. That causes queued_write_unlock()
write NULL to the wrong field of __qrwlock.

Actually qrwlock can have same layout, IOW we can remove the #if
__little_endian in struct __qrwlock. With such modification, we only
need define some _QW* and _QR* with corresponding values in different
endian systems.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Acked-by: Waiman Long <Waiman.Long@hpe.com>
---
change from v2:
	change macro's name, add comments.
change from v1:
	A typo fix which is really bad...
	thanks Will for the carefull review. :)
---
 include/asm-generic/qrwlock.h | 15 +++++++++++----
 kernel/locking/qrwlock.c      | 11 +++++------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 54a8e65..28fb94a 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -27,11 +27,18 @@
 /*
  * Writer states & reader shift and bias
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
+#define	_QW_WAITING	(1U << _QW_SHIFT)	/* A writer is waiting	   */
+#define	_QW_LOCKED	(0xffU << _QW_SHIFT)	/* A writer holds the lock */
+#define	_QW_WMASK	(0xffU << _QW_SHIFT)	/* Writer mask		   */
+#define	_QR_BIAS	(1U << _QR_SHIFT)
 
 /*
  * External function declarations
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index fec0823..0502e3a 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -30,18 +30,16 @@ struct __qrwlock {
 	union {
 		atomic_t cnts;
 		struct {
-#ifdef __LITTLE_ENDIAN
 			u8 wmode;	/* Writer mode   */
 			u8 rcnts[3];	/* Reader counts */
-#else
-			u8 rcnts[3];	/* Reader counts */
-			u8 wmode;	/* Writer mode   */
-#endif
 		};
 	};
 	arch_spinlock_t	lock;
 };
 
+/* get the value of wmode when cnts is v */
+#define	_QW_BYTEVAL(v)	((v) >> _QW_SHIFT)
+
 /**
  * rspin_until_writer_unlock - inc reader count & spin until writer is gone
  * @lock  : Pointer to queue rwlock structure
@@ -127,7 +125,8 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 		struct __qrwlock *l = (struct __qrwlock *)lock;
 
 		if (!READ_ONCE(l->wmode) &&
-		   (cmpxchg_relaxed(&l->wmode, 0, _QW_WAITING) == 0))
+		   (cmpxchg_relaxed(&l->wmode, 0,
+					_QW_BYTEVAL(_QW_WAITING)) == 0))
 			break;
 
 		cpu_relax_lowlatency();
-- 
1.9.1
