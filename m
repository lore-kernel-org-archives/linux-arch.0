From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 12/22] tracing: Employ trace_rcu_{enter,exit}()
Date: Wed, 19 Feb 2020 10:52:45 -0500
Message-ID: <20200219105245.05072de5@gandalf.local.home>
References: <20200219144724.800607165@infradead.org>
        <20200219150745.060958307@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgBSPws (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 10:52:48 -0500
In-Reply-To: <20200219150745.060958307@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, 19 Feb 2020 15:47:36 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Replace the opencoded (and incomplete) RCU manipulations with the new
> helpers to ensure a regular RCU context when calling into
> __ftrace_trace_stack().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---


Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
