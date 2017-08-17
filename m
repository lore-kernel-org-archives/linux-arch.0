From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip 3/4] arm64: Cleanup in_exception_text() and move it in asm/sections.h
Date: Thu, 17 Aug 2017 16:16:06 +0900
Message-ID: <150295415599.14424.2567748523337189088.stgit@devbox>
References: <150295395797.14424.968407208436624832.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750959AbdHQHQ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Aug 2017 03:16:56 -0400
In-Reply-To: <150295395797.14424.968407208436624832.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>

Cleanup in_exception_text() using memory_contains() and
move it in asm/sections.h from asm/trap.h because
section symbols and memory_contains() are defined in
asm/sections.h.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/include/asm/sections.h |   16 ++++++++++++++++
 arch/arm64/include/asm/traps.h    |   16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 941267caa39c..abaa8ac79eaf 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -29,4 +29,20 @@ extern char __inittext_begin[], __inittext_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 
+/**
+ * in_exception_text - check if an address is in exception_text or
+ *			irqentry_text
+ * @addr: virtual address to be checked
+ *
+ * Returns: true if the address specified by @addr is in the exception_text or
+ * irqentry_text, false otherwise.
+ */
+static inline bool in_exception_text(unsigned long addr)
+{
+	return memory_contains(__exception_text_start, __exception_text_end,
+			       (void *)addr, 0) ||
+		memory_contains(__irqentry_text_start, __irqentry_text_end,
+				(void *)addr, 0);
+}
+
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 47a9066f7c86..c3734c3e8115 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -37,20 +37,4 @@ void unregister_undef_hook(struct undef_hook *hook);
 
 void arm64_notify_segfault(struct pt_regs *regs, unsigned long addr);
 
-static inline int __in_irqentry_text(unsigned long ptr)
-{
-	return ptr >= (unsigned long)&__irqentry_text_start &&
-	       ptr < (unsigned long)&__irqentry_text_end;
-}
-
-static inline int in_exception_text(unsigned long ptr)
-{
-	int in;
-
-	in = ptr >= (unsigned long)&__exception_text_start &&
-	     ptr < (unsigned long)&__exception_text_end;
-
-	return in ? : __in_irqentry_text(ptr);
-}
-
 #endif
