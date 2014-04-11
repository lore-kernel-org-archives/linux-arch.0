From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 04/15] arm64: __NR_compat_syscalls fix
Date: Fri, 11 Apr 2014 12:25:40 +0200
Message-ID: <1397211951-20549-5-git-send-email-miklos@szeredi.hu>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:38375 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075AbaDKK0O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2014 06:26:14 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so3925888eek.24
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2014 03:26:12 -0700 (PDT)
In-Reply-To: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>

From: Miklos Szeredi <mszeredi@suse.cz>

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/unistd32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index bb8eb8a78e67..faa0e1ce59df 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -404,7 +404,7 @@ __SYSCALL(379, sys_finit_module)
 __SYSCALL(380, sys_sched_setattr)
 __SYSCALL(381, sys_sched_getattr)
 
-#define __NR_compat_syscalls		379
+#define __NR_compat_syscalls		382
 
 /*
  * Compat syscall numbers used by the AArch64 kernel.
-- 
1.8.1.4
