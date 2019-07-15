Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:50876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfGOQLX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 12:11:23 -0400
Date: Mon, 15 Jul 2019 12:10:46 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Steffen Klassert <steffen.klassert@secunet.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190715161046.H3Ps9kmkC52_YKRvkby2HWKwTO2QV4bEvFTpWqBPf28@z>

On Sat, Jul 13, 2019 at 01:03:21PM +0800, Herbert Xu wrote:
> On Fri, Jul 12, 2019 at 12:07:37PM -0400, Daniel Jordan wrote:
> >
> > modprobe (CPU2)               kworker/21:1-293 (CPU21)                              kworker/5:2-276 (CPU5)
> > --------------------------    ------------------------                              ----------------------
> > <submit job, seq_nr=16581>
> > ...
> >   padata_do_parallel
> >     queue_work_on(21, ...)
> > <sleeps>
> >                               padata_parallel_worker
> >                                 pcrypt_aead_dec
> >                                   padata_do_serial
> >                                     padata_reorder
> 
> This can't happen because if the job started on CPU2 then it must
> go back to CPU2 for completion.  IOW padata_do_serial should be
> punting this to a work queue for CPU2 rather than calling
> padata_reorder on CPU21.

I've been wrong before plenty of times, and there's nothing preventing this
from being one of those times :) , but in this case I believe what I'm showing
is correct.

The padata_do_serial call for a given job ensures padata_reorder runs on the
CPU that the job hashed to in padata_do_parallel, which is not necessarily the
same CPU as the one that padata_do_parallel itself ran on.

In this case, the padata job in question started via padata_do_parallel, where
it hashed to CPU 21:

  padata_do_parallel                    // ran on CPU 2
    ...
    target_cpu = padata_cpu_hash(pd);   // target_cpu == 21
    padata->cpu = target_cpu;
    ...
    queue_work_on(21, ...)

The corresponding kworker then started:

  padata_parallel_worker                // bound to CPU 21
    pcrypt_aead_dec
      padata_do_serial
        padata_reorder

Daniel
