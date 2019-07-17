Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:59650 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfGQSdF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 14:33:05 -0400
Date: Wed, 17 Jul 2019 14:32:27 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH] padata: Replace delayed timer with immediate workqueue
 in padata_reorder
Message-ID: <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Steffen Klassert <steffen.klassert@secunet.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Message-ID: <20190717183227.ejpKMpFNBxXG2cTyji7s-oNkPdzRVEVKa1I37TtAl6U@z>

On Wed, Jul 17, 2019 at 07:11:47PM +0800, Herbert Xu wrote:
> On Tue, Jul 16, 2019 at 12:32:53PM -0400, Daniel Jordan wrote:
> > Testing padata with the tcrypt module on a 5.2 kernel...
> 
> Thanks for the patch!
> 
> And here is an incremental patch to get rid of the timer that
> appears to be an attempt at fixing a problem related to this.

Nice, +1 for getting rid of the timer.

> diff --git a/kernel/padata.c b/kernel/padata.c
> index 15a8ad63f4ff..b5dfc21e976f 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -165,23 +165,12 @@ EXPORT_SYMBOL(padata_do_parallel);
>   */
>  static struct padata_priv *padata_get_next(struct parallel_data *pd)
>  {
> -	int cpu, num_cpus;
> -	unsigned int next_nr, next_index;
>  	struct padata_parallel_queue *next_queue;
>  	struct padata_priv *padata;
>  	struct padata_list *reorder;
> +	int cpu = pd->cpu;
>  
> -	num_cpus = cpumask_weight(pd->cpumask.pcpu);
> -
> -	/*
> -	 * Calculate the percpu reorder queue and the sequence
> -	 * number of the next object.
> -	 */
> -	next_nr = pd->processed;
> -	next_index = next_nr % num_cpus;
> -	cpu = padata_index_to_cpu(pd, next_index);
>  	next_queue = per_cpu_ptr(pd->pqueue, cpu);
> -
>  	reorder = &next_queue->reorder;
>  
>  	spin_lock(&reorder->lock);
> @@ -192,7 +181,8 @@ static struct padata_priv *padata_get_next(struct parallel_data *pd)
>  		list_del_init(&padata->list);
>  		atomic_dec(&pd->reorder_objects);
>  
> -		pd->processed++;
> +		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, 0,
> +					    false);

We'll crash when cpumask_next_wrap returns nr_cpumask_bits and later try to get
the corresponding per-cpu queue.

This handles that as well as the case where there's only 1 CPU in the parallel
mask:

diff --git a/kernel/padata.c b/kernel/padata.c
index b5dfc21e976f..ab352839df04 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -181,8 +181,10 @@ static struct padata_priv *padata_get_next(struct parallel_data *pd)
 		list_del_init(&padata->list);
 		atomic_dec(&pd->reorder_objects);
 
-		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, 0,
-					    false);
+		if (cpumask_weight(pd->cpumask.pcpu) > 1) {
+			pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, cpu,
+						    false);
+		}
 
 		spin_unlock(&reorder->lock);
 		goto out;



Haven't finished looking at the patch, but have to run somewhere for now, will
pick it up later today.
