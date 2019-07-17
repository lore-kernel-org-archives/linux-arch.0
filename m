Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:55338 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfGQIu2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 04:50:28 -0400
Date: Wed, 17 Jul 2019 16:50:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [v2 PATCH] padata: Use RCU when fetching pd from do_serial
Message-ID: <20190717085011.hpihksnhrqt2vilo@gondor.apana.org.au>
References: <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
 <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
 <20190716130928.ga4acvxipsdzyzlp@gondor.apana.org.au>
 <20190716132345.ujj2v3kqra2lbi75@gondor.apana.org.au>
 <20190717083641.GQ17989@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717083641.GQ17989@gauss3.secunet.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190717085011.7VwDoxF6eMH7g1yeksJbEVmXaJEW5vf_BG4h0yCzkXI@z>

On Wed, Jul 17, 2019 at 10:36:41AM +0200, Steffen Klassert wrote:
>
> > This patch fixes it by using RCU just as we do in padata_do_parallel.
> 
> RCU alone won't help because if some object is queued for async
> crypto, we left the RCU protected aera. I think padata_do_serial
> needs to do RCU and should free 'parallel_data' if the flag
> PADATA_RESET is set and the refcount goes to zero. padata_replace
> should do the same then.

Yes this patch doesn't work because you can't just switch over to
the new pd as the old pd will then get stuck due to the missing
entry.

> > index 5d13d25da2c8..ce51555cb86c 100644
> > @@ -367,7 +367,7 @@ void padata_do_serial(struct padata_priv *padata)
> >  	struct parallel_data *pd;
> >  	int reorder_via_wq = 0;
> >  
> > -	pd = padata->pd;
> > +	pd = rcu_dereference_bh(padata->inst->pd);
> 
> Why not just
> 
> pd = rcu_dereference_bh(padata->pd);

I was trying to get the new pd which could only come from the inst.
In any case the whole RCU idea doesn't work so we'll probably do the
refcount idea that you suggested.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
