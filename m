From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFA][PATCH 21/27] MIPS: ftrace: Remove check of obsolete
 variable function_trace_stop
Date: Tue, 15 Jul 2014 17:58:44 -0400
Message-ID: <20140715175844.5304e2a3@gandalf.local.home>
References: <20140626165221.736847419@goodmis.org>
	<20140626165852.665644919@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:54076 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934002AbaGOV6r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jul 2014 17:58:47 -0400
In-Reply-To: <20140626165852.665644919@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>, ralf@linux-mips.org

Ralf,

Can you please test and ack this and patch 7. It would make it better
than just pushing it through.

Thanks!

-- Steve


On Thu, 26 Jun 2014 12:52:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> 
> Nothing sets function_trace_stop to disable function tracing anymore.
> Remove the check for it in the arch code.
> 
> [ Please test this on your arch ]
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  arch/mips/Kconfig         | 1 -
>  arch/mips/kernel/mcount.S | 7 -------
>  2 files changed, 8 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 7a469acee33c..9ca52987fcd5 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -15,7 +15,6 @@ config MIPS
>  	select HAVE_BPF_JIT if !CPU_MICROMIPS
>  	select ARCH_HAVE_CUSTOM_GPIO_H
>  	select HAVE_FUNCTION_TRACER
> -	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_C_RECORDMCOUNT
> diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
> index 539b6294b613..00940d1d5c4f 100644
> --- a/arch/mips/kernel/mcount.S
> +++ b/arch/mips/kernel/mcount.S
> @@ -74,10 +74,6 @@ _mcount:
>  #endif
>  
>  	/* When tracing is activated, it calls ftrace_caller+8 (aka here) */
> -	lw	t1, function_trace_stop
> -	bnez	t1, ftrace_stub
> -	 nop
> -
>  	MCOUNT_SAVE_REGS
>  #ifdef KBUILD_MCOUNT_RA_ADDRESS
>  	PTR_S	MCOUNT_RA_ADDRESS_REG, PT_R12(sp)
> @@ -105,9 +101,6 @@ ftrace_stub:
>  #else	/* ! CONFIG_DYNAMIC_FTRACE */
>  
>  NESTED(_mcount, PT_SIZE, ra)
> -	lw	t1, function_trace_stop
> -	bnez	t1, ftrace_stub
> -	 nop
>  	PTR_LA	t1, ftrace_stub
>  	PTR_L	t2, ftrace_trace_function /* Prepare t2 for (1) */
>  	bne	t1, t2, static_trace
