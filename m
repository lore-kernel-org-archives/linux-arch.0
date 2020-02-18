From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Tue, 18 Feb 2020 11:15:30 -0500 (EST)
Message-ID: <1841874582.7975.1582042530726.JavaMail.zimbra@efficios.com>
References: <20200213211930.GG170680@google.com> <20200213223918.GN2935@paulmck-ThinkPad-P72> <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org> <20200215145934.GD2935@paulmck-ThinkPad-P72> <20200217175519.12a694a969c1a8fb2e49905e@kernel.org> <20200217163112.GM2935@paulmck-ThinkPad-P72> <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org> <20200218161231.GD2935@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.26.124]:42580 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRQPc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 11:15:32 -0500
In-Reply-To: <20200218161231.GD2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck <paulmck@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt <rostedt@goodmis.org>, "Joel Fernandes, Google" <joel@joelfernandes.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Thomas Gleixner <tglx@linutronix.de>, Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>

----- On Feb 18, 2020, at 11:12 AM, paulmck paulmck@kernel.org wrote:

> On Tue, Feb 18, 2020 at 01:33:35PM +0900, Masami Hiramatsu wrote:
>> On Mon, 17 Feb 2020 08:31:12 -0800
>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> > 
>> > > BTW, if you consider the x86 specific code is in the generic file,
>> > > we can move NOKPROBE_SYMBOL() in arch/x86/kernel/traps.c.
>> > > (Sorry, I've hit this idea right now)
>> > 
>> > Might this affect other architectures with NMIs and probe-like things?
>> > If so, it might make sense to leave it where it is.
>> 
>> Yes, git grep shows that arm64 is using rcu_nmi_enter() in
>> debug_exception_enter().
>> OK, let's keep it, but maybe it is good to update the comment for
>> arm64 too. What about following?
>> 
>> +/*
>> + * All functions in do_int3() on x86, do_debug_exception() on arm64 must be
>> + * marked NOKPROBE before kprobes handler is called.
>> + * ist_enter() on x86 and debug_exception_enter() on arm64 which is called
>> + * before kprobes handle happens to call rcu_nmi_enter() which means
>> + * that rcu_nmi_enter() must be marked NOKRPOBE.
>> + */
> 
> Would it work to describe the general problem, then give x86 details
> as a specific example, as follows?
> 
> /*
> * On some architectures, certain exceptions prohibit use of kprobes until
> * the exception code path reaches a certain point.  For example, on x86 all
> * functions called by do_int3() must be marked NOKPROBE.  However, once
> * kprobe_int3_handler() is called, kprobing is permitted.  Specifically,
> * ist_enter() is called in do_int3() before kprobe_int3_handle().
> * Furthermore, ist_enter() calls rcu_nmi_enter(), which means that
> * rcu_nmi_enter() must be marked NOKRPOBE.
> */
> 
> That way, I don't feel like I need to update the commment each time
> a new architecture adds this capability.  ;-)

I suspect this kind of comment would belong in a new
Documentation/features/kprobes/annotations.txt or something
similar. You might want to look at other "features" files to see
the expected layout.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
