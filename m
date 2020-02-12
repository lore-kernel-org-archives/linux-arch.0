From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] tracing vs rcu vs nmi
Date: Wed, 12 Feb 2020 11:01:06 +0100
Message-ID: <20200212100106.GA14914@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33092 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgBLKB3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 05:01:29 -0500
Content-Disposition: inline
In-Reply-To: <20200212093210.468391728@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, james.morse@arm.com, will@kernel.org, catalin.marinas@arm.com
Cc: mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Wed, Feb 12, 2020 at 10:32:10AM +0100, Peter Zijlstra wrote:
> Hi all,
> 
> These here patches are the result of Mathieu and Steve trying to get commit
> 865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
> tracepoints") reverted again.
> 
> One of the things discovered is that tracing MUST NOT happen before nmi_enter()
> or after nmi_exit(). I've only fixed x86, but quickly gone through other
> architectures and there is definitely more stuff to be fixed (simply grep for
> nmi_enter in your arch).

For ARM64:

 - apei_claim_sea()
 - __sdei_handler()
 - do_serror()
 - debug_exception_enter() / do_debug_exception()

all look dodgy.
