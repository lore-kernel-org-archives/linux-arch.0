From: Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH 13/22] arm64: mte: Handle synchronous and asynchronous tag
 check faults
Date: Fri, 13 Dec 2019 17:43:15 -0800
Message-ID: <CAMn1gO6RDrpkO6hygTUuXbsE5XTD+FEsZKpo5cqgg+nQWfBVKQ@mail.gmail.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-14-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191211184027.20130-14-catalin.marinas@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Evgenii Stepanov <eugenis@google.com>, Kostya Serebryany <kcc@google.com>
Cc: linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 11, 2019 at 10:44 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> The Memory Tagging Extension has two modes of notifying a tag check
> fault at EL0, configurable through the SCTLR_EL1.TCF0 field:
>
> 1. Synchronous raising of a Data Abort exception with DFSC 17.
> 2. Asynchronous setting of a cumulative bit in TFSRE0_EL1.
>
> Add the exception handler for the synchronous exception and handling of
> the asynchronous TFSRE0_EL1.TF0 bit setting via a new TIF flag in
> do_notify_resume().
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/thread_info.h |  4 +++-
>  arch/arm64/kernel/entry.S            | 17 +++++++++++++++++
>  arch/arm64/kernel/process.c          |  7 +++++++
>  arch/arm64/kernel/signal.c           |  8 ++++++++
>  arch/arm64/mm/fault.c                |  9 ++++++++-
>  5 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index f0cec4160136..f759a0215a71 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -63,6 +63,7 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define TIF_FOREIGN_FPSTATE    3       /* CPU's FP state is not current's */
>  #define TIF_UPROBE             4       /* uprobe breakpoint or singlestep */
>  #define TIF_FSCHECK            5       /* Check FS is USER_DS on return */
> +#define TIF_MTE_ASYNC_FAULT    6       /* MTE Asynchronous Tag Check Fault */
>  #define TIF_NOHZ               7
>  #define TIF_SYSCALL_TRACE      8       /* syscall trace active */
>  #define TIF_SYSCALL_AUDIT      9       /* syscall auditing */
> @@ -93,10 +94,11 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define _TIF_FSCHECK           (1 << TIF_FSCHECK)
>  #define _TIF_32BIT             (1 << TIF_32BIT)
>  #define _TIF_SVE               (1 << TIF_SVE)
> +#define _TIF_MTE_ASYNC_FAULT   (1 << TIF_MTE_ASYNC_FAULT)
>
>  #define _TIF_WORK_MASK         (_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
>                                  _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
> -                                _TIF_UPROBE | _TIF_FSCHECK)
> +                                _TIF_UPROBE | _TIF_FSCHECK | _TIF_MTE_ASYNC_FAULT)
>
>  #define _TIF_SYSCALL_WORK      (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>                                  _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 7c6a0a41676f..c221a539e61d 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -144,6 +144,22 @@ alternative_cb_end
>  #endif
>         .endm
>
> +       // Check for MTE asynchronous tag check faults
> +       .macro check_mte_async_tcf, flgs, tmp
> +#ifdef CONFIG_ARM64_MTE
> +alternative_if_not ARM64_MTE
> +       b       1f
> +alternative_else_nop_endif
> +       mrs_s   \tmp, SYS_TFSRE0_EL1
> +       tbz     \tmp, #SYS_TFSR_EL1_TF0_SHIFT, 1f
> +       // Asynchronous TCF occurred at EL0, set the TI flag
> +       orr     \flgs, \flgs, #_TIF_MTE_ASYNC_FAULT
> +       str     \flgs, [tsk, #TSK_TI_FLAGS]
> +       msr_s   SYS_TFSRE0_EL1, xzr
> +1:
> +#endif
> +       .endm
> +
>         .macro  kernel_entry, el, regsize = 64
>         .if     \regsize == 32
>         mov     w0, w0                          // zero upper 32 bits of x0
> @@ -171,6 +187,7 @@ alternative_cb_end
>         ldr     x19, [tsk, #TSK_TI_FLAGS]       // since we can unmask debug
>         disable_step_tsk x19, x20               // exceptions when scheduling.
>
> +       check_mte_async_tcf x19, x22
>         apply_ssbd 1, x22, x23
>
>         .else
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 71f788cd2b18..dd98d539894e 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -317,12 +317,19 @@ static void flush_tagged_addr_state(void)
>                 clear_thread_flag(TIF_TAGGED_ADDR);
>  }
>
> +static void flush_mte_state(void)
> +{
> +       if (system_supports_mte())
> +               clear_thread_flag(TIF_MTE_ASYNC_FAULT);
> +}
> +
>  void flush_thread(void)
>  {
>         fpsimd_flush_thread();
>         tls_thread_flush();
>         flush_ptrace_hw_breakpoint(current);
>         flush_tagged_addr_state();
> +       flush_mte_state();
>  }
>
>  void release_thread(struct task_struct *dead_task)
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index dd2cdc0d5be2..41fae64af82a 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -730,6 +730,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
>         regs->regs[29] = (unsigned long)&user->next_frame->fp;
>         regs->pc = (unsigned long)ka->sa.sa_handler;
>
> +       /* TCO (Tag Check Override) always cleared for signal handlers */
> +       regs->pstate &= ~PSR_TCO_BIT;
> +
>         if (ka->sa.sa_flags & SA_RESTORER)
>                 sigtramp = ka->sa.sa_restorer;
>         else
> @@ -921,6 +924,11 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
>                         if (thread_flags & _TIF_UPROBE)
>                                 uprobe_notify_resume(regs);
>
> +                       if (thread_flags & _TIF_MTE_ASYNC_FAULT) {
> +                               clear_thread_flag(TIF_MTE_ASYNC_FAULT);
> +                               force_signal_inject(SIGSEGV, SEGV_MTEAERR, 0);

In the case where the kernel is entered due to a syscall, this will
inject a signal, but only after servicing the syscall. This means
that, for example, if the syscall is exit(), the async tag check
failure will be silently ignored. I can reproduce the problem with the
program below:

.arch_extension mte

.globl _start
_start:
mov x0, #0x37 // PR_SET_TAGGED_ADDR_CTRL
mov x1, #0xd // PR_TAGGED_ADDR_ENABLE | PR_MTE_TCF_ASYNC | (1 <<
PR_MTE_EXCL_SHIFT)
mov x2, #0
mov x3, #0
mov x4, #0
mov x8, #0xa7 // prctl
svc #0

mov x0, xzr
mov w1, #0x1000
mov w2, #0x23 // PROT_READ|PROT_WRITE|PROT_MTE
mov w3, #0x22 // MAP_PRIVATE|MAP_ANONYMOUS
mov w4, #0xffffffff
mov x5, xzr
mov x8, #0xde // mmap
svc #0

orr x0, x0, #(1 << 56)
str x0, [x0] // <- tag check fail here

// mov x0, #0
// mov x8, #0x17 // dup
// svc #0

mov x0, #0
mov x8, #0x5d // exit
svc #0

If I run this program, it terminates successfully (i.e. the exit
syscall succeeds). And if I uncomment the dup() syscall and run the
program under strace, I see that the program dies with SIGSEGV, but
not before servicing the dup().

This patch fixes the problem for me:

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 9a9d98a443fc..d0c8918dee00 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -94,6 +94,8 @@ static void el0_svc_common(struct pt_regs *regs, int
scno, int sc_nr,
                           const syscall_fn_t syscall_table[])
 {
        unsigned long flags = current_thread_info()->flags;
+       if (flags & _TIF_MTE_ASYNC_FAULT)
+               return;

        regs->orig_x0 = regs->regs[0];
        regs->syscallno = scno;

I am not sure whether this is the correct fix, though.

Peter

> +                       }
> +
>                         if (thread_flags & _TIF_SIGPENDING)
>                                 do_signal(regs);
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 077b02a2d4d3..ef3bfa2bf2b1 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -660,6 +660,13 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>         return 0;
>  }
>
> +static int do_tag_check_fault(unsigned long addr, unsigned int esr,
> +                             struct pt_regs *regs)
> +{
> +       do_bad_area(addr, esr, regs);
> +       return 0;
> +}
> +
>  static const struct fault_info fault_info[] = {
>         { do_bad,               SIGKILL, SI_KERNEL,     "ttbr address size fault"       },
>         { do_bad,               SIGKILL, SI_KERNEL,     "level 1 address size fault"    },
> @@ -678,7 +685,7 @@ static const struct fault_info fault_info[] = {
>         { do_page_fault,        SIGSEGV, SEGV_ACCERR,   "level 2 permission fault"      },
>         { do_page_fault,        SIGSEGV, SEGV_ACCERR,   "level 3 permission fault"      },
>         { do_sea,               SIGBUS,  BUS_OBJERR,    "synchronous external abort"    },
> -       { do_bad,               SIGKILL, SI_KERNEL,     "unknown 17"                    },
> +       { do_tag_check_fault,   SIGSEGV, SEGV_MTESERR,  "synchronous tag check fault"   },
>         { do_bad,               SIGKILL, SI_KERNEL,     "unknown 18"                    },
>         { do_bad,               SIGKILL, SI_KERNEL,     "unknown 19"                    },
>         { do_sea,               SIGKILL, SI_KERNEL,     "level 0 (translation table walk)"      },
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
