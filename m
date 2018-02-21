Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34094 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1753438AbeBUSih (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2018 13:38:37 -0500
Date: Wed, 21 Feb 2018 13:38:35 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S lock-based
 external-view litmus test
In-Reply-To: <20180221175320.GI3617@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1802211334560.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com

On Wed, 21 Feb 2018, Paul E. McKenney wrote:

> On Wed, Feb 21, 2018 at 11:50:31AM -0500, Alan Stern wrote:
> > On Wed, 21 Feb 2018, Paul E. McKenney wrote:
> > 
> > > On Wed, Feb 21, 2018 at 10:09:00AM -0500, Alan Stern wrote:
> > > > On Tue, 20 Feb 2018, Paul E. McKenney wrote:
> > > > 
> > > > > From: Alan Stern <stern@rowland.harvard.edu>
> > > > > 
> > > > > This commit adds a litmus test in which P0() and P1() form a lock-based S
> > > > > litmus test, with the addition of P2(), which observes P0()'s and P1()'s
> > > > 
> > > > Why do you call this an "S" litmus test?  Isn't ISA2 a better 
> > > > description?
> > > 
> > > Indeed, the name of the test is in fact ISA2.
> > 
> > Sure; and the Changelog entry should reflect this.
> 
> No argument.

> ------------------------------------------------------------------------
> 
> commit e6658d1d7fcc6391f3d00beaadc484243123a893
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Wed Feb 21 09:49:01 2018 -0800
> 
>     tools/memory-order: Add documentation of new litmus test
>     
>     The litmus-tests/README file lacked any mention of then litmus test

s/lacked/lacks/
s/then/the new/

>     named ISA2+pooncelock+pooncelock+pombonce.litmus.  This commit therefore

s/named //

>     adds this test.

It adds a description of the test, not the test itself.

>     
>     Reported-by: Alan Stern <stern@rowland.harvard.edu>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> index dca7d823ad57..aff3eb90e067 100644
> --- a/tools/memory-model/litmus-tests/README
> +++ b/tools/memory-model/litmus-tests/README
> @@ -32,6 +32,11 @@ IRIW+poonceonces+OnceOnce.litmus
>  	order of a pair of writes, where each write is to a different
>  	variable by a different process?
>  
> +ISA2+pooncelock+pooncelock+pombonce.litmus
> +	Tests whether the ordering provided by a lock-protected S litmus

Call it an ISA2 litmus test, not an S litmus test!

> +	test is visible to an external process whose accesses are
> +	separated by smp_mb().
> +
>  ISA2+poonceonces.litmus
>  	As below, but with store-release replaced with WRITE_ONCE()
>  	and load-acquire replaced with READ_ONCE().

Alan
