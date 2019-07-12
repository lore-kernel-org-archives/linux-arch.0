Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:56766 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfGLQK0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jul 2019 12:10:26 -0400
Date: Fri, 12 Jul 2019 12:07:37 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712101012.GW14601@gauss3.secunet.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Daniel Jordan <daniel.m.jordan@oracle.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190712160737.6mgAnLd6XVFWTw-BP3V6aOlO98S6_LqzPna1msJ54qE@z>

On Fri, Jul 12, 2019 at 12:10:12PM +0200, Steffen Klassert wrote:
> On Fri, Jul 12, 2019 at 06:06:36PM +0800, Herbert Xu wrote:
> > Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> > >
> > > CPU0                                 CPU1
> > >
> > > padata_reorder                       padata_do_serial
> > >  LOAD reorder_objects  // 0
> > >                                       INC reorder_objects  // 1
> > >                                       padata_reorder
> > >                                         TRYLOCK pd->lock   // failed
> > >  UNLOCK pd->lock
> >
> > I think this can't happen because CPU1 won't call padata_reorder
> > at all as it's the wrong CPU so it gets pushed back onto a work
> > queue which will go back to CPU0.

Thanks for looking at this.

When you say the wrong CPU, I think you're referring to the reorder_via_wq
logic in padata_do_serial.  If so, I think my explanation was unclear, because
there were two padata jobs in flight and my tracepoints showed neither of them
punted padata_reorder to a workqueue.  Let me expand on this, hopefully it
helps.

pcrypt used CPU 5 for its callback CPU.  The first job in question, with
sequence number 16581, hashed to CPU 21 on my system.  This is a more complete
version of what led to the hanging modprobe command.

modprobe (CPU2)               kworker/21:1-293 (CPU21)                              kworker/5:2-276 (CPU5)
--------------------------    ------------------------                              ----------------------
<submit job, seq_nr=16581>
...
  padata_do_parallel
    queue_work_on(21, ...)
<sleeps>
                              padata_parallel_worker
                                pcrypt_aead_dec
                                  padata_do_serial
                                    padata_reorder
                                    | padata_get_next  // returns job, seq_nr=16581
                                    | // serialize seq_nr=16581
                                    | queue_work_on(5, ...)
                                    | padata_get_next  // returns -EINPROGRESS
                                    // padata_reorder doesn't return yet!
                                    | |                                             padata_serial_worker
                                    | |                                               pcrypt_aead_serial
                                    | |                                                 <wake up modprobe>
                                    | |                                             <worker finishes>
<submit job, seq_nr=16582>          | |
...                                 | |
  padata_do_parallel                | |
    queue_work_on(22, ...)          | | (LOAD reorder_objects as 0 somewhere
<sleeps>                            | |    in here, before the INC)
                                    | |                                             kworker/22:1-291 (CPU22)
                                    | |                                             ------------------------
                                    | |                                             padata_parallel_worker
                                    | |                                               pcrypt_aead_dec
                                    | |                                                 padata_do_serial
                                    | |                                                   // INC reorder_objects to 1
                                    | |                                                   padata_reorder
                                    | |                                                     // trylock fail, CPU21 _should_
                                    | |                                                     //   serialize 16582 but doesn't
                                    | |                                             <worker finishes>
                                    | // deletes pd->timer
                                    // padata_reorder returns
                              <worker finishes>
<keeps on sleeping lazily>

My tracepoints showed CPU22 increased reorder_objects to 1 but CPU21 read it as
0.

I think adding the full barrier guarantees the following ordering, and the
memory model people can correct me if I'm wrong:

CPU21                      CPU22
------------------------   --------------------------
UNLOCK pd->lock
smp_mb()
LOAD reorder_objects
                           INC reorder_objects
                           spin_unlock(&pqueue->reorder.lock) // release barrier
                           TRYLOCK pd->lock

So if CPU22 has incremented reorder_objects but CPU21 reads 0 for it, CPU21
should also have unlocked pd->lock so CPU22 can get it and serialize any
remaining jobs.
