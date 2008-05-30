From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 03/41] cpu alloc: Use cpu allocator instead of the builtin
 modules per cpu allocator
Date: Thu, 29 May 2008 23:21:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805292317470.12457@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <20080530040011.451400376@sgi.com>
 <200805301608.01584.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:54271 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753967AbYE3GVE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 02:21:04 -0400
In-Reply-To: <200805301608.01584.rusty@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Fri, 30 May 2008, Rusty Russell wrote:

> Hmm, does cpu_free(NULL, 0) do something?  Seems like it shouldn't, for 
> symmetry with free().

No it just returns.

> > +		percpu = cpu_alloc(size, GFP_KERNEL|__GFP_ZERO, align);
> > +		if (!percpu)
> > +			printk(KERN_WARNING "Could not allocate %lu bytes percpu data\n",
> > +										size);
> >  		if (!percpu) {
> >  			err = -ENOMEM;
> >  			goto free_mod;
> 
> OK, we've *never* had a report of the per-cpu alignment message, so I'd be 
> happy to pass that through to cpu_alloc() and have it fail.  Also, the if 
> (!percpu) cases should be combined.

Ack.

> >   free_percpu:
> >  	if (percpu)
> > -		percpu_modfree(percpu);
> > +		cpu_free(percpu, percpu_size);
> 
> As above.

The if can be dropped.

> 
> > +	goal = __per_cpu_size;
> 
> Where did __per_cpu_size come from?  I missed it in the earlier patches...

Its __per_cpu_end - __per_cpu_start.
