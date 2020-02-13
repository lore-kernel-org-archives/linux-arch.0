From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Thu, 13 Feb 2020 13:39:14 -0500
Message-ID: <20200213183914.GB207225@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232702.GA170680@google.com>
 <20200213082814.GJ14897@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42063 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgBMSjP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 13:39:15 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so3078807qvb.9
        for <linux-arch@vger.kernel.org>; Thu, 13 Feb 2020 10:39:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200213082814.GJ14897@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Thu, Feb 13, 2020 at 09:28:14AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 06:27:02PM -0500, Joel Fernandes wrote:
> > On Wed, Feb 12, 2020 at 10:01:42PM +0100, Peter Zijlstra wrote:
> 
> > > +#define trace_rcu_enter()					\
> > > +({								\
> > > +	unsigned long state = 0;				\
> > > +	if (!rcu_is_watching())	{				\
> > > +		if (in_nmi()) {					\
> > > +			state = __TR_NMI;			\
> > > +			rcu_nmi_enter();			\
> > > +		} else {					\
> > > +			state = __TR_IRQ;			\
> > > +			rcu_irq_enter_irqsave();		\
> > 
> > Since rcu_irq_enter_irqsave can be called from a tracer context, should those
> > be marked with notrace as well? AFAICS, there's no notrace marking on them.
> 
> It should work, these functions are re-entrant (as are IRQs / NMIs) and
> Steve wants to be able to trace RCU itself.

Hoping there are no recursion scenarios possible, but that sounds good to me. thanks,

 - Joel
