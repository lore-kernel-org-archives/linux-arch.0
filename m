Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:36138 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762800AbXHIJyk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Aug 2007 05:54:40 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 2/2] x86_64: ticket lock spinlock
Date: Thu, 9 Aug 2007 11:54:34 +0200
References: <20070808042234.GE11018@wotan.suse.de> <200708081226.55651.ak@suse.de> <20070809014254.GB12539@wotan.suse.de>
In-Reply-To: <20070809014254.GB12539@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708091154.34581.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Thursday 09 August 2007 03:42:54 Nick Piggin wrote:
> On Wed, Aug 08, 2007 at 12:26:55PM +0200, Andi Kleen wrote:
> > 
> > >   *
> > >   * (the type definitions are in asm/spinlock_types.h)
> > >   */
> > >  
> > > +#if (NR_CPUS > 256)
> > > +#error spinlock supports a maximum of 256 CPUs
> > > +#endif
> > > +
> > >  static inline int __raw_spin_is_locked(raw_spinlock_t *lock)
> > >  {
> > > -	return *(volatile signed int *)(&(lock)->slock) <= 0;
> > > +	int tmp = *(volatile signed int *)(&(lock)->slock);
> > 
> > Why is slock not volatile signed int in the first place? 
> 
> Don't know really. Why does spin_is_locked need it to be volatile?

I suppose in case a caller doesn't have a memory barrier
(they should in theory, but might not). Without any barrier
or volatile gcc might optimize it away.

The other accesses in spinlocks hopefully all have barriers.

Ok anyways the patches look good.

-Andi
