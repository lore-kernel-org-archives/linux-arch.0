From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [RFC/PULL 00/11] introduce export.h; reduce module.h usage
Date: Thu, 28 Jul 2011 11:27:53 -0400
Message-ID: <20110728152753.GA19409@windriver.com>
References: <1311830178-30314-1-git-send-email-paul.gortmaker@windriver.com>
 <CA+55aFwtyfzaFABHKD+OMWsojGov0JLmnrZimhVaOcrer=tJjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:62234 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab1G1P2P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jul 2011 11:28:15 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFwtyfzaFABHKD+OMWsojGov0JLmnrZimhVaOcrer=tJjQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org

[Re: [RFC/PULL 00/11] introduce export.h; reduce module.h usage] On 28/=
07/2011 (Thu 06:19) Linus Torvalds wrote:

> On Wed, Jul 27, 2011 at 10:16 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> >
> > For all 160 commits, the branch "module.h-split", available here:
> >
> > =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/paulg/=
linux.git
> >
> > has the complete content. =A0I've put the header changes after all =
the
> > patches from the top 5 categories, so that people bisecting non rel=
ated
> > issues at a later date don't get hit with a commit zone with build =
failures.
>=20
> Ok, sounds good. Two questions:
>=20
>  - how much testing (randconfig? different architectures?) has this g=
otten?

I built allyeconfigs for arm, mips, powerpc, sparc, x86, x86-64.
Originally I was working on a v3.0-rc7 baseline, but after looking
at the new implicit module.h usages added since then, it was apparent
that I should update the baseline.

So I've re-run the multi-arch allyesconfigs to catch those new ones,
but with fallout from completely non related stuff, the allyesconfigs
on the non x86 variants don't build as far on the new v3.0-5684-ge371d4=
6
baseline as they did on the 3.0-rc7 (to be expected in a tree leading u=
p
to an rc1 release).

>=20
>  - how much does this actually improve compile times (for a "normal"
> build or a "allmodconfig" one)?

Let me run some "real world" use cases and get back to you in a couple
of hours with that.  But Ingo's testing on a much earlier snapshot was
showing roughly a couple percent.  ( https://lkml.org/lkml/2011/5/28/60=
 )

> It certainly sounds like the RightThing(tm) to do, but I'd like to
> know that there is real actual improvements to build times and that
> the pain won't be too bad...

Yes, I've spent a lot of time fixing as many implicit users (thousands)
to try and minimize the pain here.  But I'd be a fool to think I have
them all fixed in the less mainstream architectures (alpha, sh, etc.)

And I know mips and arm have quite a few files that are platform specif=
ic
in mach-* and plat-* and they might not all get coverage via allyesconf=
ig.
That is one place where I can think of that I am going to expand even
more testing into today.  Adding it to linux-next can't hurt either.

Thanks,
Paul.

>=20
>              Linus
