From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Tue, 18 Feb 2020 13:33:35 +0900
Message-ID: <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org>
References: <20200213204444.GA94647@google.com>
        <20200213205442.GK2935@paulmck-ThinkPad-P72>
        <20200213211930.GG170680@google.com>
        <20200213163800.5c51a5f1@gandalf.local.home>
        <20200213215004.GM2935@paulmck-ThinkPad-P72>
        <20200213170451.690c4e5c@gandalf.local.home>
        <20200213223918.GN2935@paulmck-ThinkPad-P72>
        <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org>
        <20200215145934.GD2935@paulmck-ThinkPad-P72>
        <20200217175519.12a694a969c1a8fb2e49905e@kernel.org>
        <20200217163112.GM2935@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgBREdl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Feb 2020 23:33:41 -0500
In-Reply-To: <20200217163112.GM2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Joel Fernandes <joel@joelfernandes.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Mon, 17 Feb 2020 08:31:12 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > BTW, if you consider the x86 specific code is in the generic file,
> > we can move NOKPROBE_SYMBOL() in arch/x86/kernel/traps.c.
> > (Sorry, I've hit this idea right now)
> 
> Might this affect other architectures with NMIs and probe-like things?
> If so, it might make sense to leave it where it is.

Yes, git grep shows that arm64 is using rcu_nmi_enter() in
debug_exception_enter().
OK, let's keep it, but maybe it is good to update the comment for
arm64 too. What about following?

+/*
+ * All functions in do_int3() on x86, do_debug_exception() on arm64 must be
+ * marked NOKPROBE before kprobes handler is called.
+ * ist_enter() on x86 and debug_exception_enter() on arm64 which is called
+ * before kprobes handle happens to call rcu_nmi_enter() which means
+ * that rcu_nmi_enter() must be marked NOKRPOBE.
+ */

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
