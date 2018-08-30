Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:14372 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbeH3VhU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Aug 2018 17:37:20 -0400
From: Nadav Amit <namit@vmware.com>
Subject: [PATCH 1/6] x86/alternatives: clarify text_mutex use in text_poke
Date: Thu, 30 Aug 2018 10:32:13 -0700
Message-ID: <20180830173218.238900-2-namit@vmware.com>
In-Reply-To: <20180830173218.238900-1-namit@vmware.com>
References: <20180830173218.238900-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20180830173213.m_XpB18LtyEYminqfqgVoIKPHvPFPHwJPJG_IUJ3Ly4@z>

text_mutex is expected to be held before text_poke() is called, but we
cannot add a lockdep assertion since kgdb does not take it, and instead
*supposedly* ensures the lock is not taken and will not be acquired by
any other core while text_poke() is running.

The reason for the "supposedly" comment is that it is not entirely clear
that this would be the case if gdb_do_roundup is zero.

Add a comment to clarify this behavior.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/alternative.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 014f214da581..d0c0d8b724e1 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -685,7 +685,10 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
  * in a way that permits an atomic write. It also makes sure we fit on a single
  * page.
  *
- * Note: Must be called under text_mutex.
+ * Context: Must be called under text_mutex. kgdb is an exception: it does not
+ *	    hold the mutex, as it *supposedly* ensures that no other core is
+ *	    holding the mutex and ensures that none of them will acquire the
+ *	    mutex while the code runs.
  */
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
-- 
2.17.1
