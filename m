From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] powerpc: implement optimised mutex fastpaths
Date: Tue, 14 Oct 2008 09:06:22 +0200
Message-ID: <20081014070621.GA2681@wotan.suse.de>
References: <20081012054634.GA12535@wotan.suse.de> <20081012054732.GB12535@wotan.suse.de> <20081013161547.GB19080@ld0162-tx32.am.freescale.net> <20081013162020.GC19080@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:54031 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbYJNHGY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Oct 2008 03:06:24 -0400
Content-Disposition: inline
In-Reply-To: <20081013162020.GC19080@ld0162-tx32.am.freescale.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Scott Wood <scottwood@freescale.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>, paulus@samba.org

On Mon, Oct 13, 2008 at 11:20:20AM -0500, Scott Wood wrote:
> On Mon, Oct 13, 2008 at 11:15:47AM -0500, Scott Wood wrote:
> > On Sun, Oct 12, 2008 at 07:47:32AM +0200, Nick Piggin wrote:
> > > +static inline int __mutex_cmpxchg_lock(atomic_t *v, int old, int new)
> > > +{
> > > +	int t;
> > > +
> > > +	__asm__ __volatile__ (
> > > +"1:	lwarx	%0,0,%1		# mutex trylock\n\
> > > +	cmpw	0,%0,%2\n\
> > > +	bne-	2f\n"
> > > +	PPC405_ERR77(0,%1)
> > > +"	stwcx.	%3,0,%1\n\
> > > +	bne-	1b"
> > > +	ISYNC_ON_SMP
> > > +	"\n\
> > > +2:"
> > > +	: "=&r" (t)
> > > +	: "r" (&v->counter), "r" (old), "r" (new)
> > > +	: "cc", "memory");
> > 
> > This will break if the compiler picks r0 for &v->counter.  Use "b" as the
> > constraint, or better yet do "lwarx %0, %y1", with a "Z" (v->counter)
> > constraint.
> 
> Sorry, had a morning brain-fart there -- you're not using the base
> register.

OK no problem. Do you think it looks OK? Thanks for reviewing...
