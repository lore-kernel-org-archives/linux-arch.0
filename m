From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 22/30] x32: Add struct ucontext_x32
Date: Sun, 19 Feb 2012 16:08:00 -0800
Message-ID: <1329696488-16970-23-git-send-email-hpa@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57338 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab2BTASs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2012 19:18:48 -0500
In-Reply-To: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com

From: "H. J. Lu" <hjl.tools@gmail.com>

Add a definition for struct ucontext_x32; this is inherently a mix of
the 32- and 64-bit versions.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/include/asm/ia32.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index 1f7e625..c6435ab 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -43,6 +43,15 @@ struct ucontext_ia32 {
 	compat_sigset_t	  uc_sigmask;	/* mask last for extensibility */
 };
 
+struct ucontext_x32 {
+	unsigned int	  uc_flags;
+	unsigned int 	  uc_link;
+	stack_ia32_t	  uc_stack;
+	unsigned int	  uc__pad0;     /* needed for alignment */
+	struct sigcontext uc_mcontext;  /* the 64-bit sigcontext type */
+	compat_sigset_t	  uc_sigmask;	/* mask last for extensibility */
+};
+
 /* This matches struct stat64 in glibc2.2, hence the absolutely
  * insane amounts of padding around dev_t's.
  */
-- 
1.7.6.5
