From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Wed, 19 Feb 2020 04:46:14 -0800
Message-ID: <20200219124614.GT2935@paulmck-ThinkPad-P72>
References: <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
 <20200213164031.GH14914@hirez.programming.kicks-ass.net>
 <20200213185612.GG2935@paulmck-ThinkPad-P72>
 <20200213204444.GA94647@google.com>
 <20200218195831.GD11457@worktop.programming.kicks-ass.net>
 <20200218201728.GH2935@paulmck-ThinkPad-P72>
 <20200218204021.GJ11457@worktop.programming.kicks-ass.net>
 <20200218213925.GL2935@paulmck-ThinkPad-P72>
 <20200219095743.GA18400@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgBSMqO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 07:46:14 -0500
Content-Disposition: inline
In-Reply-To: <20200219095743.GA18400@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Wed, Feb 19, 2020 at 10:57:43AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 18, 2020 at 01:39:25PM -0800, Paul E. McKenney wrote:
> > OK.  I will drop it later today, but leave tag in_nmi.2020.02.18a
> > pointing at it for future reference.
> 
> Thanks, I've picked it up in my series.

Very good, thank you!

							Thanx, Paul
