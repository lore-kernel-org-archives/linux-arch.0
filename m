Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:46160 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688AbcBPTgw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2016 14:36:52 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 16 Feb 2016 12:36:52 -0700
Date: Tue, 16 Feb 2016 11:36:44 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Writes, smp_wmb(), and transitivity?
Message-ID: <20160216193644.GV6719@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160215175825.GA15878@linux.vnet.ibm.com>
 <CA+55aFxaQEvDrzecmZUQ5QfKzU4ei6E-+NpsW5hYp3ouaLP98g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxaQEvDrzecmZUQ5QfKzU4ei6E-+NpsW5hYp3ouaLP98g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>, Andy.Glew@imgtec.com, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-metag@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>, linux-xtensa@linux-xtensa.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>, graham.whaley@gmail.com, Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Message-ID: <20160216193644.INunXSLdhVfm70IjB4VqgxAwQ9E3R-_zpUrVBAh2ISM@z>

On Tue, Feb 16, 2016 at 10:59:08AM -0800, Linus Torvalds wrote:
> On Mon, Feb 15, 2016 at 9:58 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > Two threads:
> >
> >         int a, b;
> >
> >         void thread0(void)
> >         {
> >                 WRITE_ONCE(a, 1);
> >                 smp_wmb();
> >                 WRITE_ONCE(b, 2);
> >         }
> >
> >         void thread1(void)
> >         {
> >                 WRITE_ONCE(b, 1);
> >                 smp_wmb();
> >                 WRITE_ONCE(a, 2);
> >         }
> >
> >         /* After all threads have completed and the dust has settled... */
> >
> >         BUG_ON(a == 1 && b == 1);
> 
> So the more I look at that kind of litmus test, the less I think that
> we should care, because I can't come up with a scenario in where that
> kind of test makes sense. without even a possibility of any causal
> relationship between the two, I can't say why we'd ever care about the
> ordering of the (independent) writes to the individual variables.
> 
> If somebody can make up a causal chain, things differ. But as long as
> all the CPU's are just doing locally ordered writes, I don't think we
> need to care about a global store ordering.

Works for me!  (Yes, I can artificially generate a use case for this
thing, but all the ones I have come up with have some better and more
sane way to get the job done.  So I completely agree with your not caring
about it.)

So for transitivity, we focus on causal chains, where one task writes
to some variable that the next task reads.

In addition, if all threads use full memory barriers throughout, as in
smp_mb(), then full ordering is of course provided regardless of the
pattern of reads and writes.

							Thanx, Paul

