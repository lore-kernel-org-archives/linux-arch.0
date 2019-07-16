Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44383 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGPMxU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 08:53:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so20800890wrf.11
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2019 05:53:19 -0700 (PDT)
Date: Tue, 16 Jul 2019 14:53:09 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190716125309.GA10672@andrea>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190716125309.ARvXqAoCAmEwUe0CWzmRQ6nfi-q7E0V4H2v2le-XS94@z>

Hi Daniel,

My two cents (summarizing some findings we discussed privately):


> I think adding the full barrier guarantees the following ordering, and the
> memory model people can correct me if I'm wrong:
> 
> CPU21                      CPU22
> ------------------------   --------------------------
> UNLOCK pd->lock
> smp_mb()
> LOAD reorder_objects
>                            INC reorder_objects
>                            spin_unlock(&pqueue->reorder.lock) // release barrier
>                            TRYLOCK pd->lock
> 
> So if CPU22 has incremented reorder_objects but CPU21 reads 0 for it, CPU21
> should also have unlocked pd->lock so CPU22 can get it and serialize any
> remaining jobs.

This information inspired me to write down the following litmus test:
(AFAICT, you independently wrote a very similar test, which is indeed
quite reassuring! ;D)

C daniel-padata

{ }

P0(atomic_t *reorder_objects, spinlock_t *pd_lock)
{
	int r0;

	spin_lock(pd_lock);
	spin_unlock(pd_lock);
	smp_mb();
	r0 = atomic_read(reorder_objects);
}

P1(atomic_t *reorder_objects, spinlock_t *pd_lock, spinlock_t *reorder_lock)
{
	int r1;

	spin_lock(reorder_lock);
	atomic_inc(reorder_objects);
	spin_unlock(reorder_lock);
	//smp_mb();
	r1 = spin_trylock(pd_lock);
}

exists (0:r0=0 /\ 1:r1=0)

It seems worth noticing that this test's "exists" clause is satisfiable
according to the (current) memory consistency model.  (Informally, this
can be explained by noticing that the RELEASE from the spin_unlock() in
P1 does not provide any order between the atomic increment and the read
part of the spin_trylock() operation.)  FWIW, uncommenting the smp_mb()
in P1 would suffice to prevent this clause from being satisfiable; I am
not sure, however, whether this approach is feasible or ideal... (sorry,
I'm definitely not too familiar with this code... ;/)

Thanks,
  Andrea
