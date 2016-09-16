Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.192]:51927 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934982AbcIPMUL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2016 08:20:11 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH][RFC] Implement arch primitives for busywait loops
Date: Fri, 16 Sep 2016 11:57:37 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB00FF831@AcuExch.aculab.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
        <063D6719AE5E284EB5DD2968C1650D6DB00FF7D8@AcuExch.aculab.com>
 <20160916215200.2775f252@roar.ozlabs.ibm.com>
In-Reply-To: <20160916215200.2775f252@roar.ozlabs.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Nicholas Piggin' <npiggin@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20160916115737.x_Oun4qtFpYjeB7DEkrn85w6kN6CgsOGKrKEaLoovSY@z>

From: Nicholas Piggin
> Sent: 16 September 2016 12:52
> On Fri, 16 Sep 2016 11:30:58 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > From: Nicholas Piggin
> > > Sent: 16 September 2016 09:58
> > > Implementing busy wait loops with cpu_relax() in callers poses
> > > some difficulties for powerpc.
> > >
> > > First, we want to put our SMT thread into a low priority mode for the
> > > duration of the loop, but then return to normal priority after exiting
> > > the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
> > > cpu_relax() does may have HMT_medium take effect before HMT_low made
> > > any (or much) difference.
> > >
> > > Second, it can be beneficial for some implementations to spin on the
> > > exit condition with a statically predicted-not-taken branch (i.e.,
> > > always predict the loop will exit).
> > >
> > > This is a quick RFC with a couple of users converted to see what
> > > people think. I don't use a C branch with hints, because we don't want
> > > the compiler moving the loop body out of line, which makes it a bit
> > > messy unfortunately. If there's a better way to do it, I'm all ears.
> >
> > I think it will still all go wrong if the conditional isn't trivial.
> > In particular if the condition contains || or && it is likely to
> > have a branch - which could invert the loop.
> 
> I don't know that it will.
> 
> Yes, if we have exit condition that requires more branches in order to
> be computed then we lose our nice property of never taking a branch
> miss on loop exit. But we still avoid *this* branch miss, and still
> prevent multiple iterations of the wait loop being speculatively
> executed concurrently when there's no work to be done.
> 
> And C doesn't know about the loop, so it can't do any transformation
> except to compute the final condition.
> 
> Or have I missed something?

Try putting the code inside a conditional or at the bottom of a loop.
gcc can replicate code to remove a branch.

So:
	for (;;) {
		a;
		if (b)
			c;
		d;
	}

can become:
   x1:
	a;
	if (b) to x2;
	d;
	goto x1;

    x2:
	c;
	d;
	goto x1;

Which won't work.

	David

