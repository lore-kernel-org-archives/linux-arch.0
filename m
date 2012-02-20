From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 23/30] x32: Add rt_sigframe_x32
Date: Sun, 19 Feb 2012 16:08:01 -0800
Message-ID: <1329696488-16970-24-git-send-email-hpa@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57347 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781Ab2BTATN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2012 19:19:13 -0500
In-Reply-To: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com

From: "H. Peter Anvin" <hpa@zytor.com>

Add rt_sigframe_x32 to <asm/sigframe.h>.  Unfortunately we can't just
define all the data structures unconditionally, due to the #ifdef
CONFIG_COMPAT in <linux/compat.h> and its trickle-down effects, hence
the #ifdef mess.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/include/asm/sigframe.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
index 4e0fe26..7c7c27c 100644
--- a/arch/x86/include/asm/sigframe.h
+++ b/arch/x86/include/asm/sigframe.h
@@ -59,12 +59,25 @@ struct rt_sigframe_ia32 {
 #endif /* defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION) */
 
 #ifdef CONFIG_X86_64
+
 struct rt_sigframe {
 	char __user *pretcode;
 	struct ucontext uc;
 	struct siginfo info;
 	/* fp state follows here */
 };
+
+#ifdef CONFIG_X86_X32_ABI
+
+struct rt_sigframe_x32 {
+	u64 pretcode;
+	struct ucontext_x32 uc;
+	compat_siginfo_t info;
+	/* fp state follows here */
+};
+
+#endif /* CONFIG_X86_X32_ABI */
+
 #endif /* CONFIG_X86_64 */
 
 #endif /* _ASM_X86_SIGFRAME_H */
-- 
1.7.6.5
