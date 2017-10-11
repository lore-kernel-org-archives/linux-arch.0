Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751958AbdJKMUC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Oct 2017 08:20:02 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20171010155042.GD3521@linux.vnet.ibm.com>
References: <20171010155042.GD3521@linux.vnet.ibm.com> <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com> <20171010001951.GA6476@linux.vnet.ibm.com> <8079.1507628146@warthog.procyon.org.uk>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove smp_read_barrier_depends()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26454.1507724399.1@warthog.procyon.org.uk>
Date: Wed, 11 Oct 2017 13:19:59 +0100
Message-ID: <26455.1507724399@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
Message-ID: <20171011121959.37GNWE38RE-yDp6KI2Ou8IZwYb9kgAuQlSDwsjgqeM8@z>

Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> -	node = result.terminal_node.node;
> -	smp_read_barrier_depends();
> +	node = READ_ONCE(result.terminal_node.node); /* Address dependency. */

The main problem I have with this method of annotation is that it's not
obvious there's a barrier there or which side the barrier is.

I think one of the trickiest issues is that a barrier is typically between two
things and we're not making it clear what those two things actually are.

Also, I would say that the most natural interpretation of READ_ONCE() is that
the implicit barrier comes after the read, e.g.:

	f = READ_ONCE(stuff->foo);
	/* Implied barrier */
	look_at(f->a);
	look_at(f->b);

I.e. READ_ONCE() prevents stuff->foo from being reread whilst you access f and
orders LOAD(stuff->foo) before LOAD(f->a) and LOAD(f->b).

David
