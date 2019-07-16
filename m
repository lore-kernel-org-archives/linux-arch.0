From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] padata: Use RCU when fetching pd from do_serial
Date: Tue, 16 Jul 2019 21:18:07 +0800
Message-ID: <20190716131807.twahbbdff6jhpnu2@gondor.apana.org.au>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
 <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
 <20190716131520.GB3402@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190716131520.GB3402@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 16, 2019 at 03:15:20PM +0200, Peter Zijlstra wrote:
>
> > @@ -367,7 +368,7 @@ void padata_do_serial(struct padata_priv *padata)
> >  	struct parallel_data *pd;
> >  	int reorder_via_wq = 0;
> >  
> > -	pd = padata->pd;
> > +	pd = rcu_dereference_bh(padata->inst->pd);
> >  
> >  	cpu = get_cpu();
> >  
> 
> That's weird for not having a matching assign and lacking comments to
> explain that.

There is a matching rcu_assign_pointer.  But we should add some
RCU markers.

Or perhaps you're misreading the level of indirections :)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
