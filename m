Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPNue (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 09:50:34 -0400
Date: Tue, 16 Jul 2019 15:50:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] padata: Use RCU when fetching pd from do_serial
Message-ID: <20190716135010.GC3402@hirez.programming.kicks-ass.net>
References: <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
 <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
 <20190716131520.GB3402@hirez.programming.kicks-ass.net>
 <20190716131807.twahbbdff6jhpnu2@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716131807.twahbbdff6jhpnu2@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190716135010.8jiYe4iNKqHNIxcnYo4Jljwa34qT1fu6pJD7cyaANLk@z>

On Tue, Jul 16, 2019 at 09:18:07PM +0800, Herbert Xu wrote:
> On Tue, Jul 16, 2019 at 03:15:20PM +0200, Peter Zijlstra wrote:
> >
> > > @@ -367,7 +368,7 @@ void padata_do_serial(struct padata_priv *padata)
> > >  	struct parallel_data *pd;
> > >  	int reorder_via_wq = 0;
> > >  
> > > -	pd = padata->pd;
> > > +	pd = rcu_dereference_bh(padata->inst->pd);
> > >  
> > >  	cpu = get_cpu();
> > >  
> > 
> > That's weird for not having a matching assign and lacking comments to
> > explain that.
> 
> There is a matching rcu_assign_pointer.  But we should add some
> RCU markers.
> 
> Or perhaps you're misreading the level of indirections :)

Could well be, I'm not much familiar with this code; I'll look more
careful.
