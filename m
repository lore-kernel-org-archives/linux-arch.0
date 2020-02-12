From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] tracing vs rcu vs nmi
Date: Wed, 12 Feb 2020 16:21:00 +0100
Message-ID: <20200212152100.GV14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212100106.GA14914@hirez.programming.kicks-ass.net>
 <20200212105646.GA4017@willie-the-truck>
 <20200212093235.2be06208@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBLPV3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 10:21:29 -0500
Content-Disposition: inline
In-Reply-To: <20200212093235.2be06208@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, james.morse@arm.com, catalin.marinas@arm.com, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Wed, Feb 12, 2020 at 09:32:34AM -0500, Steven Rostedt wrote:
> I've been trying to get rid of notrace around the kernel, not add more.

As is abundantly clear, I hope, we really need more this time.

You want to trace RCU itself, the concequence is we _MUST_NOT_ trace the
early NMI code until we can distinguish we're *in* NMI code.

There really is no 2 way about it; and I'm not going to wait until some
poor sucker trips over it.
