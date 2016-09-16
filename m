From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH][RFC] Implement arch primitives for busywait loops
Date: Fri, 16 Sep 2016 22:59:42 +1000
Message-ID: <20160916225942.449e6e04@roar.ozlabs.ibm.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
        <063D6719AE5E284EB5DD2968C1650D6DB00FF7D8@AcuExch.aculab.com>
        <20160916215200.2775f252@roar.ozlabs.ibm.com>
        <063D6719AE5E284EB5DD2968C1650D6DB00FF831@AcuExch.aculab.com>
        <20160916220635.7e6fdbb7@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34045 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755319AbcIPM7v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2016 08:59:51 -0400
Received: by mail-pf0-f175.google.com with SMTP id p64so27362495pfb.1
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2016 05:59:50 -0700 (PDT)
In-Reply-To: <20160916220635.7e6fdbb7@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

On Fri, 16 Sep 2016 22:06:35 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Fri, 16 Sep 2016 11:57:37 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > From: Nicholas Piggin  
> > > Sent: 16 September 2016 12:52
> > > On Fri, 16 Sep 2016 11:30:58 +0000
> > > David Laight <David.Laight@ACULAB.COM> wrote:
> > >     
> > > > From: Nicholas Piggin    
> > > > > Sent: 16 September 2016 09:58
> > > > > Implementing busy wait loops with cpu_relax() in callers poses
> > > > > some difficulties for powerpc.
> > > > >
> > > > > First, we want to put our SMT thread into a low priority mode for the
> > > > > duration of the loop, but then return to normal priority after exiting
> > > > > the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
> > > > > cpu_relax() does may have HMT_medium take effect before HMT_low made
> > > > > any (or much) difference.
> > > > >
> > > > > Second, it can be beneficial for some implementations to spin on the
> > > > > exit condition with a statically predicted-not-taken branch (i.e.,
> > > > > always predict the loop will exit).
> > > > >
> > > > > This is a quick RFC with a couple of users converted to see what
> > > > > people think. I don't use a C branch with hints, because we don't want
> > > > > the compiler moving the loop body out of line, which makes it a bit
> > > > > messy unfortunately. If there's a better way to do it, I'm all ears.    
> > > >
> > > > I think it will still all go wrong if the conditional isn't trivial.
> > > > In particular if the condition contains || or && it is likely to
> > > > have a branch - which could invert the loop.    
> > > 
> > > I don't know that it will.
> > > 
> > > Yes, if we have exit condition that requires more branches in order to
> > > be computed then we lose our nice property of never taking a branch
> > > miss on loop exit. But we still avoid *this* branch miss, and still
> > > prevent multiple iterations of the wait loop being speculatively
> > > executed concurrently when there's no work to be done.
> > > 
> > > And C doesn't know about the loop, so it can't do any transformation
> > > except to compute the final condition.
> > > 
> > > Or have I missed something?    
> > 
> > Try putting the code inside a conditional or at the bottom of a loop.
> > gcc can replicate code to remove a branch.
> > 
> > So:
> > 	for (;;) {
> > 		a;
> > 		if (b)
> > 			c;
> > 		d;
> > 	}  
> 
> That's not what this patch does though. The loop is purely asm. gcc has
> no idea about it. Only thing gcc knows is to evaluate the condition and
> put it in a register.


Oh you're right course -- can't branch to random location. Sorry, I didn't
know what you meant at first. It does need to use asm goto I guess.

Thanks,
Nick
