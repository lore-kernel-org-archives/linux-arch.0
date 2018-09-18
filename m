From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 19/20] signal/x86: Pass pkey by value
Date: Tue, 18 Sep 2018 22:52:13 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182251590.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-19-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918000546.12552-19-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> Now that si_code == SEGV_PKUERR is the flag indicating that a pkey
> is present there is no longer a need to pass a pointer to a local
> pkey value, instead pkey can be passed more efficiently by value.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/mm/fault.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 548396aa03e1..c09a0c2fa614 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -769,7 +769,7 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
>  
>  static void
>  __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
> -		       unsigned long address, u32 *pkey, int si_code)
> +		       unsigned long address, u32 pkey, int si_code)
>  {
>  	struct task_struct *tsk = current;
>  
> @@ -818,7 +818,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>  		tsk->thread.trap_nr	= X86_TRAP_PF;
>  
>  		if (si_code == SEGV_PKUERR)
> -			force_sig_pkuerr((void __user *)address, *pkey);
> +			force_sig_pkuerr((void __user *)address, pkey);
>  
>  		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
>  
> @@ -835,12 +835,12 @@ static noinline void
>  bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>  		     unsigned long address)
>  {
> -	__bad_area_nosemaphore(regs, error_code, address, NULL, SEGV_MAPERR);
> +	__bad_area_nosemaphore(regs, error_code, address, 0, SEGV_MAPERR);
>  }
>  
>  static void
>  __bad_area(struct pt_regs *regs, unsigned long error_code,
> -	   unsigned long address, u32 *pkey, int si_code)
> +	   unsigned long address, u32 pkey, int si_code)
>  {
>  	struct mm_struct *mm = current->mm;
>  	/*
> @@ -855,7 +855,7 @@ __bad_area(struct pt_regs *regs, unsigned long error_code,
>  static noinline void
>  bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address)
>  {
> -	__bad_area(regs, error_code, address, NULL, SEGV_MAPERR);
> +	__bad_area(regs, error_code, address, 0, SEGV_MAPERR);
>  }
>  
>  static inline bool bad_area_access_from_pkeys(unsigned long error_code,
> @@ -906,10 +906,10 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
>  		 *	     faulted on a pte with its pkey=4.
>  		 */
>  		u32 pkey = vma_pkey(vma);
> -		__bad_area(regs, error_code, address, &pkey, SEGV_PKUERR);
> +		__bad_area(regs, error_code, address, pkey, SEGV_PKUERR);
>  	}
>  	else
> -		__bad_area(regs, error_code, address, NULL, SEGV_ACCERR);
> +		__bad_area(regs, error_code, address, 0, SEGV_ACCERR);
>  }
>  
>  static void
> -- 
> 2.17.1
> 
> 
