From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Sun, 7 Dec 2008 16:15:01 +1100
Message-ID: <18747.23509.977047.540995@cargo.ozlabs.ibm.com>
References: <20081204225345.654705757@linutronix.de>
	<18744.29747.728320.652642@cargo.ozlabs.ibm.com>
	<20081205063131.GB12785@elte.hu>
	<18744.56857.259756.129894@cargo.ozlabs.ibm.com>
	<20081205080813.GA2030@elte.hu>
	<18744.61429.548462.667020@cargo.ozlabs.ibm.com>
	<20081205120734.GA26244@elte.hu>
	<18745.49593.567217.277510@cargo.ozlabs.ibm.com>
	<1228566879.16244.4.camel@lappy.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:40151 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbYLGFPL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 7 Dec 2008 00:15:11 -0500
In-Reply-To: <1228566879.16244.4.camel@lappy.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Stephane Eranian <eranian@googlemail.com>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>

Peter Zijlstra writes:

> On Sat, 2008-12-06 at 11:05 +1100, Paul Mackerras wrote:
> > Now, the tables in perfmon's user-land libpfm that describe the
> > mapping from abstract events to event-selector values and the
> > constraints on what events can be counted together come to nearly
> > 29,000 lines of code just for the IBM 64-bit powerpc processors.
> > 
> > Your API condemns us to adding all that bloat to the kernel, plus the
> > code to use those tables.
> 
> Since you need those tables and that code anyway, and in a solid
> reliable way, what is the objection of carrying it in the kernel?

Because it's about 320kB of unpageable kernel memory, and it doesn't
need to be in the kernel.

The fundamental problem with Ingo and Thomas's proposal is that the
abstraction is at the wrong level.  It makes individual counters the
central idea, when the central idea should be a set of counters that
all start and stop counting at the same times.  People doing
performance analysis want to be able to compare counts of different
events and get ratios, and you can't do that meaningfully if the
counts correspond to different stretches of code.

Once you make the abstraction a set of counters, then you also make it
possible to have a counter-set that is the whole PMU.  Then you don't
have to have the kernel knowing all the possible settings for the PMU;
it only needs to know the simple ones, and if you want to do something
more sophisticated, you can have userspace specifying the bits to
select the more sophisticated setting.

> Furthermore, is there a good technical reason these cpus are so
> complicated to use?

That question is a bit ambiguous.  If you mean, why did the hardware
designers make it so complex? then I don't really know, but it doesn't
matter because the CPU hardware is what it is.  At best I might be
able to influence future designs to be a bit simpler.

If you mean, could the software description of the hardware be
simpler? then maybe - I'm just reading up on the details of the
hardware, and it is pretty complex, with multiple layers of
multiplexers and event buses.

Paul.
