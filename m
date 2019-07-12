From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Date: Fri, 12 Jul 2019 18:06:36 +0800
Message-ID: <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: steffen.klassert@secunet.com, daniel.m.jordan@oracle.com, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>
> CPU0                                 CPU1
> 
> padata_reorder                       padata_do_serial
>  LOAD reorder_objects  // 0
>                                       INC reorder_objects  // 1
>                                       padata_reorder
>                                         TRYLOCK pd->lock   // failed
>  UNLOCK pd->lock

I think this can't happen because CPU1 won't call padata_reorder
at all as it's the wrong CPU so it gets pushed back onto a work
queue which will go back to CPU0.

Steffen, could you please take a look at this as there clearly
is a problem here?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
