From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 02/30] x86-64: Use explicit sizes in sigcontext.h, prepare for x32
Date: Sun, 19 Feb 2012 16:07:40 -0800
Message-ID: <1329696488-16970-3-git-send-email-hpa@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57102 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab2BTAJn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2012 19:09:43 -0500
In-Reply-To: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com

From: "H. Peter Anvin" <hpa@zytor.com>

Use explicit sizes (__u64) instead of implicit sizes (unsigned long)
in the definition for sigcontext.h; this will allow this structure to
be shared between the x86-64 native ABI and the x32 ABI.

Originally-by: H. J. Lu <hjl.tools@gmail.com>
Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Link: http://lkml.kernel.org/n/tip-4pr1xnnksprt7t0h3w5fw4rv@git.kernel.org
---
 arch/x86/include/asm/sigcontext.h |   57 +++++++++++++++++++-----------------
 1 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/sigcontext.h b/arch/x86/include/asm/sigcontext.h
index 04459d2..4a08538 100644
--- a/arch/x86/include/asm/sigcontext.h
+++ b/arch/x86/include/asm/sigcontext.h
@@ -230,34 +230,37 @@ struct sigcontext {
  * User-space might still rely on the old definition:
  */
 struct sigcontext {
-	unsigned long r8;
-	unsigned long r9;
-	unsigned long r10;
-	unsigned long r11;
-	unsigned long r12;
-	unsigned long r13;
-	unsigned long r14;
-	unsigned long r15;
-	unsigned long rdi;
-	unsigned long rsi;
-	unsigned long rbp;
-	unsigned long rbx;
-	unsigned long rdx;
-	unsigned long rax;
-	unsigned long rcx;
-	unsigned long rsp;
-	unsigned long rip;
-	unsigned long eflags;		/* RFLAGS */
-	unsigned short cs;
-	unsigned short gs;
-	unsigned short fs;
-	unsigned short __pad0;
-	unsigned long err;
-	unsigned long trapno;
-	unsigned long oldmask;
-	unsigned long cr2;
+	__u64 r8;
+	__u64 r9;
+	__u64 r10;
+	__u64 r11;
+	__u64 r12;
+	__u64 r13;
+	__u64 r14;
+	__u64 r15;
+	__u64 rdi;
+	__u64 rsi;
+	__u64 rbp;
+	__u64 rbx;
+	__u64 rdx;
+	__u64 rax;
+	__u64 rcx;
+	__u64 rsp;
+	__u64 rip;
+	__u64 eflags;		/* RFLAGS */
+	__u16 cs;
+	__u16 gs;
+	__u16 fs;
+	__u16 __pad0;
+	__u64 err;
+	__u64 trapno;
+	__u64 oldmask;
+	__u64 cr2;
 	struct _fpstate __user *fpstate;	/* zero when no FPU context */
-	unsigned long reserved1[8];
+#ifndef __LP64__
+	__u32 __fpstate_pad;
+#endif
+	__u64 reserved1[8];
 };
 #endif /* !__KERNEL__ */
 
-- 
1.7.6.5
