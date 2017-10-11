From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 13:22:17 +0100
Message-ID: <20171011122217.GD11106@arm.com>
References: <20171010155042.GD3521@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59888 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752007AbdJKMWO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 08:22:14 -0400
Content-Disposition: inline
In-Reply-To: <26455.1507724399@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>

On Wed, Oct 11, 2017 at 01:19:59PM +0100, David Howells wrote:
> Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > -	node = result.terminal_node.node;
> > -	smp_read_barrier_depends();
> > +	node = READ_ONCE(result.terminal_node.node); /* Address dependency. */
> 
> The main problem I have with this method of annotation is that it's not
> obvious there's a barrier there or which side the barrier is.
> 
> I think one of the trickiest issues is that a barrier is typically between two
> things and we're not making it clear what those two things actually are.
> 
> Also, I would say that the most natural interpretation of READ_ONCE() is that
> the implicit barrier comes after the read, e.g.:
> 
> 	f = READ_ONCE(stuff->foo);
> 	/* Implied barrier */
> 	look_at(f->a);
> 	look_at(f->b);
> 
> I.e. READ_ONCE() prevents stuff->foo from being reread whilst you access f and
> orders LOAD(stuff->foo) before LOAD(f->a) and LOAD(f->b).

FWIW, that's exactly what my patches do, this fixup looks a bit weird
because it removes a prior barrier which suggests that either (a) it's in
the wrong place to start with, or (b) we're annotating the wrong load.

Will
