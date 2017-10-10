From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
Date: Tue, 10 Oct 2017 10:59:39 +0100
Message-ID: <8368.1507629579@warthog.procyon.org.uk>
References: <8079.1507628146@warthog.procyon.org.uk> <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com> <20171010001951.GA6476@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755563AbdJJJ7m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Oct 2017 05:59:42 -0400
In-Reply-To: <8079.1507628146@warthog.procyon.org.uk>
Content-ID: <8367.1507629579.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>

David Howells <dhowells@redhat.com> wrote:

> Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> >  static inline void *assoc_array_ptr_to_leaf(const struct assoc_array_ptr *x)
> >  {
> > -	return (void *)((unsigned long)x & ~ASSOC_ARRAY_PTR_TYPE_MASK);
> > +	return (void *)((unsigned long)READ_ONCE(x) & /* Address dependency. */
> > +		~ASSOC_ARRAY_PTR_TYPE_MASK);
> >  }
> 
> This is the wrong place to do this.  assoc_array_ptr_to_leaf() is effectively
> no more than a special cast; it removes a metadata bit from a pointer.  x is
> the value we're modifying, not *x, and x was read by the caller.

Also, x is not a pointer you can read from, so if READ_ONCE(x) ever effects a
memory access, you might get an oops.

David
