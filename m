From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/3] spinlock: allow inlined spinlocks
Date: Sun, 16 Aug 2009 11:22:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908161101470.3162@localhost.localdomain>
References: <20090814125801.881618121@de.ibm.com> <20090814125857.181021997@de.ibm.com> <20090816175750.GA5808@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35922 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755519AbZHPSXM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 16 Aug 2009 14:23:12 -0400
In-Reply-To: <20090816175750.GA5808@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>



On Sun, 16 Aug 2009, Heiko Carstens wrote:
> 
> do you have any objections to the approach below?
> Just wondering, since I didn't receive any comments.

Other things going on, but here goes:

> > +#ifdef __spin_lock_is_small
> > +#define _spin_lock(lock) __spin_lock(lock)
> > +#else
> > +void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);
> > +#endif

The above repeats many times, and I found that irritating. I think you 
should be able to get rid of a _lot_ of that by doing it like this instead

	extern void __lockfunc _spin_lock(spinlock_t *lock) __acquires(lock);
	... plain declarations for all cases, no #ifdef's ...

and then at the end you just do

	#ifdef __spin_lock_is_small
	  #define _spin_lock(lock) __spin_lock(lock)         
	#endif
	..

and at least make that repeating section be composed of simpler and 
smaller entries.

Now, I actually have a disgusting way to avoid the #ifdef's entirely, but 
I'm not sure it's worth it. You'd do the same unconditional function 
declarations, but then we can also do some unconditional CPP expansions:

	#define __define2_lock(name,extent) name##extent
	#define __define_lock(name,extent) __define2_lock(name,extent)  
	#define define_lock(name) __define_lock(__##name, __##name##_is_small)

	// for each lock type
	#define __spin_lock__spin_lock_is_small _spin_lock  
	#define _spin_lock define_lock(spin_lock)

and what happens is that if '__spin_lock_is_small' is undefined, you end 
up having '_spin_lock()' expand to '__spin_lock__spin_lock_is_small()' and 
then back to _spin_lock, but if it's #defined (to empty), it gets defined 
to __spin_lock() instead.

No ifdefs, just two unconditional #define lines for each lock type.

Ugly? Yes. Less ugly than having variations of that #ifdef repeated many 
times? I dunno.

			Linus
