Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36915 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbeIBVuN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 Sep 2018 17:50:13 -0400
From: Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex in text_poke*()"
Date: Sun, 2 Sep 2018 10:32:19 -0700
Message-ID: <20180902173224.30606-2-namit@vmware.com>
In-Reply-To: <20180902173224.30606-1-namit@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Nadav Amit <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20180902173219.1VpfcJ2cdiedy6nz7S3HktNywpX943BOjFguutgqSmo@z>

text_mutex is expected to be held before text_poke() is called, but we
cannot add a lockdep assertion since kgdb does not take it, and instead
*supposedly* ensures the lock is not taken and will not be acquired by
any other core while text_poke() is running.

The reason for the "supposedly" comment is that it is not entirely clear
that this would be the case if gdb_do_roundup is zero.

Add a comment to clarify this behavior, and restore the assertions as
they were before the recent commit.

This partially reverts commit 9222f606506c ("x86/alternatives:
Lockdep-enforce text_mutex in text_poke*()")

Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Fixes: 9222f606506c ("x86/alternatives: Lockdep-enforce text_mutex in text_poke*()")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/alternative.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b9d5e7c9ef43..e9be18245698 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -684,6 +684,11 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
  * It means the size must be writable atomically and the address must be aligned
  * in a way that permits an atomic write. It also makes sure we fit on a single
  * page.
+ *
+ * Context: Must be called under text_mutex. kgdb is an exception: it does not
+ *	    hold the mutex, as it *supposedly* ensures that no other core is
+ *	    holding the mutex and ensures that none of them will acquire the
+ *	    mutex while the code runs.
  */
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
@@ -698,8 +703,6 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(!after_bootmem);
 
-	lockdep_assert_held(&text_mutex);
-
 	if (!core_kernel_text((unsigned long)addr)) {
 		pages[0] = vmalloc_to_page(addr);
 		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
-- 
2.17.1
