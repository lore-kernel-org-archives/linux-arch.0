From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 10/22] asm-generic: use little endian bitops
Date: Fri, 15 Oct 2010 18:46:09 +0900
Message-ID: <1287135981-17604-11-git-send-email-akinobu.mita@gmail.com>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from [150.82.175.143] ([150.82.175.143]:47238 "EHLO
	dhcpa11143.tky.aist.go.jp" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755270Ab0JOJoc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Oct 2010 05:44:32 -0400
In-Reply-To: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>

As a preparation for removing ext2 non-atomic bit operations from
asm/bitops.h. This converts ext2 non-atomic bit operations to
little endian bit operations.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 include/asm-generic/bitops/ext2-atomic.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/bitops/ext2-atomic.h b/include/asm-generic/bitops/ext2-atomic.h
index ab1c875..bcf359f 100644
--- a/include/asm-generic/bitops/ext2-atomic.h
+++ b/include/asm-generic/bitops/ext2-atomic.h
@@ -5,7 +5,7 @@
 	({						\
 		int ret;				\
 		spin_lock(lock);			\
-		ret = ext2_set_bit((nr), (unsigned long *)(addr)); \
+		ret = __test_and_set_le_bit((nr), (unsigned long *)(addr)); \
 		spin_unlock(lock);			\
 		ret;					\
 	})
@@ -14,7 +14,7 @@
 	({						\
 		int ret;				\
 		spin_lock(lock);			\
-		ret = ext2_clear_bit((nr), (unsigned long *)(addr)); \
+		ret = __test_and_clear_le_bit((nr), (unsigned long *)(addr)); \
 		spin_unlock(lock);			\
 		ret;					\
 	})
-- 
1.7.1.231.gd0b16
