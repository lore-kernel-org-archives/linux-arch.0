Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:54665 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932150AbWCGTgw
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Mar 2006 14:36:52 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k27JaqIj000980
	for <linux-arch@vger.kernel.org>; Tue, 7 Mar 2006 14:36:52 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k27JdfLf143916
	for <linux-arch@vger.kernel.org>; Tue, 7 Mar 2006 12:39:41 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k27JapBL008116
	for <linux-arch@vger.kernel.org>; Tue, 7 Mar 2006 12:36:51 -0700
Subject: Re: Request for feedback on Generic Timeofday Subsystem (B20)
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <20060307190607.GA31533@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05E1EDF8@scsmsx401.amr.corp.intel.com>
	 <1141695346.11401.39.camel@cog.beaverton.ibm.com>
	 <20060307190607.GA31533@agluck-lia64.sc.intel.com>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 11:37:03 -0800
Message-Id: <1141760224.21582.17.camel@leatherman>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-03-07 at 11:06 -0800, Luck, Tony wrote:
> John,
> 
> Thanks for the detailed reply.
> 
> On Mon, Mar 06, 2006 at 05:35:46PM -0800, john stultz wrote:
> > I'd be interested in hearing more about specifically what ia64 has done
> > (reading the fsyscall asm is not my idea of fun :)
> 
> It is at least heavily commented asm ... but yes, perhaps not the
> most fun way to spend your time.  Essentially it just hooks into
> the generic time interpolator code (but without actually calling
> any of those functions due to restrictions on what fsyscall code
> can do).
> 
> > hope is to join these divergent efforts to the benefit of all. This may
> > sound a bit naive and wide-eyed, and I'm fine allowing for arch specific
> > optimizations where they are necessary, but really, what are we doing in
> > almost all cases? Reading some hardware, converting it to nanoseconds
> > and adding it to a base value, all under a seq_read_lock.
> 
> Yes, that's pretty much what happens ... the only real complication
> is that different h/w might require diferent access methods to read it.

Yes, and the clocksource abstraction provides the generic method to
access the hardware.


> >                                                           We don't need
> > a dozen implementations of this, and it makes other features harder to
> > implement because we don't know things like: Which arches will function
> > if we disable interrupts for a bit? Or what is the hardware level
> > resolution of clock_gettime()?
> 
> The fly in the ointment here is the restrictions on what can be done
> inside the fsyscall handler (see Documentation/ia64/fsys.txt for the
> gory details ... but the short form is that function calls are out,
> so everything needs to be done, carefully, in assembler).

So this was discussed at length early in the design phase w/ Christoph
Lameter as a result the clocksource abstraction is intentionally similar
to the time_interpolator structure. However, Ingo did not like exposing
the access type and hardware pointers (which would allow the limited
fsyscall asm code to access the hardware) inside the clocksource
structure, so they were removed.

While if its a deal breaker, I'm ok with adding those raw access info
back into the structure, I'd first ask why ia64 must use this very
constrained fsyscall method instead of something more flexible where it
doesn't have to be written in asm like vsyscall/VDSO which x86-64 and
powerpc use? 

I don't know exactly the details of the fsyscall feature, but since
vsyscalls are done completely in userspace, it might even be more
efficient. Though let me know if that would not be the case.


> > The last time I generated numbers for i386 the patch hit gettimeofday()
> > by ~2%, which was the worst case I could generate using the clocksource
> > with the lowest overhead (TSC). Most of this was due to some extra u64
> > usage and the lack of a generic mul_u64xu32 wrapper. However for this
> > cost, you get correct behavior (which I think is *much* more important,
> > at least for i386) and nanosecond resolution in clock_gettime().
> 
> Fast is indeed no use if the answer is wrong.  Performance of this
> on ia64 would be totally dependent on whether we can hook into your
> framework while staying within the restrictions of fsyscall code.
>
> > Currently I suspect the impact its a bit worse with the patches in -mm,
> > since cycle_t was set back to a u64 to be extra robust in the case of 2
> > seconds of lost ticks. That's more of a -RT tree concern, so I'd be fine
> > setting that back to a unsigned long for mainline.
> 
> With Xen (and other) virtualized environments, you may need to keep that
> capability to handle 2 seconds of lost ticks.  I haven't seen any upper
> bound for how long the hypervisor may starve a guest OS!

Well, I know some clock sources like the ACPI PM timer wrap every 5
seconds, so in that case Xen guests might need some lower frequency
virtualized clocksource driver which wouldn't be too hard to implement
and would keep any complications out of the common code.

thanks
-john


