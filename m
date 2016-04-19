From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] asm-generic: wire up preadv2/pwritev2
Date: Tue, 19 Apr 2016 10:59:14 -0400
Message-ID: <1461077954-13015-1-git-send-email-hch@lst.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57020 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742AbcDSO7V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2016 10:59:21 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/asm-generic/unistd.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2622b33..6e0f5f0 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -717,9 +717,13 @@ __SYSCALL(__NR_membarrier, sys_membarrier)
 __SYSCALL(__NR_mlock2, sys_mlock2)
 #define __NR_copy_file_range 285
 __SYSCALL(__NR_copy_file_range, sys_copy_file_range)
+#define __NR_preadv2 286
+__SYSCALL(__NR_preadv2, sys_preadv2)
+#define __NR_pwritev2 287
+__SYSCALL(__NR_pwritev2, sys_pwritev2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 286
+#define __NR_syscalls 288
 
 /*
  * All syscalls below here should go away really,
-- 
2.1.4
