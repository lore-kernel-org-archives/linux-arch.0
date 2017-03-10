From: Stafford Horne <shorne@gmail.com>
Subject: [PATCH] generic syscalls: Wire up statx syscall
Date: Sat, 11 Mar 2017 06:51:41 +0900
Message-ID: <20170310215141.18432-1-shorne@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36641 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbdCJVwQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2017 16:52:16 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stafford Horne <shorne@gmail.com>

The new syscall statx is implemented as generic code, so enable it
for architectures like openrisc which use the generic syscall table.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 9b1462e..a076cf1 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -730,9 +730,11 @@ __SYSCALL(__NR_pkey_mprotect, sys_pkey_mprotect)
 __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 #define __NR_pkey_free 290
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
+#define __NR_statx 291
+__SYSCALL(__NR_statx,     sys_statx)
 
 #undef __NR_syscalls
-#define __NR_syscalls 291
+#define __NR_syscalls 292
 
 /*
  * All syscalls below here should go away really,
-- 
2.9.3
