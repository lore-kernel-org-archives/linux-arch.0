From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 03/27] x86/entry: Flip _TIF_SIGPENDING and
 _TIF_NOTIFY_RESUME handling
Date: Fri, 21 Feb 2020 17:14:45 +0100
Message-ID: <20200221161445.GQ14879@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.206604505@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:37366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgBUQPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 11:15:12 -0500
Content-Disposition: inline
In-Reply-To: <20200221134215.206604505@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Fri, Feb 21, 2020 at 02:34:19PM +0100, Peter Zijlstra wrote:
> Make sure we run task_work before we hit any kind of userspace -- very
> much including signals.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/common.c                   |    8 
>  usr/src/linux-2.6/arch/x86/entry/common.c |  440 ------------------------------
>  2 files changed, 4 insertions(+), 444 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -155,16 +155,16 @@ static void exit_to_usermode_loop(struct
>  		if (cached_flags & _TIF_PATCH_PENDING)
>  			klp_update_patch_state(current);
>  
> -		/* deal with pending signal delivery */
> -		if (cached_flags & _TIF_SIGPENDING)
> -			do_signal(regs);
> -
>  		if (cached_flags & _TIF_NOTIFY_RESUME) {
>  			clear_thread_flag(TIF_NOTIFY_RESUME);
>  			tracehook_notify_resume(regs);
>  			rseq_handle_notify_resume(NULL, regs);
>  		}
>  
> +		/* deal with pending signal delivery */
> +		if (cached_flags & _TIF_SIGPENDING)
> +			do_signal(regs);
> +

For giggles, I just found:

	do_signal()
	  get_signal()
	    task_work_run()
