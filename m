Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fmr23.intel.com ([143.183.121.15]:26021 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S964824AbWCGWk3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Mar 2006 17:40:29 -0500
Date: Tue, 7 Mar 2006 14:40:28 -0800
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: Request for feedback on Generic Timeofday Subsystem (B20)
Message-ID: <20060307224028.GA31872@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05E1EDF8@scsmsx401.amr.corp.intel.com> <1141695346.11401.39.camel@cog.beaverton.ibm.com> <20060307190607.GA31533@agluck-lia64.sc.intel.com> <1141760224.21582.17.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141760224.21582.17.camel@leatherman>
Sender: linux-arch-owner@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> > The fly in the ointment here is the restrictions on what can be done
> > inside the fsyscall handler (see Documentation/ia64/fsys.txt for the
> > gory details ... but the short form is that function calls are out,
> > so everything needs to be done, carefully, in assembler).
> 
> So this was discussed at length early in the design phase w/ Christoph
> Lameter as a result the clocksource abstraction is intentionally similar
> to the time_interpolator structure. However, Ingo did not like exposing
> the access type and hardware pointers (which would allow the limited
> fsyscall asm code to access the hardware) inside the clocksource
> structure, so they were removed.
> 
> While if its a deal breaker, I'm ok with adding those raw access info
> back into the structure, I'd first ask why ia64 must use this very
> constrained fsyscall method instead of something more flexible where it
> doesn't have to be written in asm like vsyscall/VDSO which x86-64 and
> powerpc use? 
> 
> I don't know exactly the details of the fsyscall feature, but since
> vsyscalls are done completely in userspace, it might even be more
> efficient. Though let me know if that would not be the case.

fsyscall on ia64 makes use of the "epc" (enter privileged code) instruction
which (when placed in a page with a magic TLB attribute) will increase
privilege level without the overhead of a trap.  All the restrictions
on what can be done are there to keep the overhead as low as possible
(a "fast" system call path should after all be fast).  Some numbers
on haw fast: cold cache call to gettimeofday() ~700 cycles, hot cache
case ~160 cycles (on a 1.7GHz system).

I can't quite see how gettimeofday() can be correctly implemented
purely in userspace on a system where there is jitter in the clock source,
but I'm clueless about how vsyscall/VDSO works.

-Tony
