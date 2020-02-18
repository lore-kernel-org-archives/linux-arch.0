From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Tue, 18 Feb 2020 11:35:03 -0500
Message-ID: <20200218113503.1170c188@gandalf.local.home>
References: <20200213211930.GG170680@google.com>
        <20200213163800.5c51a5f1@gandalf.local.home>
        <20200213215004.GM2935@paulmck-ThinkPad-P72>
        <20200213170451.690c4e5c@gandalf.local.home>
        <20200213223918.GN2935@paulmck-ThinkPad-P72>
        <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org>
        <20200215145934.GD2935@paulmck-ThinkPad-P72>
        <20200217175519.12a694a969c1a8fb2e49905e@kernel.org>
        <20200217163112.GM2935@paulmck-ThinkPad-P72>
        <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org>
        <20200218161231.GD2935@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgBRQfG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Feb 2020 11:35:06 -0500
In-Reply-To: <20200218161231.GD2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Tue, 18 Feb 2020 08:12:31 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Would it work to describe the general problem, then give x86 details
> as a specific example, as follows?
> 
> /*
>  * On some architectures, certain exceptions prohibit use of kprobes until
>  * the exception code path reaches a certain point.  For example, on x86 all
>  * functions called by do_int3() must be marked NOKPROBE.  However, once
>  * kprobe_int3_handler() is called, kprobing is permitted.  Specifically,
>  * ist_enter() is called in do_int3() before kprobe_int3_handle().
>  * Furthermore, ist_enter() calls rcu_nmi_enter(), which means that
>  * rcu_nmi_enter() must be marked NOKRPOBE.
>  */
> 
> That way, I don't feel like I need to update the commment each time
> a new architecture adds this capability.  ;-)

I don't think this is going to be an issue for other archs, as they
don't have an IST.

-- Steve
