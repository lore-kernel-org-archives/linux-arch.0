Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32561 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753276AbcFOJcJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jun 2016 05:32:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5F9T0iW033564
	for <linux-arch@vger.kernel.org>; Wed, 15 Jun 2016 05:32:03 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23jch5by2c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 15 Jun 2016 05:32:03 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Wed, 15 Jun 2016 05:32:02 -0400
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v2] locking/qrwlock: Let qrwlock has same layout regardless of the endian
Date: Wed, 15 Jun 2016 17:31:49 +0800
Message-ID: <1465983109-3217-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: ingo@redhat.com, peterz@infradead.org, arnd@arndb.de, Waiman.Long@hpe.com, will.deacon@arm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Message-ID: <20160615093149.pOLm2PmKiAn2IrlcEWQH9JotcKeAO3IQrTiHBlXE1AI@z>

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
---
change from v1:
	A typo fix which is really bad...
	thanks Will for the carefull review. :)
---
 include/asm-generic/qrwlock.h | 15 +++++++++++----
 kernel/locking/qrwlock.c      | 10 ++++------
 2 files changed, 15 insertions(+), 10 deletions(-)

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
index fec0823..57d66cf 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -30,18 +30,15 @@ struct __qrwlock {
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
 
+#define	_QW_MODEVAL(v)	((v) >> _QW_SHIFT)
+
 /**
  * rspin_until_writer_unlock - inc reader count & spin until writer is gone
  * @lock  : Pointer to queue rwlock structure
@@ -127,7 +124,8 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 		struct __qrwlock *l = (struct __qrwlock *)lock;
 
 		if (!READ_ONCE(l->wmode) &&
-		   (cmpxchg_relaxed(&l->wmode, 0, _QW_WAITING) == 0))
+		   (cmpxchg_relaxed(&l->wmode, 0,
+					_QW_MODEVAL(_QW_WAITING)) == 0))
 			break;
 
 		cpu_relax_lowlatency();
-- 
1.9.1

