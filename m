From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 14/15] xtensa: add renameat2 syscall
Date: Fri, 11 Apr 2014 12:25:50 +0200
Message-ID: <1397211951-20549-15-git-send-email-miklos@szeredi.hu>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:55851 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965197AbaDKK01 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2014 06:26:27 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so4013959eei.28
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2014 03:26:26 -0700 (PDT)
In-Reply-To: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@suse.cz>, Chris Zankel <chris@zankel.net>

From: Miklos Szeredi <mszeredi@suse.cz>

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Cc: Chris Zankel <chris@zankel.net>
---
 arch/xtensa/include/uapi/asm/unistd.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/include/uapi/asm/unistd.h b/arch/xtensa/include/uapi/asm/unistd.h
index b9395529f02d..8883fc877c5c 100644
--- a/arch/xtensa/include/uapi/asm/unistd.h
+++ b/arch/xtensa/include/uapi/asm/unistd.h
@@ -739,7 +739,10 @@ __SYSCALL(334, sys_sched_setattr, 2)
 #define __NR_sched_getattr			335
 __SYSCALL(335, sys_sched_getattr, 3)
 
-#define __NR_syscall_count			336
+#define __NR_renameat2				336
+__SYSCALL(336, sys_renameat2, 5)
+
+#define __NR_syscall_count			337
 
 /*
  * sysxtensa syscall handler
-- 
1.8.1.4
