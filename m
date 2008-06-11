From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 11 Jun 2008 15:00:30 +1000
Message-ID: <200806111500.30789.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop> <200806101656.51211.nickpiggin@yahoo.com.au> <18511.21025.978328.596571@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:47427 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751357AbYFKFAn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Jun 2008 01:00:43 -0400
In-Reply-To: <18511.21025.978328.596571@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>, Trent Piepho <tpiepho@freescale.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org

On Wednesday 11 June 2008 14:18, Paul Mackerras wrote:
> Nick Piggin writes:
> > OK, I'm sitll not quite sure where this has ended up. I guess you a=
re
> > happy with x86 semantics as they are now. That is, all IO accesses =
are
> > strongly ordered WRT one another and WRT cacheable memory (which in=
cludes
> > keeping them within spinlocks),
>
> My understanding was that on x86, loads could pass stores in general,
> i.e. a later load could be performed before an earlier store.

Yes, this is the one reordering allowed by the ISA on cacheable memory.
WC memory is weaker, which Linus wants to allow exception for because
one must explicitly ask for it. UC memory (which presumably is what
we're talking about as "IO access") I think is stronger in that it does
not allow any reordering between one another or any cacheable access:

AMD says this:

c =E2=80=94 A store (wp,wt,wb,uc,wc,wc+) may not pass a previous load=20
(wp,wt,wb,uc,wc,wc+).
f =E2=80=94 A load (uc) does not pass a previous store (wp,wt,wb,uc,wc,=
wc+).
g =E2=80=94 A store (wp,wt,wb,uc) does not pass a previous store (wp,wt=
,wb,uc).
i =E2=80=94 A load (wp,wt,wb,wc,wc+) does not pass a previous store (uc=
).

AMD does allow WC/WC+ to be weakly ordered WRT WC as well as UC, which
Intel seemingly does not. But we're alrady treating WC as special.

I can't actually find the definitive statement in the Intel manuals
saying UC is strongly ordered also WRT WB. Linus?


> I guess=20
> that can't be true for uncached loads, but could a cacheable load be
> performed before an earlier uncached store?
> > - as strong as x86. guaranteed not to break drivers that work on x8=
6,
> >   but slower on some archs. To me, this is most pleasing. It is muc=
h
> >   much easier to notice something is going a little slower and to w=
ork
> >   out how to use weaker ordering there, than it is to debug some
> >   once-in-a-bluemoon breakage caused by just the right architecture=
,
> >   driver, etc. It totally frees up the driver writer from thinking
> >   about barriers, provided they get the locking right.
>
> I just wish we had even one actual example of things going wrong with
> the current rules we have on powerpc to motivate changing to this
> model.

~/usr/src/linux-2.6> git grep test_and_set_bit drivers/ | wc -l
506
How sure are you that none of those forms part of a cobbled-together
locking scheme that hopes to constrain some IO access?

~/usr/src/linux-2.6> git grep test_and_set_bit drivers/ | grep while | =
wc -l
29
How about those?

~/usr/src/linux-2.6> git grep mutex_lock drivers/ | wc -l
3138
How sure are you that none of them is hoping to constrain IO operations
within the lock?

Also grep for down, down_write, write_lock, and maybe some others I've
forgotten. And then forget completely about locking and imagine some
of the open coded things you see around the place (or parts where drive=
rs
try to get creative and open code their own locking or try lockless
things).


> > Now that doesn't leave waker ordering architectures lumped with "sl=
ow old
> > x86 semantics". Think of it as giving them the benefit of sharing x=
86
> > development and testing :) We can then formalise the relaxed __ acc=
essors
> > to be more complete (ie. +/- byteswapping).
>
> That leaves a gulf between the extremely strongly ordered writel
> etc. and the extremely weakly ordered __writel etc.  The current
> powerpc scheme is fine for a lot of drivers but your proposal would
> leave us no way to deliver it to them.

But surely you have to audit the drivers anyway to ensure they are OK
with the current powerpc scheme. In which case, once you have audited
them and know they are safe, you can easily convert them to the even
_faster_ __readl/__writel, and just add the appropriate barriers.
