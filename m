From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 07/22] rcu: Mark rcu_dynticks_curr_cpu_in_eqs()
 inline
Date: Wed, 19 Feb 2020 12:19:50 -0500
Message-ID: <20200219121950.678dfd08@gandalf.local.home>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.775936989@infradead.org>
        <20200219163934.GA2935@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgBSRTx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:53 -0500
In-Reply-To: <20200219163934.GA2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, 19 Feb 2020 08:39:34 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> There was some controversy over inline vs. notrace, leading me to
> ask whether we should use both inline and notrace here.  ;-)

"inline" implicitly suggests "notrace". The reason being is that there
were "surprises" when gcc decided not to inline various functions
marked as "inline" which caused ftrace to break. I figured, if someone
marks something as "inline" that it should not be traced regardless if
gcc decided to inline it or not.

-- Steve
