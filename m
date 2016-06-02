From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Thu,  2 Jun 2016 18:09:08 +0800
Message-ID: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:60067 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbcFBKJq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2016 06:09:46 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Thu, 2 Jun 2016 04:09:45 -0600
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, waiman.long@hp.com, peterz@infradead.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

strcut __qrwlock has different layout in big endian machine. we need set
the __qrwlock->wmode to NULL, and the address is not &lock->cnts in big
endian machine.

Do as what read unlock does. we are lucky that the __qrwlock->wmode's
val is _QW_LOCKED.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 include/asm-generic/qrwlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 54a8e65..eadd7a3 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -139,7 +139,7 @@ static inline void queued_read_unlock(struct qrwlock *lock)
  */
 static inline void queued_write_unlock(struct qrwlock *lock)
 {
-	smp_store_release((u8 *)&lock->cnts, 0);
+	(void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
 }
 
 /*
-- 
1.9.1
