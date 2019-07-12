From: Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Date: Fri, 12 Jul 2019 12:10:12 +0200
Message-ID: <20190712101012.GW14601@gauss3.secunet.de>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 12, 2019 at 06:06:36PM +0800, Herbert Xu wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> >
> > CPU0                                 CPU1
> > 
> > padata_reorder                       padata_do_serial
> >  LOAD reorder_objects  // 0
> >                                       INC reorder_objects  // 1
> >                                       padata_reorder
> >                                         TRYLOCK pd->lock   // failed
> >  UNLOCK pd->lock
> 
> I think this can't happen because CPU1 won't call padata_reorder
> at all as it's the wrong CPU so it gets pushed back onto a work
> queue which will go back to CPU0.
> 
> Steffen, could you please take a look at this as there clearly
> is a problem here?

I'm currently travelling, will have a look at it when I'm back.
