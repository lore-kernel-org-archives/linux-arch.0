From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Date: Wed, 19 Feb 2020 18:46:23 +0100
Message-ID: <20200219174623.GQ18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.488895196@infradead.org>
 <20200219171309.GC32346@zn.tnic>
 <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
 <20200219174223.GE30966@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSRqx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:46:53 -0500
Content-Disposition: inline
In-Reply-To: <20200219174223.GE30966@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Wed, Feb 19, 2020 at 06:42:23PM +0100, Borislav Petkov wrote:
> On Wed, Feb 19, 2020 at 09:21:48AM -0800, Andy Lutomirski wrote:
> > Unless there is a signal pending and the signal setup code is about to
> > hit the same failed memory.  I suppose we can just treat cases like
> > this as "oh well, time to kill the whole system".
> >
> > But we should genuinely agree that we're okay with deferring this handling.
> 
> Good catch!
> 
> static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
> {
> 
> 	...
> 
> 		/* deal with pending signal delivery */
>                 if (cached_flags & _TIF_SIGPENDING)
>                         do_signal(regs);
> 
>                 if (cached_flags & _TIF_NOTIFY_RESUME) {
>                         clear_thread_flag(TIF_NOTIFY_RESUME);
>                         tracehook_notify_resume(regs);
>                         rseq_handle_notify_resume(NULL, regs);
>                 }
> 
> 
> Err, can we make task_work run before we handle signals? Or there's a
> reason it is run in this order?
> 
> Comment over task_work_add() says:
> 
>  * This is like the signal handler which runs in kernel mode, but it doesn't
>  * try to wake up the @task.
> 
> which sounds to me like this should really run before the signal
> handlers...

here goes...

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -155,16 +155,16 @@ static void exit_to_usermode_loop(struct
 		if (cached_flags & _TIF_PATCH_PENDING)
 			klp_update_patch_state(current);
 
-		/* deal with pending signal delivery */
-		if (cached_flags & _TIF_SIGPENDING)
-			do_signal(regs);
-
 		if (cached_flags & _TIF_NOTIFY_RESUME) {
 			clear_thread_flag(TIF_NOTIFY_RESUME);
 			tracehook_notify_resume(regs);
 			rseq_handle_notify_resume(NULL, regs);
 		}
 
+		/* deal with pending signal delivery */
+		if (cached_flags & _TIF_SIGPENDING)
+			do_signal(regs);
+
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
 			fire_user_return_notifiers();
 
