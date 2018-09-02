Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:48413 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbeIBVuO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 Sep 2018 17:50:14 -0400
From: Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Date: Sun, 2 Sep 2018 10:32:18 -0700
Message-ID: <20180902173224.30606-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Nadav Amit <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20180902173218.tLCBUZe8dSXmwoXMtFZTavW4N4DZp3tA6gucWGDWPOk@z>

This patch-set addresses some issues that were raised in a recent
correspondence and might affect the security and the correctness of code
patching. (Note that patching performance is not addressed by this
patch-set).

The main issue that the patches deal with is the fact that the fixmap
PTEs that are used for patching are available for access from other
cores and might be exploited. They are not even flushed from the TLB in
remote cores, so the risk is even higher. Address this issue by
introducing a temporary mm that is only used during patching.
Unfortunately, due to init ordering, fixmap is still used during
boot-time patching. Future patches can eliminate the need for it.

The second issue is the missing lockdep assertion to ensure text_mutex
is taken. It is actually not always taken, so fix the instances that
were found not to take the lock (although they should be safe even
without taking the lock).

Finally, try to be more conservative and to map a single page, instead
of two, when possible. This helps both security and performance.

In addition, there is some cleanup of the patching code to make it more
readable.

v1->v2:
- Partial revert of 9222f606506c added to 1/6 [masami]
- Added Masami's reviewed-by tag

RFC->v1:
- Added handling of error in get_locked_pte()
- Remove lockdep assertion, clarify text_mutex use instead [masami]
- Comment fix [peterz]
- Removed remainders of text_poke return value [masami]
- Use __weak for poking_init instead of macros [masami]
- Simplify error handling in poking_init [masami]  

Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.org/lkml/2018/8/24/586

Andy Lutomirski (1):
  x86/mm: temporary mm struct

Nadav Amit (5):
  Fix "x86/alternatives: Lockdep-enforce text_mutex in text_poke*()"
  fork: provide a function for copying init_mm
  x86/alternatives: initializing temporary mm for patching
  x86/alternatives: use temporary mm for text poking
  x86/alternatives: remove text_poke() return value

 arch/x86/include/asm/mmu_context.h   |  20 +++
 arch/x86/include/asm/pgtable.h       |   3 +
 arch/x86/include/asm/text-patching.h |   4 +-
 arch/x86/kernel/alternative.c        | 175 +++++++++++++++++++++++----
 arch/x86/mm/init_64.c                |  29 +++++
 include/linux/sched/task.h           |   1 +
 init/main.c                          |   3 +
 kernel/fork.c                        |  24 +++-
 8 files changed, 227 insertions(+), 32 deletions(-)

-- 
2.17.1
