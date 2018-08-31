Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbeHaIwQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Aug 2018 04:52:16 -0400
Date: Fri, 31 Aug 2018 13:46:35 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/6] x86/alternatives: text_poke() fixes
Message-ID: <20180831134635.35b6c2a919449adf4b63a133@kernel.org>
In-Reply-To: <20180830173218.238900-1-namit@vmware.com>
References: <20180830173218.238900-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20180831044635.zbGgJKQBsmsSPLDX3Jf2jqCeRAhg9kPaANGRx3TYji4@z>

On Thu, 30 Aug 2018 10:32:12 -0700
Nadav Amit <namit@vmware.com> wrote:

> This patch-set addresses some issues that were raised in a recent
> correspondence and might affect the security and the correctness of code
> patching. (Note that patching performance is not addressed by this
> patch-set).
> 
> The main issue that the patches deal with is the fact that the fixmap
> PTEs that are used for patching are available for access from other
> cores and might be exploited. They are not even flushed from the TLB in
> remote cores, so the risk is even higher. Address this issue by
> introducing a temporary mm that is only used during patching.
> Unfortunately, due to init ordering, fixmap is still used during
> boot-time patching. Future patches can eliminate the need for it.
> 
> The second issue is the missing lockdep assertion to ensure text_mutex
> is taken. It is actually not always taken, so fix the instances that
> were found not to take the lock (although they should be safe even
> without taking the lock).
> 
> Finally, try to be more conservative and to map a single page, instead
> of two, when possible. This helps both security and performance.
> 
> In addition, there is some cleanup of the patching code to make it more
> readable.

OK, this series looks good to me, and tested with ftracetest, kprobe testsets.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!


> 
> RFC->v1:
> - Added handling of error in get_locked_pte()
> - Remove lockdep assertion, clarify text_mutex use instead [masami]
> - Comment fix [peterz]
> - Removed remainders of text_poke return value [masami]
> - Use __weak for poking_init instead of macros [masami]
> - Simplify error handling in poking_init [masami]  
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lkml.org/lkml/2018/8/24/586
> 
> Andy Lutomirski (1):
>   x86/mm: temporary mm struct
> 
> Nadav Amit (5):
>   x86/alternatives: clarify text_mutex use in text_poke
>   fork: provide a function for copying init_mm
>   x86/alternatives: initializing temporary mm for patching
>   x86/alternatives: use temporary mm for text poking
>   x86/alternatives: remove text_poke() return value
> 
>  arch/x86/include/asm/mmu_context.h   |  20 ++++
>  arch/x86/include/asm/pgtable.h       |   3 +
>  arch/x86/include/asm/text-patching.h |   4 +-
>  arch/x86/kernel/alternative.c        | 173 +++++++++++++++++++++++----
>  arch/x86/mm/init_64.c                |  29 +++++
>  include/linux/sched/task.h           |   1 +
>  init/main.c                          |   3 +
>  kernel/fork.c                        |  24 +++-
>  8 files changed, 226 insertions(+), 31 deletions(-)
> 
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
