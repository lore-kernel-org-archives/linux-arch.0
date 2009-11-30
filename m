From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Subject: Re: [PATCH/RFC 1/6] numa: Use Generic Per-cpu Variables for
 numa_node_id()
Date: Mon, 30 Nov 2009 15:28:40 -0500
Message-ID: <1259612920.4663.156.camel@useless.americas.hpqcorp.net>
References: <20091113211714.15074.29078.sendpatchset@localhost.localdomain>
	 <20091113211720.15074.99808.sendpatchset@localhost.localdomain>
	 <alpine.DEB.1.10.0911201044320.25879@V090114053VZO-1>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:25973 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbZK3U2h (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Nov 2009 15:28:37 -0500
In-Reply-To: <alpine.DEB.1.10.0911201044320.25879@V090114053VZO-1>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Mel Gorman <mel@csn.ul.ie>, Christoph Lameter <clameter@sgi.com>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, eric.whitney@hp.com, Tejun Heo <tj@kernel.org>

On Fri, 2009-11-20 at 10:46 -0500, Christoph Lameter wrote:
> On Fri, 13 Nov 2009, Lee Schermerhorn wrote:
> 
> > Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
> > [Christoph's signoff here?]
> 
> Basically yes. The moving of the this_cpu ops to asm-generic is something
> that is bothering me. Tejun?

So here's what happened:

linux/topology.h now depends on */percpu.h to implement numa_node_id()
and numa_mem_id().  Not so much an issue for x86 because its
asm/topology.h already depended on its asm/percpu.h.  But ia64, for
instance--maybe any arch that doesn't already implement numa_node_id()
as a percpu variable--didn't define this_cpu_read() for
linux/topology.h.

So, I included <linux/percpu.h>.

linux/percpu.h, for reasons of its own, includes linux/swap.h which
includes linux/gfp.h which includes linux/topology.h for the definition
of numa_node_id().  topology.h hasn't gotten around to defining
numa_node_id() yet--it's still including percpu.h.  ...

Looking at other asm/foo.h and asm-generic/foo.h relationships, I see
that some define the generic version of the api in the asm-generic
header if the arch asm header hasn't already defined it.  asm/topology.h
is an instance of this.  It includes asm-generic/topology.h after
defining arch specific versions of some of the api.

Following this model, I moved the generic definitions of the percpu api
back to the asm-generic version where it would be available without the
inclusion of swap.h, et al. 

I tried including <asm/percpu.h> in linux/topology.h but the was advised
to use the generic header.  So I followed the model of the x86
asm/topology.h and included asm/percpu.h in the ia64 asm/topology.h,
making the definitions visible to linux/topology.h.

This reminds me that I should add to the patch description a 3rd item
required for an arch to use the generic percpu numa_node_id()
implementation:  make the percpu variable access interface visible via
asm/topology.h.

Does that sound reasonable?

Lee
