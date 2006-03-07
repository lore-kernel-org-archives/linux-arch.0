Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:5005 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751261AbWCGBft (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2006 20:35:49 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k271ZmVc006820
	for <linux-arch@vger.kernel.org>; Mon, 6 Mar 2006 20:35:48 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k271cbSr175340
	for <linux-arch@vger.kernel.org>; Mon, 6 Mar 2006 18:38:37 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k271ZmDd005310
	for <linux-arch@vger.kernel.org>; Mon, 6 Mar 2006 18:35:48 -0700
Subject: RE: Request for feedback on Generic Timeofday Subsystem (B20)
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F05E1EDF8@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05E1EDF8@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 17:35:46 -0800
Message-Id: <1141695346.11401.39.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-03-06 at 12:15 -0800, Luck, Tony wrote: 
> > Why do we need this?
> >
> > Correctness: ...
> > Consolidation: ...
> 
> Any performance measurements?  ia64 has gone to some lengths to
> ensure that gettimeofday(2) has a very low overhead (it does
> show up in the kernel profiles of some benchmarks ... managed
> runtime systems in particular, but others like to get timestamps
> at quite frighteningly short intervals).  So I'm interested in
> smp cases where are moderate number of cpus (4-16) are pounding
> on gettimeofday().  I think that the huge SMP systems running
> HPC workloads spend less of their time asking what time it is,
> so I'm not as worried about the 512 cpu ... but if all 512 cpus
> do happen to call gettimeofday() at the same time the system
> shouldn't sink into the swamp as cache-lines bounce around.

This is a good question, as I haven't run much in the way of performance
measurements recently. More below on that.

I'd be interested in hearing more about specifically what ia64 has done
(reading the fsyscall asm is not my idea of fun :), but I'd like to
think that generally it shouldn't be an issue. First of all, the
infrastructure is there for arch specific optimizations like
VDSO/vsyscall implementations (or fsyscall on ia64). In fact, it makes
it much easier to implement the vsyscall feature on arches that do not
yet support it (I have a patch for i386 that was pretty straight
forward, although I still need to sort out the unwind bits for gdb). And
secondly, larger SMP systems (although PPC and SPARC are exceptions)
tend to require use of slower mmapped clocksources which tend to
dominate the gettimeofday() usage.

But part of the issue is that there are a number of arches that have
done their own arch specific optimizations that are for the most part,
generically applicable. This goes back to the consolidation point. My
hope is to join these divergent efforts to the benefit of all. This may
sound a bit naive and wide-eyed, and I'm fine allowing for arch specific
optimizations where they are necessary, but really, what are we doing in
almost all cases? Reading some hardware, converting it to nanoseconds
and adding it to a base value, all under a seq_read_lock. We don't need
a dozen implementations of this, and it makes other features harder to
implement because we don't know things like: Which arches will function
if we disable interrupts for a bit? Or what is the hardware level
resolution of clock_gettime()?


But back to the actual performance numbers: 

The last time I generated numbers for i386 the patch hit gettimeofday()
by ~2%, which was the worst case I could generate using the clocksource
with the lowest overhead (TSC). Most of this was due to some extra u64
usage and the lack of a generic mul_u64xu32 wrapper. However for this
cost, you get correct behavior (which I think is *much* more important,
at least for i386) and nanosecond resolution in clock_gettime().

Currently I suspect the impact its a bit worse with the patches in -mm,
since cycle_t was set back to a u64 to be extra robust in the case of 2
seconds of lost ticks. That's more of a -RT tree concern, so I'd be fine
setting that back to a unsigned long for mainline.

And while its not gettimeofday(), I'm working with Roman on further
reducing the overhead in the periodic_hook() accumulation function, so
there is less periodic overhead as well.

I'll try to generate some more numbers and put some more focus on the
performance aspect of the current patches. If anyone does get a chance
to look the code over in detail, please do point out any specific
concerns or ideas for improvements.  

thanks
-john

