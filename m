From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFA][PATCH 20/27] parisc: ftrace: Remove check of obsolete
 variable function_trace_stop
Date: Thu, 26 Jun 2014 13:35:48 -0400
Message-ID: <20140626133548.03f7b90a@gandalf.local.home>
References: <20140626165221.736847419@goodmis.org>
	<20140626165852.497955187@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:24658 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932288AbaFZRfu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2014 13:35:50 -0400
In-Reply-To: <20140626165852.497955187@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Helge Deller <deller@gmx.de>, Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, 26 Jun 2014 12:52:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> 
> Nothing sets function_trace_stop to disable function tracing anymore.
> Remove the check for it in the arch code.

From the cover letter, you were not Cc'd on.

Anyway, as there is no more reason to set function_trace_stop it is time
to remove it. Unfortunately it's in several archs in assembly. Most of
the assembly looks rather straight forward and I removed them myself.
But I was only able to compile test them (for archs: arm64, metag, and
microblaze I do not have my cross tools set up for them and did not
even compile test it). But I would really love it if people can
download their patch and test it out. You only need the patches that go
against your arch and to really test it, also include the patch titled: 

 ftrace: Remove check for HAVE_FUNCTION_TRACE_MCOUNT_TEST

Otherwise your arch patch will call the list op that still does the
check. That is, if you want to test suspend and resume on your arch.

As you may see, there are patches to the ftrace infrastructure that
depend on the arch patches being implemented. I removed the
functionality from the infrastructure, then removed it from the archs,
and then finally removed the existence of the function_trace_stop
variable, which would cause the archs to fail to compile if that were
to go first.

If you can test your arch and give me your acked-by, I would appreciate
it. Otherwise, if you need this to go through your tree, I would ask you
to set up a dedicated branch that I can pull from to keep this order
intact.

-- Steve

> 
> Cc: Helge Deller <deller@gmx.de>
> Cc: Kyle McMartin <kyle@mcmartin.ca>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  arch/parisc/Kconfig         | 1 -
>  arch/parisc/kernel/ftrace.c | 3 ---
>  2 files changed, 4 deletions(-)
> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 108d48e652af..6e75e2030927 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -6,7 +6,6 @@ config PARISC
>  	select HAVE_OPROFILE
>  	select HAVE_FUNCTION_TRACER if 64BIT
>  	select HAVE_FUNCTION_GRAPH_TRACER if 64BIT
> -	select HAVE_FUNCTION_TRACE_MCOUNT_TEST if 64BIT
>  	select ARCH_WANT_FRAME_POINTERS
>  	select RTC_CLASS
>  	select RTC_DRV_GENERIC
> diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
> index 5512ab32c5e0..559d400f9385 100644
> --- a/arch/parisc/kernel/ftrace.c
> +++ b/arch/parisc/kernel/ftrace.c
> @@ -155,9 +155,6 @@ void ftrace_function_trampoline(unsigned long parent,
>  {
>  	extern ftrace_func_t ftrace_trace_function;
>  
> -	if (function_trace_stop)
> -		return;
> -
>  	if (ftrace_trace_function != ftrace_stub) {
>  		ftrace_trace_function(parent, self_addr);
>  		return;
