Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fmr23.intel.com ([143.183.121.15]:48268 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751447AbWCGTGJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Mar 2006 14:06:09 -0500
Date: Tue, 7 Mar 2006 11:06:07 -0800
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: Request for feedback on Generic Timeofday Subsystem (B20)
Message-ID: <20060307190607.GA31533@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05E1EDF8@scsmsx401.amr.corp.intel.com> <1141695346.11401.39.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141695346.11401.39.camel@cog.beaverton.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

John,

Thanks for the detailed reply.

On Mon, Mar 06, 2006 at 05:35:46PM -0800, john stultz wrote:
> I'd be interested in hearing more about specifically what ia64 has done
> (reading the fsyscall asm is not my idea of fun :)

It is at least heavily commented asm ... but yes, perhaps not the
most fun way to spend your time.  Essentially it just hooks into
the generic time interpolator code (but without actually calling
any of those functions due to restrictions on what fsyscall code
can do).

> hope is to join these divergent efforts to the benefit of all. This may
> sound a bit naive and wide-eyed, and I'm fine allowing for arch specific
> optimizations where they are necessary, but really, what are we doing in
> almost all cases? Reading some hardware, converting it to nanoseconds
> and adding it to a base value, all under a seq_read_lock.

Yes, that's pretty much what happens ... the only real complication
is that different h/w might require diferent access methods to read it.

>                                                           We don't need
> a dozen implementations of this, and it makes other features harder to
> implement because we don't know things like: Which arches will function
> if we disable interrupts for a bit? Or what is the hardware level
> resolution of clock_gettime()?

The fly in the ointment here is the restrictions on what can be done
inside the fsyscall handler (see Documentation/ia64/fsys.txt for the
gory details ... but the short form is that function calls are out,
so everything needs to be done, carefully, in assembler).

> The last time I generated numbers for i386 the patch hit gettimeofday()
> by ~2%, which was the worst case I could generate using the clocksource
> with the lowest overhead (TSC). Most of this was due to some extra u64
> usage and the lack of a generic mul_u64xu32 wrapper. However for this
> cost, you get correct behavior (which I think is *much* more important,
> at least for i386) and nanosecond resolution in clock_gettime().

Fast is indeed no use if the answer is wrong.  Performance of this
on ia64 would be totally dependent on whether we can hook into your
framework while staying within the restrictions of fsyscall code.

> Currently I suspect the impact its a bit worse with the patches in -mm,
> since cycle_t was set back to a u64 to be extra robust in the case of 2
> seconds of lost ticks. That's more of a -RT tree concern, so I'd be fine
> setting that back to a unsigned long for mainline.

With Xen (and other) virtualized environments, you may need to keep that
capability to handle 2 seconds of lost ticks.  I haven't seen any upper
bound for how long the hypervisor may starve a guest OS!

-Tony
