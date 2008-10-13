From: Scott Wood <scottwood@freescale.com>
Subject: Re: [patch] powerpc: implement optimised mutex fastpaths
Date: Mon, 13 Oct 2008 11:15:47 -0500
Message-ID: <20081013161547.GB19080@ld0162-tx32.am.freescale.net>
References: <20081012054634.GA12535@wotan.suse.de> <20081012054732.GB12535@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:38959 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756445AbYJMQP6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Oct 2008 12:15:58 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id m9DGFpNZ013539
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2008 09:15:52 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net [10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m9DGFmWe010155
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2008 11:15:48 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20081012054732.GB12535@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org

On Sun, Oct 12, 2008 at 07:47:32AM +0200, Nick Piggin wrote:
> +static inline int __mutex_cmpxchg_lock(atomic_t *v, int old, int new)
> +{
> +	int t;
> +
> +	__asm__ __volatile__ (
> +"1:	lwarx	%0,0,%1		# mutex trylock\n\
> +	cmpw	0,%0,%2\n\
> +	bne-	2f\n"
> +	PPC405_ERR77(0,%1)
> +"	stwcx.	%3,0,%1\n\
> +	bne-	1b"
> +	ISYNC_ON_SMP
> +	"\n\
> +2:"
> +	: "=&r" (t)
> +	: "r" (&v->counter), "r" (old), "r" (new)
> +	: "cc", "memory");

This will break if the compiler picks r0 for &v->counter.  Use "b" as the
constraint, or better yet do "lwarx %0, %y1", with a "Z" (v->counter)
constraint.

-Scott
