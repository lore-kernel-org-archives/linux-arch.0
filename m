From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/8] tracing vs rcu vs nmi
Date: Wed, 12 Feb 2020 09:32:34 -0500
Message-ID: <20200212093235.2be06208@gandalf.local.home>
References: <20200212093210.468391728@infradead.org>
        <20200212100106.GA14914@hirez.programming.kicks-ass.net>
        <20200212105646.GA4017@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbgBLOci (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 09:32:38 -0500
In-Reply-To: <20200212105646.GA4017@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, james.morse@arm.com, catalin.marinas@arm.com, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Wed, 12 Feb 2020 10:56:46 +0000
Will Deacon <will@kernel.org> wrote:

> Hmm, so looks like we need to spinkle some 'notrace' annotations around
> these. Are there are scenarios where you would want NOKPROBE_SYMBOL() but
> *not* 'notrace'? We've already got the former for the debug exception
> handlers and we probably (?) want it for the SDEI stuff too...

Note, function tracing has a lot of recursion detection, and when
something registers with the function tracer it needs to state if it
can be called when rcu is not watching, or it wont be called then.

And yes, there's plenty of places that we have "nokprobe" but allow
tracing.

I've been trying to get rid of notrace around the kernel, not add more.

-- Steve
