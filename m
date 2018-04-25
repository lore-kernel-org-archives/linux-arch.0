From: Vincent Chen <deanbo422@gmail.com>
Subject: Re: [REVIEW][PATCH 09/22] signal/nds32: Use force_sig_fault where appropriate
Date: Wed, 25 Apr 2018 19:29:34 +0800
Message-ID: <CAJsyPhy_GbfnzCNa_rJDMSRrUfVKOJKCVqrkWkDUmH6jPDGPhw@mail.gmail.com>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-9-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420143811.9994-9-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

2018-04-20 22:37 GMT+08:00 Eric W. Biederman <ebiederm@xmission.com>:
> Filling in struct siginfo before calling force_sig_info a tedious and
> error prone process, where once in a great while the wrong fields
> are filled out, and siginfo has been inconsistently cleared.
>
> Simplify this process by using the helper force_sig_fault.  Which
> takes as a parameters all of the information it needs, ensures
> all of the fiddly bits of filling in struct siginfo are done properly
> and then calls force_sig_info.
>
> In short about a 5 line reduction in code for every time force_sig_info
> is called, which makes the calling function clearer.
>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/nds32/kernel/traps.c | 20 ++++----------------
>  arch/nds32/mm/fault.c     | 19 +++++--------------
>  2 files changed, 9 insertions(+), 30 deletions(-)
>
> diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
> index 46911768f4b5..636d1c7aa895 100644
> --- a/arch/nds32/kernel/traps.c
> +++ b/arch/nds32/kernel/traps.c
> @@ -222,20 +222,13 @@ void die_if_kernel(const char *str, struct pt_regs *regs, int err)
>
>  int bad_syscall(int n, struct pt_regs *regs)
>  {
> -       siginfo_t info;
> -
>         if (current->personality != PER_LINUX) {
>                 send_sig(SIGSEGV, current, 1);
>                 return regs->uregs[0];
>         }
>
> -       clear_siginfo(&info);
> -       info.si_signo = SIGILL;
> -       info.si_errno = 0;
> -       info.si_code = ILL_ILLTRP;
> -       info.si_addr = (void __user *)instruction_pointer(regs) - 4;
> -
> -       force_sig_info(SIGILL, &info, current);
> +       force_sig_fault(SIGILL, ILL_ILLTRP,
> +                       (void __user *)instruction_pointer(regs) - 4, current);
>         die_if_kernel("Oops - bad syscall", regs, n);
>         return regs->uregs[0];
>  }
> @@ -288,16 +281,11 @@ void __init early_trap_init(void)
>  void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
>                   int error_code, int si_code)
>  {
> -       struct siginfo info;
> -
>         tsk->thread.trap_no = ENTRY_DEBUG_RELATED;
>         tsk->thread.error_code = error_code;
>
> -       clear_siginfo(&info);
> -       info.si_signo = SIGTRAP;
> -       info.si_code = si_code;
> -       info.si_addr = (void __user *)instruction_pointer(regs);
> -       force_sig_info(SIGTRAP, &info, tsk);
> +       force_sig_fault(SIGTRAP, si_code
> +                       (void __user *)instruction_pointer(regs), tsk);
>  }
>

I found a comma is missing after argument si_code.

>  void do_debug_trap(unsigned long entry, unsigned long addr,
> diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
> index 876ee01ff80a..9bdb7c3ecbb6 100644
> --- a/arch/nds32/mm/fault.c
> +++ b/arch/nds32/mm/fault.c
> @@ -72,16 +72,15 @@ void do_page_fault(unsigned long entry, unsigned long addr,
>         struct task_struct *tsk;
>         struct mm_struct *mm;
>         struct vm_area_struct *vma;
> -       siginfo_t info;
> +       int si_code;
>         int fault;
>         unsigned int mask = VM_READ | VM_WRITE | VM_EXEC;
>         unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
>
> -       clear_siginfo(&info);
>         error_code = error_code & (ITYPE_mskINST | ITYPE_mskETYPE);
>         tsk = current;
>         mm = tsk->mm;
> -       info.si_code = SEGV_MAPERR;
> +       si_code = SEGV_MAPERR;
>         /*
>          * We fault-in kernel-space virtual memory on-demand. The
>          * 'reference' page table is init_mm.pgd.
> @@ -162,7 +161,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
>          */
>
>  good_area:
> -       info.si_code = SEGV_ACCERR;
> +       si_code = SEGV_ACCERR;
>
>         /* first do some preliminary protection checks */
>         if (entry == ENTRY_PTE_NOT_PRESENT) {
> @@ -267,11 +266,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
>                 tsk->thread.address = addr;
>                 tsk->thread.error_code = error_code;
>                 tsk->thread.trap_no = entry;
> -               info.si_signo = SIGSEGV;
> -               info.si_errno = 0;
> -               /* info.si_code has been set above */
> -               info.si_addr = (void *)addr;
> -               force_sig_info(SIGSEGV, &info, tsk);
> +               force_sig_fault(SIGSEGV, si_code, (void __user *)addr, tsk);
>                 return;
>         }
>
> @@ -340,11 +335,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
>         tsk->thread.address = addr;
>         tsk->thread.error_code = error_code;
>         tsk->thread.trap_no = entry;
> -       info.si_signo = SIGBUS;
> -       info.si_errno = 0;
> -       info.si_code = BUS_ADRERR;
> -       info.si_addr = (void *)addr;
> -       force_sig_info(SIGBUS, &info, tsk);
> +       force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)addr, tsk);
>
>         return;
>
> --
> 2.14.1
>


Except the missing comma in send_sigtrap(), I think this patch for nds32 is OK.

Vincent Chen
