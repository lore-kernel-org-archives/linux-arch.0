Return-Path: <peterz@infradead.org>
Date: Wed, 23 Oct 2019 16:37:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 00/17] entry: Provide generic implementation for host
 and guest entry/exit work
Message-ID: <20191023143734.GJ1800@hirez.programming.kicks-ass.net>
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023122705.198339581@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023143734.8hvma0RqqbFfh6enfkXdjq0-n-a5yimAy88SGwgZ1bY@z>

On Wed, Oct 23, 2019 at 02:27:05PM +0200, Thomas Gleixner wrote:
>  /Makefile                             |    3 
>  arch/Kconfig                          |    3 
>  arch/x86/Kconfig                      |    1 
>  arch/x86/entry/calling.h              |   12 +
>  arch/x86/entry/common.c               |  264 ++------------------------------
>  arch/x86/entry/entry_32.S             |   41 ----
>  arch/x86/entry/entry_64.S             |   32 ---
>  arch/x86/entry/entry_64_compat.S      |   30 ---
>  arch/x86/include/asm/irqflags.h       |    8 
>  arch/x86/include/asm/paravirt.h       |    9 -
>  arch/x86/include/asm/signal.h         |    1 
>  arch/x86/include/asm/thread_info.h    |    9 -
>  arch/x86/kernel/signal.c              |    2 
>  arch/x86/kernel/traps.c               |   33 ++--
>  arch/x86/kvm/x86.c                    |   17 --
>  arch/x86/mm/fault.c                   |    7 
>  b/arch/x86/include/asm/entry-common.h |  104 ++++++++++++
>  b/arch/x86/kvm/Kconfig                |    1 
>  b/include/linux/entry-common.h        |  280 ++++++++++++++++++++++++++++++++++
>  b/kernel/entry/common.c               |  184 ++++++++++++++++++++++
>  include/linux/kvm_host.h              |   64 +++++++
>  kernel/Makefile                       |    1 
>  virt/kvm/Kconfig                      |    3 
>  23 files changed, 735 insertions(+), 374 deletions(-)

This looks really nice; esp. the cleaned up interrupt state.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
