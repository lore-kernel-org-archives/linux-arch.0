From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <- "IN-NMI"
 inversions
Date: Mon, 24 Feb 2020 21:12:20 -0500
Message-ID: <20200225021220.GD253171@google.com>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.090538203@infradead.org>
 <20200222030843.GA191380@google.com>
 <20200224101050.GE14897@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41586 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgBYCMW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 21:12:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id b5so3491520qkh.8
        for <linux-arch@vger.kernel.org>; Mon, 24 Feb 2020 18:12:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200224101050.GE14897@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Mon, Feb 24, 2020 at 11:10:50AM +0100, Peter Zijlstra wrote:
> On Fri, Feb 21, 2020 at 10:08:43PM -0500, Joel Fernandes wrote:
> > On Fri, Feb 21, 2020 at 02:34:17PM +0100, Peter Zijlstra wrote:
> > > nmi_enter() does lockdep_off() and hence lockdep ignores everything.
> > > 
> > > And NMI context makes it impossible to do full IN-NMI tracking like we
> > > do IN-HARDIRQ, that could result in graph_lock recursion.
> > 
> > The patch makes sense to me.
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > NOTE:
> > Also, I was wondering if we can detect the graph_lock recursion case and
> > avoid doing anything bad, that way we enable more of the lockdep
> > functionality for NMI where possible. Not sure if the suggestion makes sense
> > though!
> 
> Yeah, I considered playing trylock games, but figured I shouldn't make
> it more complicated that it needs to be.

Yes, I agree with you. Thanks.

 - Joel
