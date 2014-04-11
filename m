From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 15/15] asm-generic: add renameat2 syscall
Date: Fri, 11 Apr 2014 12:25:51 +0200
Message-ID: <1397211951-20549-16-git-send-email-miklos@szeredi.hu>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:62860 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965223AbaDKK03 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2014 06:26:29 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so3985816eek.32
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2014 03:26:27 -0700 (PDT)
In-Reply-To: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@suse.cz>, Arnd Bergmann <arnd@arndb.de>

From: Miklos Szeredi <mszeredi@suse.cz>

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 6db66783d268..333640608087 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -697,9 +697,11 @@ __SYSCALL(__NR_finit_module, sys_finit_module)
 __SYSCALL(__NR_sched_setattr, sys_sched_setattr)
 #define __NR_sched_getattr 275
 __SYSCALL(__NR_sched_getattr, sys_sched_getattr)
+#define __NR_renameat2 276
+__SYSCALL(__NR_renameat2, sys_renameat2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 276
+#define __NR_syscalls 277
 
 /*
  * All syscalls below here should go away really,
-- 
1.8.1.4
