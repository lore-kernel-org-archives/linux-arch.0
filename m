Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPNOE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 09:14:04 -0400
Date: Tue, 16 Jul 2019 15:13:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190716131350.GA3402@hirez.programming.kicks-ass.net>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190716125309.GA10672@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716125309.GA10672@andrea>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, boqun.feng@gmail.com, paulmck@linux.ibm.com, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, will@kernel.org
Message-ID: <20190716131350.aha1Z7JKneOQLfM6BDBHGyxGFeWcm2c5yAtL96oF-1k@z>

On Tue, Jul 16, 2019 at 02:53:09PM +0200, Andrea Parri wrote:

> C daniel-padata
> 
> { }
> 
> P0(atomic_t *reorder_objects, spinlock_t *pd_lock)
> {
> 	int r0;
> 
> 	spin_lock(pd_lock);
> 	spin_unlock(pd_lock);
> 	smp_mb();
> 	r0 = atomic_read(reorder_objects);
> }
> 
> P1(atomic_t *reorder_objects, spinlock_t *pd_lock, spinlock_t *reorder_lock)
> {
> 	int r1;
> 
> 	spin_lock(reorder_lock);
> 	atomic_inc(reorder_objects);
> 	spin_unlock(reorder_lock);
> 	//smp_mb();
> 	r1 = spin_trylock(pd_lock);
> }
> 
> exists (0:r0=0 /\ 1:r1=0)
> 
> It seems worth noticing that this test's "exists" clause is satisfiable
> according to the (current) memory consistency model.  (Informally, this
> can be explained by noticing that the RELEASE from the spin_unlock() in
> P1 does not provide any order between the atomic increment and the read
> part of the spin_trylock() operation.)  FWIW, uncommenting the smp_mb()
> in P1 would suffice to prevent this clause from being satisfiable; I am
> not sure, however, whether this approach is feasible or ideal... (sorry,
> I'm definitely not too familiar with this code... ;/)

Urgh, that one again.

Yes, you need the smp_mb(); although a whole bunch of architectures can
live without it. IIRC it is part of the eternal RCsc/RCpc debate.

Paul/RCU have their smp_mb__after_unlock_lock() that is about something
similar, although we've so far confinsed that to the RCU code, because
of how confusing that all is.
