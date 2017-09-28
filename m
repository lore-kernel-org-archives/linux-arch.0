From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 for 4.14 1/3] membarrier: Provide register expedited
 private command
Date: Fri, 29 Sep 2017 02:16:22 +1000
Message-ID: <20170929021622.5c7d6206@roar.ozlabs.ibm.com>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
        <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
        <20170927230436.4af88a62@roar.ozlabs.ibm.com>
        <911707916.20840.1506605496314.JavaMail.zimbra@efficios.com>
        <20170929010112.3a54be0d@roar.ozlabs.ibm.com>
        <634837506.21241.1506612590749.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:51903 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbdI1QQn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2017 12:16:43 -0400
In-Reply-To: <634837506.21241.1506612590749.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Avi Kivity <avi@scylladb.com>, maged michael <maged.michael@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Dave Watson <davejwatson@fb.com>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Hunter <ahh@google.com>, Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, gromer <gromer@google.com>

On Thu, 28 Sep 2017 15:29:50 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Sep 28, 2017, at 11:01 AM, Nicholas Piggin npiggin@gmail.com wrote:
> 
> > On Thu, 28 Sep 2017 13:31:36 +0000 (UTC)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> >> ----- On Sep 27, 2017, at 9:04 AM, Nicholas Piggin npiggin@gmail.com wrote:
> >>   

[snip]

> >> So I don't see much point in trying to remove that registration step.  
> > 
> > I don't follow you. You are talking about the concept of registering
> > intention to use a different function? And the registration API is not
> > merged yet?  
> 
> Yes, I'm talking about requiring processes to invoke membarrier cmd
> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED before they can successfully
> invoke membarrier cmd MEMBARRIER_CMD_PRIVATE_EXPEDITED.
> 
> > Let me say I'm not completely against the idea of a registration API. But
> > don't think registration for this expedited command is necessary.  
> 
> Given that we have the powerpc lack-of-full-barrier-on-return-to-userspace
> case now, and we foresee x86-sysexit, sparc, and alpha also requiring
> special treatment when we introduce the MEMBARRIER_FLAG_SYNC_CORE behavior
> in the next release, it seems that we'll have a hard time handling
> architecture special cases efficiently if we don't expose the registration
> API right away.

But SYNC_CORE is a different functionality, right? You can add the
registration API for it when that goes in.

> > But (aside) let's say a tif flag turns out to be a good diea for your
> > second case, why not just check the flag in the membarrier sys call and
> > do the registration the first time it uses it?  
> 
> We also considered that option. It's mainly about guaranteeing that
> an expedited membarrier command never blocks. If we introduce this
> "lazy auto-registration" behavior, we end up blocking the process
> at a random point in its execution so we can issue a synchronize_sched().
> By exposing an explicit registration, we can control where this delay
> occurs, and even allow library constructors to invoke the registration
> while the process is a single threaded, therefore allowing us to completely
> skip synchronize_sched().

Okay I guess that could be a good reason. As I said I'm not opposed to
the concept. I suppose you could even have a registration for expedited
private even if it's a no-op on all architectures, just in case some new
ways of implementing it can be done in future.

I suppose I'm more objecting to the added complexity for powerpc, and
more code in the fastpath to make the slowpath faster.

Thanks,
Nick
