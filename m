From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 11/15] s390: NR_syscalls fix
Date: Fri, 11 Apr 2014 12:25:47 +0200
Message-ID: <1397211951-20549-12-git-send-email-miklos@szeredi.hu>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:42742 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965155AbaDKK0X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2014 06:26:23 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so4030729eek.27
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2014 03:26:22 -0700 (PDT)
In-Reply-To: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@suse.cz>, Martin Schwidefsky <schwidefsky@de.ibm.com>

From: Miklos Szeredi <mszeredi@suse.cz>

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/uapi/asm/unistd.h b/arch/s390/include/uapi/asm/unistd.h
index 5eb5c9ddb120..57194268fe63 100644
--- a/arch/s390/include/uapi/asm/unistd.h
+++ b/arch/s390/include/uapi/asm/unistd.h
@@ -282,7 +282,7 @@
 #define __NR_finit_module	344
 #define __NR_sched_setattr	345
 #define __NR_sched_getattr	346
-#define NR_syscalls 345
+#define NR_syscalls 347
 
 /* 
  * There are some system calls that are not present on 64 bit, some
-- 
1.8.1.4
