From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 25/30] x86: Add #ifdef CONFIG_COMPAT to <asm/sys_ia32.h>
Date: Sun, 19 Feb 2012 16:08:03 -0800
Message-ID: <1329696488-16970-26-git-send-email-hpa@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57376 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab2BTAUP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2012 19:20:15 -0500
In-Reply-To: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com

From: "H. Peter Anvin" <hpa@zytor.com>

Unfortunately a lot of the compat types are guarded with CONFIG_COMPAT
or the equivalent, so add a similar guard to <asm/sys_ia32.h> to avoid
compilation failures when CONFIG_COMPAT=n.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/include/asm/sys_ia32.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/sys_ia32.h b/arch/x86/include/asm/sys_ia32.h
index 68da87b..3fda9db4 100644
--- a/arch/x86/include/asm/sys_ia32.h
+++ b/arch/x86/include/asm/sys_ia32.h
@@ -10,6 +10,8 @@
 #ifndef _ASM_X86_SYS_IA32_H
 #define _ASM_X86_SYS_IA32_H
 
+#ifdef CONFIG_COMPAT
+
 #include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <linux/types.h>
@@ -81,4 +83,7 @@ asmlinkage long sys32_ipc(u32, int, int, int, compat_uptr_t, u32);
 
 asmlinkage long sys32_fanotify_mark(int, unsigned int, u32, u32, int,
 				    const char __user *);
+
+#endif /* CONFIG_COMPAT */
+
 #endif /* _ASM_X86_SYS_IA32_H */
-- 
1.7.6.5
