From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [REVIEW][PATCH 14/22] signal/riscv: Use force_sig_fault where
 appropriate
Date: Sat, 21 Apr 2018 00:25:50 -0700
Message-ID: <20180421072550.GA6973@infradead.org>
References: <87604mhrnb.fsf@xmission.com>
 <20180420143811.9994-14-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180420143811.9994-14-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, Albert Ou <albert@sifive.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 20, 2018 at 09:38:03AM -0500, Eric W. Biederman wrote:
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
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <albert@sifive.com>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/riscv/kernel/traps.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 48aa6471cede..3087940008f4 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -66,14 +66,7 @@ void die(struct pt_regs *regs, const char *str)
>  static inline void do_trap_siginfo(int signo, int code,
>  	unsigned long addr, struct task_struct *tsk)
>  {
> -	siginfo_t info;
> -
> -	clear_siginfo(&info);
> -	info.si_signo = signo;
> -	info.si_errno = 0;
> -	info.si_code = code;
> -	info.si_addr = (void __user *)addr;
> -	force_sig_info(signo, &info, tsk);
> +	force_sig_fault(signo, code, (void __user *)addr, tsk);
>  }

Please kill the do_trap_siginfo helper and use force_sig_fault
directly in both callers.
