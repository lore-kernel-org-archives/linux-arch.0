From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 02/41] x86: copy_fpstate_to_sigframe(): have fpregs_soft_get() use kernel buffer
Date: Mon, 29 Jun 2020 19:25:49 +0100
Message-ID: <20200629182628.529995-2-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgF2Smo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:44 -0400
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

... then copy_to_user() the results

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/fpu/signal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 9393a445d73c..e0b832df7404 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -170,14 +170,14 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
 
+	if (!static_cpu_has(X86_FEATURE_FPU)) {
+		struct user_i387_ia32_struct fp;
+		fpregs_soft_get(current, NULL, 0, sizeof(fp), &fp, NULL);
+		return copy_to_user(buf, &fp, sizeof(fp)) ? -EFAULT : 0;
+	}
+
 	if (!access_ok(buf, size))
 		return -EACCES;
-
-	if (!static_cpu_has(X86_FEATURE_FPU))
-		return fpregs_soft_get(current, NULL, 0,
-			sizeof(struct user_i387_ia32_struct), NULL,
-			(struct _fpstate_32 __user *) buf) ? -1 : 1;
-
 retry:
 	/*
 	 * Load the FPU registers if they are not valid for the current task.
-- 
2.11.0
