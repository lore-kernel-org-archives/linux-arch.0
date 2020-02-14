Return-Path: <SRS0=li4v=4C=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgBNDc5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 22:32:57 -0500
Date: Thu, 13 Feb 2020 22:32:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 9/9] perf,tracing: Allow function tracing when !RCU
Message-ID: <20200213223254.668a340d@oasis.local.home>
In-Reply-To: <20200214024244.GH36551@google.com>
References: <20200212210139.382424693@infradead.org>
        <20200212210750.312024711@infradead.org>
        <20200214022839.GG36551@google.com>
        <20200214024244.GH36551@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Message-ID: <20200214033254.ps-O_E0qKWI-4b4H7a429pJ7AD0qRtJyDMUzuhq-tWg@z>

On Fri, 14 Feb 2020 11:42:45 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> > > +++ b/kernel/trace/trace_event_perf.c
> > > @@ -477,7 +477,7 @@ static int perf_ftrace_function_register
> > >  {
> > >  	struct ftrace_ops *ops = &event->ftrace_ops;
> > >  
> > > -	ops->flags   = FTRACE_OPS_FL_RCU;
> > > +	ops->flags   = 0;  
> > 
> > FTRACE_OPS_FL_ENABLED?  
> 
> No, never mind.

:-)

-- Steve
