Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268498AbUHLJZq@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.29.151]:25545 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261232AbUHLJXu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Aug 2004 05:23:50 -0400
In-Reply-To: <20040812021111.GB14411@wotan.suse.de>
Subject: Re: clear_user_highpage()
Message-ID: <OF22CA799C.42B8F6AC-ON42256EEE.0030CA75-42256EEE.00339D43@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 12 Aug 2004 11:23:46 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
To: Andi Kleen <ak@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@redhat.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>





> > > I think dynamic-resolution timers are the way to go here.
> > > Rusty was talking about something along theses lines at
> > > the networking summit.
> >
> > Yup, several people talked about it at KS/OLS and I think  s390 has
> > some implementation already, though I hadn't time to look at it yet,
> > hopefully that will happen sooner or later.
>
> My main issue with the s390 approach is that they actually
> wanted to get rid of jiffies. That's fine for long term,
> but short term it would be a big problem because it would
> break everything. IMHO the way to do it would be to define
> jiffies to a function and keep virtual jiffies using the CLOCK_MONOTONIC
> timer. Then only tick with a low frequency for statistic ticks
> and disabled for idle or when an actual event is scheduled.

In the end we indeed want to get rid of jiffies altogether. But it's a long
road. What we are currently doing is to replace some of the dependecies to
jiffies in the common code. E.g. instead of doing the cpu time accounting
on a tick base we want to introduce a cputime_t type that is in principle
not related to jiffies (but it is in the generic implementation). The
process accounting is done by a new account_cputime function that can be
called any time and can be passed any amount of cputime. On s390 we'll
define cputime_t based on a virtual cpu timer with microseconds resolution.
This solves two problems, the first is the fact that running on a virtual
processor f**** up your tick based accounting badly. The second is the
accuracy of the number in /proc/stat. The second step is to untie the
time slices from the jiffies tick.

> I didn't have time to actually work on it, the s390 guys
> are writing actual code, so they win for now :)

We win ?!? Hey, we win ;-)) I posted a first set of cputime patches on
lkml last week. I probably post them here shortly in the hope to get
a little more feedback from you arch guys.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com
