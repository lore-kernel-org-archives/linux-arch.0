Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:56287 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbYJNGGK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Oct 2008 02:06:10 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id m9E62H0D012528
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2008 23:06:07 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net [10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m9DGKLsQ006183
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2008 11:20:21 -0500 (CDT)
Date: Mon, 13 Oct 2008 11:20:20 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [patch] powerpc: implement optimised mutex fastpaths
Message-ID: <20081013162020.GC19080@ld0162-tx32.am.freescale.net>
References: <20081012054634.GA12535@wotan.suse.de> <20081012054732.GB12535@wotan.suse.de> <20081013161547.GB19080@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081013161547.GB19080@ld0162-tx32.am.freescale.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>, paulus@samba.org
Message-ID: <20081013162020.mcOQWY4tOtue8ptsg2r9omCyo-NO3XuVGQMfbjyXz1E@z>

On Mon, Oct 13, 2008 at 11:15:47AM -0500, Scott Wood wrote:
> On Sun, Oct 12, 2008 at 07:47:32AM +0200, Nick Piggin wrote:
> > +static inline int __mutex_cmpxchg_lock(atomic_t *v, int old, int new)
> > +{
> > +	int t;
> > +
> > +	__asm__ __volatile__ (
> > +"1:	lwarx	%0,0,%1		# mutex trylock\n\
> > +	cmpw	0,%0,%2\n\
> > +	bne-	2f\n"
> > +	PPC405_ERR77(0,%1)
> > +"	stwcx.	%3,0,%1\n\
> > +	bne-	1b"
> > +	ISYNC_ON_SMP
> > +	"\n\
> > +2:"
> > +	: "=&r" (t)
> > +	: "r" (&v->counter), "r" (old), "r" (new)
> > +	: "cc", "memory");
> 
> This will break if the compiler picks r0 for &v->counter.  Use "b" as the
> constraint, or better yet do "lwarx %0, %y1", with a "Z" (v->counter)
> constraint.

Sorry, had a morning brain-fart there -- you're not using the base
register.

-Scott
