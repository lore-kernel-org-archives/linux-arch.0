Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:46590 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfGSOhp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 10:37:45 -0400
Date: Fri, 19 Jul 2019 10:37:21 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [v2 PATCH] padata: Replace delayed timer with immediate
 workqueue in padata_reorder
Message-ID: <20190719143721.awtvjf2pk37f5zsv@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
 <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
 <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
 <20190718145634.xagjemdqpoe44xxh@gondor.apana.org.au>
 <20190718150146.bztw3uugd5sqhdvk@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718150146.bztw3uugd5sqhdvk@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Steffen Klassert <steffen.klassert@secunet.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Message-ID: <20190719143721.8a0X3Xzq817xXwFZMcBKOlvTLv81ELyhC7i8VGN9dn8@z>

On Thu, Jul 18, 2019 at 11:01:46PM +0800, Herbert Xu wrote:
> @@ -376,9 +325,8 @@ void padata_do_serial(struct padata_priv *padata)
>  
>  	cpu = get_cpu();
>  
> -	/* We need to run on the same CPU padata_do_parallel(.., padata, ..)
> -	 * was called on -- or, at least, enqueue the padata object into the
> -	 * correct per-cpu queue.
> +	/* We need to enqueue the padata object into the correct
> +	 * per-cpu queue.
>  	 */
>  	if (cpu != padata->cpu) {
>  		reorder_via_wq = 1;
> @@ -388,12 +336,12 @@ void padata_do_serial(struct padata_priv *padata)
>  	pqueue = per_cpu_ptr(pd->pqueue, cpu);
>  
>  	spin_lock(&pqueue->reorder.lock);
> -	atomic_inc(&pd->reorder_objects);
>  	list_add_tail(&padata->list, &pqueue->reorder.list);
> +	atomic_inc(&pd->reorder_objects);
>  	spin_unlock(&pqueue->reorder.lock);
>  
>  	/*
> -	 * Ensure the atomic_inc of reorder_objects above is ordered correctly
> +	 * Ensure the addition to the reorder list is ordered correctly
>  	 * with the trylock of pd->lock in padata_reorder.  Pairs with smp_mb
>  	 * in padata_reorder.
>  	 */
> @@ -401,13 +349,7 @@ void padata_do_serial(struct padata_priv *padata)
>  
>  	put_cpu();
>  
> -	/* If we're running on the wrong CPU, call padata_reorder() via a
> -	 * kernel worker.
> -	 */
> -	if (reorder_via_wq)
> -		queue_work_on(cpu, pd->pinst->wq, &pqueue->reorder_work);
> -	else
> -		padata_reorder(pd);
> +	padata_reorder(pd);
>  }
>  EXPORT_SYMBOL(padata_do_serial);

If I'm not missing anything, still looks like get_cpu() and reorder_via_wq no
longer have an effect with this patch and can be removed.
