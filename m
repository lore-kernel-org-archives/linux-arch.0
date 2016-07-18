From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v4] locking/qrwlock: Fix write unlock issue in big endian
Date: Mon, 18 Jul 2016 17:47:39 +0800
Message-ID: <1468835259-4486-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13179 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751456AbcGRJtt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Jul 2016 05:49:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6I9n9xN055560
	for <linux-arch@vger.kernel.org>; Mon, 18 Jul 2016 05:49:48 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2482fvyr8w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Mon, 18 Jul 2016 05:49:48 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Mon, 18 Jul 2016 03:49:47 -0600
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: peterz@infradead.org, arnd@arndb.de, Waiman.Long@hpe.com, mingo@redhat.com, will.deacon@arm.com, boqun.feng@gmail.com, pan xinhui <xinhui.pan@linux.vnet.ibm.com>

From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>

This patch aims to get rid of endianness in queued_write_unlock(). We
want to set  __qrwlock->wmode to NULL, however the address is not
&lock->cnts in big endian machine. That causes queued_write_unlock()
write NULL to the wrong field of __qrwlock.

So implement __qrwlock_write_byte() which returns the correct
__qrwlock->wmode address.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
change from v3:
	rewrite totally. :)
change from v2:
	change macro's name, add comments.
change from v1:
	A typo fix which is really bad...
	thanks Will for the carefull review.
---
 include/asm-generic/qrwlock.h | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 54a8e65..7d026bf 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -25,7 +25,20 @@
 #include <asm-generic/qrwlock_types.h>
 
 /*
- * Writer states & reader shift and bias
+ * Writer states & reader shift and bias.
+ *
+ *       | +0 | +1 | +2 | +3 |
+ *   ----+----+----+----+----+
+ *    LE | 78 | 56 | 34 | 12 | 0x12345678
+ *   ----+----+----+----+----+
+ *       | wr |      rd      |
+ *       +----+----+----+----+
+ *
+ *   ----+----+----+----+----+
+ *    BE | 12 | 34 | 56 | 78 | 0x12345678
+ *   ----+----+----+----+----+
+ *       |      rd      | wr |
+ *       +----+----+----+----+
  */
 #define	_QW_WAITING	1		/* A writer is waiting	   */
 #define	_QW_LOCKED	0xff		/* A writer holds the lock */
@@ -134,12 +147,22 @@ static inline void queued_read_unlock(struct qrwlock *lock)
 }
 
 /**
+ * __qrwlock_write_byte - retrieve the write byte address of a queue rwlock
+ * @lock : Pointer to queue rwlock structure
+ * Return: the write byte address of a queue rwlock
+ */
+static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
+{
+	return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
+}
+
+/**
  * queued_write_unlock - release write lock of a queue rwlock
  * @lock : Pointer to queue rwlock structure
  */
 static inline void queued_write_unlock(struct qrwlock *lock)
 {
-	smp_store_release((u8 *)&lock->cnts, 0);
+	smp_store_release(__qrwlock_write_byte(lock), 0);
 }
 
 /*
-- 
1.9.1
