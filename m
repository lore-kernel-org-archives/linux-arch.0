From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 03/22] x86: Replace ist_enter() with nmi_enter()
Date: Thu, 20 Feb 2020 11:54:39 +0100
Message-ID: <20200220105439.GA507@zn.tnic>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.547288232@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:34572 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTKyt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Feb 2020 05:54:49 -0500
Content-Disposition: inline
In-Reply-To: <20200219150744.547288232@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, Feb 19, 2020 at 03:47:27PM +0100, Peter Zijlstra wrote:
> @@ -1220,7 +1220,7 @@ static void mce_kill_me_maybe(struct cal
>   * MCE broadcast. However some CPUs might be broken beyond repair,
>   * so be always careful when synchronizing with others.
>   */
> -void do_machine_check(struct pt_regs *regs, long error_code)
> +notrace void do_machine_check(struct pt_regs *regs, long error_code)

Is there a convention where the notrace marker should come in the
function signature? I see all possible combinations while grepping...

>  {
>  	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
>  	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
> @@ -1254,10 +1254,10 @@ void do_machine_check(struct pt_regs *re
>  	 */
>  	int lmce = 1;
>  
> -	if (__mc_check_crashing_cpu(cpu))
> -		return;
> +	nmi_enter();
>  
> -	ist_enter(regs);
> +	if (__mc_check_crashing_cpu(cpu))
> +		goto out;
>  
>  	this_cpu_inc(mce_exception_count);
>  

Should that __mc_check_crashing_cpu() happen before nmi_enter? The
function is doing only a bunch of checks and clearing MSRs for bystander
CPUs...

> @@ -1346,7 +1346,7 @@ void do_machine_check(struct pt_regs *re
>  	sync_core();
>  
>  	if (worst != MCE_AR_SEVERITY && !kill_it)
> -		goto out_ist;
> +		goto out;
>  
>  	/* Fault was in user mode and we need to take some action */
>  	if ((m.cs & 3) == 3) {
> @@ -1362,10 +1362,11 @@ void do_machine_check(struct pt_regs *re
>  			mce_panic("Failed kernel mode recovery", &m, msg);
>  	}
>  
> -out_ist:
> -	ist_exit(regs);
> +out:
> +	nmi_exit();
>  }
>  EXPORT_SYMBOL_GPL(do_machine_check);
> +NOKPROBE_SYMBOL(do_machine_check);

Yah, that's a good idea regardless.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
