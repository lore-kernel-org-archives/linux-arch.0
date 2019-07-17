Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([62.96.220.36]:34262 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQIgo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 04:36:44 -0400
Date: Wed, 17 Jul 2019 10:36:41 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [v2 PATCH] padata: Use RCU when fetching pd from do_serial
Message-ID: <20190717083641.GQ17989@gauss3.secunet.de>
References: <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
 <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
 <20190716130928.ga4acvxipsdzyzlp@gondor.apana.org.au>
 <20190716132345.ujj2v3kqra2lbi75@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190716132345.ujj2v3kqra2lbi75@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190717083641.XUpciKABUOTYxjRPJSaScUxcurAts0FCcjlHTpCxLeY@z>

On Tue, Jul 16, 2019 at 09:23:45PM +0800, Herbert Xu wrote:
> On Tue, Jul 16, 2019 at 09:09:28PM +0800, Herbert Xu wrote:
> >
> > Hmm, it doesn't work because the refcnt is attached to the old
> > pd.  That shouldn't be a problem though as we could simply ignore
> > the refcnt in padata_flush_queue.
> 
> This should fix it:
> 
> ---8<---
> The function padata_do_serial uses parallel_data without obeying
> the RCU rules around its life-cycle.  This means that a concurrent
> padata_replace call can result in a crash.
> 
> This patch fixes it by using RCU just as we do in padata_do_parallel.

RCU alone won't help because if some object is queued for async
crypto, we left the RCU protected aera. I think padata_do_serial
needs to do RCU and should free 'parallel_data' if the flag
PADATA_RESET is set and the refcount goes to zero. padata_replace
should do the same then.

> 
> As the refcnt may now span two parallel_data structures, this patch
> moves it to padata_instance instead.  FWIW the refcnt is used to
> limit the number of outstanding requests (albeit a soft limit as
> we don't do a proper atomic inc and test).
> 
> Fixes: 16295bec6398 ("padata: Generic parallelization/...")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/include/linux/padata.h b/include/linux/padata.h

...

> index 5d13d25da2c8..ce51555cb86c 100644
> @@ -367,7 +367,7 @@ void padata_do_serial(struct padata_priv *padata)
>  	struct parallel_data *pd;
>  	int reorder_via_wq = 0;
>  
> -	pd = padata->pd;
> +	pd = rcu_dereference_bh(padata->inst->pd);

Why not just

pd = rcu_dereference_bh(padata->pd);
