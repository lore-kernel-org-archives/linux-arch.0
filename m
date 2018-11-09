From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [PATCH] ARC: MM: fix UB and kernel resourse leak in do_page_fault
Date: Fri, 9 Nov 2018 09:32:12 -0800
Message-ID: <fc14368c-bf00-1e55-5b0e-eb50a848c952@synopsys.com>
References: <20181107121249.6657-1-Eugeniy.Paltsev@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107121249.6657-1-Eugeniy.Paltsev@synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alexey Brodkin <alexey.brodkin@synopsys.com>, "Eric W . Biederman" <ebiederm@xmission.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 11/7/18 4:12 AM, Eugeniy Paltsev wrote:
> Commit 15773ae938d8 ("signal/arc: Use force_sig_fault where
> appropriate") adds undefined behaviour and kernel resource leak
> to userspace in ARC do_page_fault() implementation.
> 
> This happens because we don't initialize si_code variable after we
> switch to force_sig_fault using. si_code (as a part of siginfo_t
> structure) was previously initialized by clear_siginfo(&info) call
> which was removed.
> 
> Undefined behaviour path:
> -------------------->8---------------------------
> }}} a/arch/arc/mm/fault.c
> !! -67,6 +67,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
>         struct task_struct *tsk = current;
>         struct mm_struct *mm = tsk->mm;
> +       /// >>> si_code - uninitialized
>         int si_code;
>         int ret;
>         vm_fault_t fault;
>         int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
> !! -81,8 +82,10 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
>          * only copy the information from the master page table,
>          * nothing more.
>          */
> +       /// >>> take true branch
>         if (address >= VMALLOC_START) {
>                 ret = handle_kernel_vaddr_fault(address);
> +               /// >>> take true branch
>                 if (unlikely(ret))

While the fix is legit, are you sure this code path was taken. VMALLOC_START is
memory for kernel modules and/or vmalloc. So the fault was induced in kernel space
in which case user_mode)r) will not be true.


> +                       /// >>> jump to label "bad_area_nosemaphore"
>                         goto bad_area_nosemaphore;
>                 else
> !! -193,10 +196,13 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
>  bad_area:
>         up_read(&mm->mmap_sem);
> 
> +       /// >>> reach label "bad_area_nosemaphore"
>  bad_area_nosemaphore:
>         /* User mode accesses just cause a SIGSEGV */
> +       /// >>> take true branch
>         if (user_mode(regs)) {
>                 tsk->thread.fault_address = address;
> +               /// >>> Ooops:
> +               /// >>> use uninitialized value "si_code"
> +               /// >>> when calling "force_sig_fault"
>                 force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
>                 return;
>         }
> -------------------->8---------------------------
> 
> Fixes: 15773ae938d8 ("signal/arc: Use force_sig_fault where appropriate")
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Added to for-curr after trimming the changelog

Thx,
-Vineet
