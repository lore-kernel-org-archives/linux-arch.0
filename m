From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 17/20] signal/x86: Call force_sig_pkuerr from
 __bad_area_nosemaphore
Date: Tue, 18 Sep 2018 22:50:34 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182249120.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-17-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918000546.12552-17-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> There is only one code path that can generate a pkuerr signal.  That
> code path calls __bad_area_nosemaphore and can be dectected by testing
> if si_code == SEGV_PKUERR.  It can be seen from inspection that all of
> the other tests in fill_sig_info_pkey are unnecessary.
> 
> Therefore call force_sig_pkuerr directly from __bad_area_semaphore
> and remove fill_sig_info_pkey.
> 
> At the same time move the comment above force_sig_info_pkey into
> bad_area_access_error, so that the documentation of about pkey

of about? Pick one please

> generation races is not lost.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/x86/mm/fault.c | 75 ++++++++++++++-------------------------------
>  1 file changed, 23 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 11a93f14a674..ccfeed902eee 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -153,56 +153,6 @@ is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long addr)
>  	return prefetch;
>  }
>  
> -/*
> - * A protection key fault means that the PKRU value did not allow
> - * access to some PTE.  Userspace can figure out what PKRU was
> - * from the XSAVE state, and this function fills out a field in
> - * siginfo so userspace can discover which protection key was set
> - * on the PTE.
> - *
> - * If we get here, we know that the hardware signaled a X86_PF_PK
> - * fault and that there was a VMA once we got in the fault
> - * handler.  It does *not* guarantee that the VMA we find here
> - * was the one that we faulted on.
> - *
> - * 1. T1   : mprotect_key(foo, PAGE_SIZE, pkey=4);
> - * 2. T1   : set PKRU to deny access to pkey=4, touches page
> - * 3. T1   : faults...
> - * 4.    T2: mprotect_key(foo, PAGE_SIZE, pkey=5);
> - * 5. T1   : enters fault handler, takes mmap_sem, etc...
> - * 6. T1   : reaches here, sees vma_pkey(vma)=5, when we really
> - *	     faulted on a pte with its pkey=4.
> - */
> -static void fill_sig_info_pkey(int si_signo, int si_code, siginfo_t *info,
> -		u32 *pkey)
> -{
> -	/* This is effectively an #ifdef */
> -	if (!boot_cpu_has(X86_FEATURE_OSPKE))
> -		return;
> -
> -	/* Fault not from Protection Keys: nothing to do */
> -	if ((si_code != SEGV_PKUERR) || (si_signo != SIGSEGV))
> -		return;
> -	/*
> -	 * force_sig_info_fault() is called from a number of
> -	 * contexts, some of which have a VMA and some of which
> -	 * do not.  The X86_PF_PK handing happens after we have a
> -	 * valid VMA, so we should never reach this without a
> -	 * valid VMA.
> -	 */
> -	if (!pkey) {
> -		WARN_ONCE(1, "PKU fault with no VMA passed in");
> -		info->si_pkey = 0;
> -		return;
> -	}
> -	/*
> -	 * si_pkey should be thought of as a strong hint, but not
> -	 * absolutely guranteed to be 100% accurate because of
> -	 * the race explained above.
> -	 */
> -	info->si_pkey = *pkey;
> -}
> -
>  static void
>  force_sig_info_fault(int si_signo, int si_code, unsigned long address,
>  		     struct task_struct *tsk, u32 *pkey)
> @@ -215,8 +165,6 @@ force_sig_info_fault(int si_signo, int si_code, unsigned long address,
>  	info.si_code	= si_code;
>  	info.si_addr	= (void __user *)address;
>  
> -	fill_sig_info_pkey(si_signo, si_code, &info, pkey);
> -
>  	force_sig_info(si_signo, &info, tsk);
>  }
>  
> @@ -884,6 +832,9 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>  		tsk->thread.error_code	= error_code;
>  		tsk->thread.trap_nr	= X86_TRAP_PF;
>  
> +		if (si_code == SEGV_PKUERR)
> +			force_sig_pkuerr((void __user *)address, *pkey);
> +
>  		force_sig_info_fault(SIGSEGV, si_code, address, tsk, pkey);
>  
>  		return;
> @@ -949,6 +900,26 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
>  	 * if pkeys are compiled out.
>  	 */
>  	if (bad_area_access_from_pkeys(error_code, vma)) {
> +		/*
> +		 * A protection key fault means that the PKRU value did not allow
> +		 * access to some PTE.  Userspace can figure out what PKRU was
> +		 * from the XSAVE state.  This function captures the pkey from
> +		 * the vma and passes it to userspace so userspace can discover
> +		 * which protection key was set on the PTE.
> +		 *
> +		 * If we get here, we know that the hardware signaled a X86_PF_PK
> +		 * fault and that there was a VMA once we got in the fault
> +		 * handler.  It does *not* guarantee that the VMA we find here
> +		 * was the one that we faulted on.
> +		 *
> +		 * 1. T1   : mprotect_key(foo, PAGE_SIZE, pkey=4);
> +		 * 2. T1   : set PKRU to deny access to pkey=4, touches page
> +		 * 3. T1   : faults...
> +		 * 4.    T2: mprotect_key(foo, PAGE_SIZE, pkey=5);
> +		 * 5. T1   : enters fault handler, takes mmap_sem, etc...
> +		 * 6. T1   : reaches here, sees vma_pkey(vma)=5, when we really
> +		 *	     faulted on a pte with its pkey=4.
> +		 */
>  		u32 pkey = vma_pkey(vma);
>  		__bad_area(regs, error_code, address, &pkey, SEGV_PKUERR);

Newline between variable declaration and code please.

With that fixed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
