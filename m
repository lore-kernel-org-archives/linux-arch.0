Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:43187 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727198AbeH2MJH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 08:09:07 -0400
From: Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH 0/6] x86: text_poke() fixes
Date: Wed, 29 Aug 2018 01:11:41 -0700
Message-ID: <20180829081147.184610-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20180829081141.WNA5ThcB2olIOoy-LhYD5Tx7g2PlPMGg4LZMOM7Dxco@z>

This patch-set addresses some issues that were raised in the recent
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

[ Andy: please provide your SOB for your patch ]

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>

Andy Lutomirski (1):
  x86/mm: temporary mm struct

Nadav Amit (5):
  x86/alternative: assert text_mutex is taken
  fork: provide a function for copying init_mm
  x86/alternatives: initializing temporary mm for patching
  x86/alternatives: use temporary mm for text poking
  x86/alternatives: remove text_poke() return value

 arch/x86/include/asm/mmu_context.h   |  20 ++++
 arch/x86/include/asm/pgtable.h       |   4 +
 arch/x86/include/asm/text-patching.h |   4 +-
 arch/x86/kernel/alternative.c        | 157 +++++++++++++++++++++++----
 arch/x86/kernel/kgdb.c               |   9 ++
 arch/x86/mm/init_64.c                |  35 ++++++
 include/asm-generic/pgtable.h        |   4 +
 include/linux/sched/task.h           |   1 +
 init/main.c                          |   1 +
 kernel/fork.c                        |  24 +++-
 10 files changed, 230 insertions(+), 29 deletions(-)

-- 
2.17.1
