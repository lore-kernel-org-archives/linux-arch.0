Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:62523 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759363AbaGCQej (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jul 2014 12:34:39 -0400
Date: Thu, 3 Jul 2014 12:34:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFA][PATCH 06/27] microblaze: ftrace: Add call to
 ftrace_graph_is_dead() in function graph code
Message-ID: <20140703123436.2054cffb@gandalf.local.home>
In-Reply-To: <20140626165849.119568888@goodmis.org>
References: <20140626165221.736847419@goodmis.org>
	<20140626165849.119568888@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>, Michal Simek <monstr@monstr.eu>
Message-ID: <20140703163436.P_WLc2yVc3I311cliaCh3SY-vPTIQvEiE1YuAM0f4Ko@z>

Michal,

Can you give me your Acked-by on this and patch 22? I'm still waiting
of a few arch maintainers before I can push these up to my for-next
branch.

-- Steve


On Thu, 26 Jun 2014 12:52:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> 
> ftrace_stop() is going away as it disables parts of function tracing
> that affects users that should not be affected. But ftrace_graph_stop()
> is built on ftrace_stop(). Here's another example of killing all of
> function tracing because something went wrong with function graph
> tracing.
> 
> Instead of disabling all users of function tracing on function graph
> error, disable only function graph tracing. To do this, the arch code
> must call ftrace_graph_is_dead() before it implements function graph.
> 
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  arch/microblaze/kernel/ftrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/microblaze/kernel/ftrace.c b/arch/microblaze/kernel/ftrace.c
> index bbcd2533766c..fc7b48a52cd5 100644
> --- a/arch/microblaze/kernel/ftrace.c
> +++ b/arch/microblaze/kernel/ftrace.c
> @@ -27,6 +27,9 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
>  	unsigned long return_hooker = (unsigned long)
>  				&return_to_handler;
>  
> +	if (unlikely(ftrace_graph_is_dead()))
> +		return;
> +
>  	if (unlikely(atomic_read(&current->tracing_graph_pause)))
>  		return;
>  

