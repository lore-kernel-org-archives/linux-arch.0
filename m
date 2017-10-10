From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Tue, 10 Oct 2017 09:05:23 -0700
Message-ID: <20171010160523.GH3521@linux.vnet.ibm.com>
References: <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010001951.GA6476@linux.vnet.ibm.com>
 <8079.1507628146@warthog.procyon.org.uk>
 <20171010155042.GD3521@linux.vnet.ibm.com>
 <20171010155451.wv2dfirmra5aeake@hirez.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171010155451.wv2dfirmra5aeake@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 10, 2017 at 05:54:51PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 10, 2017 at 08:50:42AM -0700, Paul E. McKenney wrote:
> > +			/* We need a barrier between the read of the pointer,
> > +			 * which is supplied by the above READ_ONCE().
> >  			 */
> 
> >  			/* We need a barrier between the read of the pointer
> >  			 * and dereferencing the pointer - but only if we are
> >  			 * actually going to dereference it.
> >  			 */
> 
> Could you also fix those "disgusting drug-induced crap" comment styles
> while you're there anyway?
> 
>   http://lkml.iu.edu/hypermail/linux/kernel/1607.1/00627.html

If Dave is OK with it, I will do so on my next pass.

							Thanx, Paul
