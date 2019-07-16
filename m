Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([62.96.220.36]:60600 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387553AbfGPLON (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jul 2019 07:14:13 -0400
Date: Tue, 16 Jul 2019 13:14:10 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Message-ID: <20190716111410.GN17989@gauss3.secunet.de>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190716111410.WtF9UdlvKebNqM7nSbhCUm_ONgDkkR2rivSSw52-Vzk@z>

On Tue, Jul 16, 2019 at 06:04:47PM +0800, Herbert Xu wrote:
> On Mon, Jul 15, 2019 at 12:10:46PM -0400, Daniel Jordan wrote:
> >
> > I've been wrong before plenty of times, and there's nothing preventing this
> > from being one of those times :) , but in this case I believe what I'm showing
> > is correct.
> > 
> > The padata_do_serial call for a given job ensures padata_reorder runs on the
> > CPU that the job hashed to in padata_do_parallel, which is not necessarily the
> > same CPU as the one that padata_do_parallel itself ran on.
> 
> You're right.  I was taking the comment in the code at face value,
> never trust comments :)
> 
> While looking at the code in question, I think it is seriously
> broken.  For instance, padata_replace does not deal with async
> crypto at all.  It would fail miserably if the underlying async
> crypto held onto references to the old pd.

Hm, yes looks like that.

padata_replace should not call padata_free_pd() as long as the
refcount is not zero. Currenlty padata_flush_queues() will
BUG if there are references left.

Maybe we can fix it if we call padata_free_pd() from
padata_serial_worker() when it sent out the last object.
