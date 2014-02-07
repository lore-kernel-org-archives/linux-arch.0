From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 3/5] arch:
 s/smp_mb__(before|after)_(atomic|clear)_(dec,inc,bit)/smp_mb__\1/g
Date: Fri, 7 Feb 2014 09:52:41 +0000
Message-ID: <20140207095241.GA5976@mudshark.cambridge.arm.com>
References: <20140206134825.305510953@infradead.org>
 <20140206135001.180858022@infradead.org>
 <20140206191204.GG4250@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55882 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751333AbaBGJxN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Feb 2014 04:53:13 -0500
Content-Disposition: inline
In-Reply-To: <20140206191204.GG4250@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>

On Thu, Feb 06, 2014 at 07:12:04PM +0000, Paul E. McKenney wrote:
> On Thu, Feb 06, 2014 at 02:48:28PM +0100, Peter Zijlstra wrote:
> > Because atomic ops are implemented the same across an architecture,
> > the current incomplete set of extra barriers:
> >
> >   smp_mb__before_atomic_inc()
> >   smp_mb__after_atomic_inc()
> >   smp_mb__before_atomic_dec()
> >   smp_mb__after_atomic_dec()
> >   smp_mb__before_clear_bit()
> >   smp_mb__after_clear_bit()
> >
> > is both incomplete and superfluous.
> >
> > It is incomplete because there are far more atomic operations that do
> > not return values -- such as atomic_add(), set_bit() etc. And it is
> > superfluous because they're all the same anyway.
> >
> > Simplify things by reducing the triplicate set into a single set of
> > barriers that is valid for all void atomic ops:
> >
> >   smp_mb__before_atomic()
> >   smp_mb__after_atomic()
> >
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> 
> I very much like the API shrinkage.  The RCU changes are good, and
> I believe that the rest is OK too, though my eyes were going a bit
> buggy towards the end...
> 
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

... and the arm[64] parts look fine to me.

  Acked-by: Will Deacon <will.deacon@arm.com>

Usual comment about upcoming conflicts :)

Will
