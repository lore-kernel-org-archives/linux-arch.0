From: Rich Felker <dalias@libc.org>
Subject: Re: [REVIEW][PATCH 16/22] signal/sh: Use force_sig_fault where
 appropriate
Date: Fri, 20 Apr 2018 10:55:14 -0400
Message-ID: <20180420145514.GP3094@brightrain.aerifal.cx>
References: <87604mhrnb.fsf@xmission.com>
 <20180420143811.9994-16-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180420143811.9994-16-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 20, 2018 at 09:38:05AM -0500, Eric W. Biederman wrote:
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
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/sh/kernel/traps_32.c | 19 +++++--------------
>  arch/sh/math-emu/math.c   |  9 ++-------
>  arch/sh/mm/fault.c        | 10 +---------
>  3 files changed, 8 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
> index e85e59c3d6df..660a4bc17698 100644
> --- a/arch/sh/kernel/traps_32.c
> +++ b/arch/sh/kernel/traps_32.c
> @@ -477,7 +477,6 @@ asmlinkage void do_address_error(struct pt_regs *regs,
>  {
>  	unsigned long error_code = 0;
>  	mm_segment_t oldfs;
> -	siginfo_t info;
>  	insn_size_t instruction;
>  	int tmp;
>  
> @@ -537,12 +536,7 @@ asmlinkage void do_address_error(struct pt_regs *regs,
>  		       "access (PC %lx PR %lx)\n", current->comm, regs->pc,
>  		       regs->pr);
>  
> -		clear_siginfo(&info);
> -		info.si_signo = SIGBUS;
> -		info.si_errno = 0;
> -		info.si_code = si_code;
> -		info.si_addr = (void __user *)address;
> -		force_sig_info(SIGBUS, &info, current);
> +		force_sig_fault(SIGBUS, si_code, (void __user *)address, current);
>  	} else {
>  		inc_unaligned_kernel_access();
>  
> @@ -599,20 +593,17 @@ int is_dsp_inst(struct pt_regs *regs)
>  #ifdef CONFIG_CPU_SH2A
>  asmlinkage void do_divide_error(unsigned long r4)
>  {
> -	siginfo_t info;
> +	int code;
>  
> -	clear_siginfo(&info);
>  	switch (r4) {
>  	case TRAP_DIVZERO_ERROR:
> -		info.si_code = FPE_INTDIV;
> +		code = FPE_INTDIV;
>  		break;
>  	case TRAP_DIVOVF_ERROR:
> -		info.si_code = FPE_INTOVF;
> +		code = FPE_INTOVF;
>  		break;
>  	}
> -
> -	info.si_signo = SIGFPE;
> -	force_sig_info(info.si_signo, &info, current);
> +	force_sig_fault(SIGFPE, code, NULL, current);
>  }
>  #endif
>  
> diff --git a/arch/sh/math-emu/math.c b/arch/sh/math-emu/math.c
> index d6d2213df078..a0fa8fc88739 100644
> --- a/arch/sh/math-emu/math.c
> +++ b/arch/sh/math-emu/math.c
> @@ -507,7 +507,6 @@ static int ieee_fpe_handler(struct pt_regs *regs)
>  	unsigned short insn = *(unsigned short *)regs->pc;
>  	unsigned short finsn;
>  	unsigned long nextpc;
> -	siginfo_t info;
>  	int nib[4] = {
>  		(insn >> 12) & 0xf,
>  		(insn >> 8) & 0xf,
> @@ -560,12 +559,8 @@ static int ieee_fpe_handler(struct pt_regs *regs)
>  				~(FPSCR_CAUSE_MASK | FPSCR_FLAG_MASK);
>  			task_thread_info(tsk)->status |= TS_USEDFPU;
>  		} else {
> -			clear_siginfo(&info);
> -			info.si_signo = SIGFPE;
> -			info.si_errno = 0;
> -			info.si_code = FPE_FLTINV;
> -			info.si_addr = (void __user *)regs->pc;
> -			force_sig_info(SIGFPE, &info, tsk);
> +			force_sig_fault(SIGFPE, FPE_FLTINV,
> +					(void __user *)regs->pc, tsk);
>  		}
>  
>  		regs->pc = nextpc;
> diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
> index 4c98b6f20e02..b8e7bb84b6b1 100644
> --- a/arch/sh/mm/fault.c
> +++ b/arch/sh/mm/fault.c
> @@ -42,15 +42,7 @@ static void
>  force_sig_info_fault(int si_signo, int si_code, unsigned long address,
>  		     struct task_struct *tsk)
>  {
> -	siginfo_t info;
> -
> -	clear_siginfo(&info);
> -	info.si_signo	= si_signo;
> -	info.si_errno	= 0;
> -	info.si_code	= si_code;
> -	info.si_addr	= (void __user *)address;
> -
> -	force_sig_info(si_signo, &info, tsk);
> +	force_sig_fault(si_signo, si_code, (void __user *)address, tsk);
>  }
>  
>  /*
> -- 
> 2.14.1

Acked-by: Rich Felker <dalias@libc.org>
