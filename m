From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] perf: Optimize perf_output_begin() -- weaker memory
 barrier
Date: Fri, 8 Nov 2013 08:21:45 +0100
Message-ID: <20131108072145.GD19203@twins.programming.kicks-ass.net>
References: <20131107220314.740353088@infradead.org>
 <20131107221254.293322441@infradead.org>
 <20131107211617.GD27329@Krystal>
 <20131108021928.GZ18245@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43806 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab3KHHWc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2013 02:22:32 -0500
Content-Disposition: inline
In-Reply-To: <20131108021928.GZ18245@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-arch@vger.kernel.org, geert@linux-m68k.org, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com

On Thu, Nov 07, 2013 at 06:19:28PM -0800, Paul E. McKenney wrote:
> On Thu, Nov 07, 2013 at 04:16:17PM -0500, Mathieu Desnoyers wrote:
> > * peterz@infradead.org (peterz@infradead.org) wrote:
> > >  	 *   WRITE $data			READ $data
> > > -	 *   smp_wmb()	(B)			smp_mb()	(D)
> > > -	 *   STORE ->data_head			WRITE ->data_tail
> > > +	 *   STORE.rel ->data_head (B)		WRITE.rel ->data_tail (D)
> > 
> > You might want to choose either STORE or WRITE for consistency.

For some reason Mathieu's email never made it to my inbox... weird.

But yes! I actually noticed that at one point and thought I should fix
that, clearly I forgot.
