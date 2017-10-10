Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756200AbdJJJft (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Oct 2017 05:35:49 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com> <20171010001951.GA6476@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8078.1507628146.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Tue, 10 Oct 2017 10:35:46 +0100
Message-ID: <8079.1507628146@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
Message-ID: <20171010093546.1NjLX9eLNpdRO9aIZvCS3ceCf03jZZROv2SBmKg0bGI@z>

Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

>  static inline void *assoc_array_ptr_to_leaf(const struct assoc_array_ptr *x)
>  {
> -	return (void *)((unsigned long)x & ~ASSOC_ARRAY_PTR_TYPE_MASK);
> +	return (void *)((unsigned long)READ_ONCE(x) & /* Address dependency. */
> +		~ASSOC_ARRAY_PTR_TYPE_MASK);
>  }

This is the wrong place to do this.  assoc_array_ptr_to_leaf() is effectively
no more than a special cast; it removes a metadata bit from a pointer.  x is
the value we're modifying, not *x, and x was read by the caller.

>  static inline
>  unsigned long __assoc_array_ptr_to_meta(const struct assoc_array_ptr *x)
>  {
> -	return (unsigned long)x &
> +	return (unsigned long)READ_ONCE(x) & /* Address dependency. */
>  		~(ASSOC_ARRAY_PTR_SUBTYPE_MASK | ASSOC_ARRAY_PTR_TYPE_MASK);
>  }

Ditto.

> -		ptr = READ_ONCE(node->slots[slot]);
> +		ptr = READ_ONCE(node->slots[slot]); /* Address dependency. */
>  		has_meta |= (unsigned long)ptr;
>  		if (ptr && assoc_array_ptr_is_leaf(ptr)) {
> -			/* We need a barrier between the read of the pointer
> -			 * and dereferencing the pointer - but only if we are
> -			 * actually going to dereference it.
> -			 */
> -			smp_read_barrier_depends();
> -

For example, you can see the READ_ONCE() here; that is already done.

Can you also not just delete the comment, but rephrase it to indicate that a
barrier is necessary and it's done by READ_ONCE(), please?

David
