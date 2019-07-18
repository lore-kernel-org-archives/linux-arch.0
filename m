Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:34152 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfGROZx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2019 10:25:53 -0400
Date: Thu, 18 Jul 2019 10:25:15 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH] padata: Replace delayed timer with immediate workqueue
 in padata_reorder
Message-ID: <20190718142515.teinr4da3gps5r7a@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717232136.pboms73sqf6fdzic@ca-dmjordan1.us.oracle.com>
 <20190718033008.wle67s7esg27mrtz@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718033008.wle67s7esg27mrtz@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Steffen Klassert <steffen.klassert@secunet.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Message-ID: <20190718142515.4j5cVVIGrXd-2NvkX_K_VK0DVJJyJCVu1PJ-dMUYd30@z>

On Thu, Jul 18, 2019 at 11:30:08AM +0800, Herbert Xu wrote:
> On Wed, Jul 17, 2019 at 07:21:36PM -0400, Daniel Jordan wrote:
> >
> > > @@ -388,12 +336,12 @@ void padata_do_serial(struct padata_priv *padata)
> > >  	pqueue = per_cpu_ptr(pd->pqueue, cpu);
> > >  
> > >  	spin_lock(&pqueue->reorder.lock);
> > > -	atomic_inc(&pd->reorder_objects);
> > >  	list_add_tail(&padata->list, &pqueue->reorder.list);
> > > +	atomic_inc(&pd->reorder_objects);
> > 
> > Why switch the lines?  Seems ok to not do this.
> 
> This is crucial because otherwise the memory barrier won't apply
> to the list insertion.  With this patch, we are now using the list
> insertion as the indicator, rather than reorder_objects.

Which memory barrier do you mean?  I think you're referring to the one that
atomic_inc might provide?  If so, the memory model maintainers can correct me
here, but my understanding is that RMW atomic ops that don't return values are
unordered, so switching the lines has no effect.

Besides, the smp_mb__after_atomic is what orders the list insertion with the
trylock of pd->lock.

> > > @@ -538,8 +479,6 @@ static void padata_flush_queues(struct parallel_data *pd)
> > >  		flush_work(&pqueue->work);
> > >  	}
> > >  
> > > -	del_timer_sync(&pd->timer);
> > > -
> > 
> > >  	if (atomic_read(&pd->reorder_objects))
> > >  		padata_reorder(pd);
> > 
> > I think we can do away with reorder_objects entirely by checking pd->cpu's
> > reorder queue here.
> 
> As I said this will probably disappear altogether since we can't
> guarantee that padata_reorder will actually do anything if the
> jobs are stuck in async crypto processing.

Ok, makes sense.
