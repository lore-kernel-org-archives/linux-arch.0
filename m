From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 3/6] arm64: Use update{,_tsk}_thread_flag()
Date: Wed, 23 May 2018 13:02:39 +0100
Message-ID: <20180523120239.GE26965@arm.com>
References: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
 <1524135528-28561-4-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524135528-28561-4-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 19, 2018 at 11:58:45AM +0100, Dave Martin wrote:
> This patch uses the new update_thread_flag() helpers to simplify a
> couple of if () set; else clear; constructs.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 87a3536..0c4e7e0 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -618,10 +618,8 @@ int sve_set_vector_length(struct task_struct *task,
>  	task->thread.sve_vl = vl;
>  
>  out:
> -	if (flags & PR_SVE_VL_INHERIT)
> -		set_tsk_thread_flag(task, TIF_SVE_VL_INHERIT);
> -	else
> -		clear_tsk_thread_flag(task, TIF_SVE_VL_INHERIT);
> +	update_tsk_thread_flag(task, TIF_SVE_VL_INHERIT,
> +			       flags & PR_SVE_VL_INHERIT);
>  
>  	return 0;
>  }
> @@ -902,7 +900,7 @@ void fpsimd_thread_switch(struct task_struct *next)
>  	if (current->mm)
>  		task_fpsimd_save();
>  
> -	if (next->mm) {
> +	if (next->mm)
>  		/*
>  		 * If we are switching to a task whose most recent userland
>  		 * FPSIMD state is already in the registers of *this* cpu,
> @@ -910,13 +908,10 @@ void fpsimd_thread_switch(struct task_struct *next)
>  		 * the TIF_FOREIGN_FPSTATE flag so the state will be loaded
>  		 * upon the next return to userland.
>  		 */
> -		if (__this_cpu_read(fpsimd_last_state.st) ==
> -			&next->thread.uw.fpsimd_state
> -		    && next->thread.fpsimd_cpu == smp_processor_id())
> -			clear_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
> -		else
> -			set_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
> -	}
> +		update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
> +			__this_cpu_read(fpsimd_last_state.st) !=
> +				&next->thread.uw.fpsimd_state ||
> +			next->thread.fpsimd_cpu != smp_processor_id());

This will conflict with some patches in-flight from a chap called Dave
Martin ;)

Other than that:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
