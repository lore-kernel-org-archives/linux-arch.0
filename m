From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 13/22] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Date: Wed, 19 Feb 2020 10:53:35 -0500
Message-ID: <20200219105335.0396fb55@gandalf.local.home>
References: <20200219144724.800607165@infradead.org>
        <20200219150745.125119627@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgBSPxj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 10:53:39 -0500
In-Reply-To: <20200219150745.125119627@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, 19 Feb 2020 15:47:37 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> taught perf how to deal with not having an RCU context provided.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
