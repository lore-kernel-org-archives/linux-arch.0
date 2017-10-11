From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Wed, 11 Oct 2017 05:58:57 -0700
Message-ID: <20171011125857.GY3521@linux.vnet.ibm.com>
References: <20171010155042.GD3521@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <26455.1507724399@warthog.procyon.org.uk>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <26455.1507724399@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
List-Id: linux-arch.vger.kernel.org

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

Placing the comment on the same line makes it less likely that some
later change will move the comment away from the load that it applies to.
Which appears to have happened on some of the other instances of
smp_read_barrier_depends() in other parts of the kernel.  It is not at
all clear what load they go with, or if that load is even still present
in the kernel.  :-/

							Thanx, Paul
