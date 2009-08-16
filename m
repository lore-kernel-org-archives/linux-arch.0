From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/3] spinlock: allow inlined spinlocks
Date: Sun, 16 Aug 2009 20:06:31 +0200
Message-ID: <20090816180631.GA23448@elte.hu>
References: <20090814125801.881618121@de.ibm.com> <20090814125857.181021997@de.ibm.com> <20090816175750.GA5808@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:58891 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbZHPSGv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 16 Aug 2009 14:06:51 -0400
Content-Disposition: inline
In-Reply-To: <20090816175750.GA5808@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> > #define __spin_lock_is_small

> > +unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
> > +							__acquires(lock);
> > +
> > +#ifdef __spin_lock_is_small
> > +#define _spin_lock(lock) __spin_lock(lock)
> > +#else
> > +void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock);
> > +#endif

Dunno - i'm somewhat wary of introducing a 2^28 variability here. 
(although the number of real variations is much lower - but still).

What's the current situation on s390, precisely which of the 28 lock 
functions are a win to be inlined and which ones are a loss? Do you 
have a list/table perhaps?

	Ingo
