Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36915 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbeIBVuQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 Sep 2018 17:50:16 -0400
From: Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 6/6] x86/alternatives: remove text_poke() return value
Date: Sun, 2 Sep 2018 10:32:24 -0700
Message-ID: <20180902173224.30606-7-namit@vmware.com>
In-Reply-To: <20180902173224.30606-1-namit@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Nadav Amit <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20180902173224.SKzBbWaA282IxTYbDnW1Qu-RI2w26NSUkoyEW2JOvc0@z>

The return value of text_poke() is meaningless - it is one of the
function inputs. One day someone may allow the callers to deal with
text_poke() failures, if those actually happen.

In the meanwhile, remove the return value.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/text-patching.h | 2 +-
 arch/x86/kernel/alternative.c        | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index ffe7902cc326..1f73f71b4de2 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -34,7 +34,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
  * On the local CPU you need to be protected again NMI or MCE handlers seeing an
  * inconsistent instruction while you patch.
  */
-extern void *text_poke(void *addr, const void *opcode, size_t len);
+extern void text_poke(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
 extern int after_bootmem;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index edca599c4479..7a30c5a3ca37 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -809,7 +809,7 @@ static void text_poke_safe(void *addr, const void *opcode, size_t len,
  *	    holding the mutex and ensures that none of them will acquire the
  *	    mutex while the code runs.
  */
-void *text_poke(void *addr, const void *opcode, size_t len)
+void text_poke(void *addr, const void *opcode, size_t len)
 {
 	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
 	struct page *pages[2] = {0};
@@ -851,7 +851,6 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 	BUG_ON(memcmp(addr, opcode, len));
 
 	local_irq_restore(flags);
-	return addr;
 }
 
 static void do_sync_core(void *info)
-- 
2.17.1
