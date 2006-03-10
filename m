Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:5846 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422678AbWCJBPR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2006 20:15:17 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2A1FH0J015210
	for <linux-arch@vger.kernel.org>; Thu, 9 Mar 2006 20:15:17 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2A1CWBe265806
	for <linux-arch@vger.kernel.org>; Thu, 9 Mar 2006 18:12:32 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2A1FGog006535
	for <linux-arch@vger.kernel.org>; Thu, 9 Mar 2006 18:15:16 -0700
Subject: RE: Request for feedback on Generic Timeofday Subsystem (B20)
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <1141695346.11401.39.camel@cog.beaverton.ibm.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05E1EDF8@scsmsx401.amr.corp.intel.com>
	 <1141695346.11401.39.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 17:15:14 -0800
Message-Id: <1141953314.20123.110.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-03-06 at 17:35 -0800, john stultz wrote:
> The last time I generated numbers for i386 the patch hit gettimeofday()
> by ~2%, which was the worst case I could generate using the clocksource
> with the lowest overhead (TSC). Most of this was due to some extra u64
> usage and the lack of a generic mul_u64xu32 wrapper. However for this
> cost, you get correct behavior (which I think is *much* more important,
> at least for i386) and nanosecond resolution in clock_gettime().


Ok, so here are some rough numbers calling the various time interfaces
all using the fastest clocksource available (TSC) for timekeeping to
give the best code vs code comparison.


On my p4m laptop w/ idle=poll and clocksource/clock=tsc

					mainline vs TOD
gettimeofday():				106.5%
clock_gettime(CLOCK_MONOTONIC):		99.1%
clock_gettime(CLOCK_REALTIME):		100.1%

So, 6% hit on gtod, the trade off being more robust timekeeping and you
get nanosecond res from clock_gettime for free.


Again, on my laptop w/ idle=poll and clocksource/clock=tsc + minor
performance tweaks of moving cycle_t back to a unsigned long.

					mainline vs TOD
gettimeofday():				103.3%
clock_gettime(CLOCK_MONOTONIC):		98.2%
clock_gettime(CLOCK_REALTIME):		99.0%

Getting closer to calling it a wash.


On an x86-64 AMD server using nopmtimer/clocksource=tsc:
					mainline vs TOD
gettimeofday():				74.2%
clock_gettime(CLOCK_MONOTONIC):		77.4%
clock_gettime(CLOCK_REALTIME):		71.6%

Hmmmm. I'm heading out of town for the weekend in a few moments, and I'd
really like to re-verify those numbers, but yea, that's a 25%
improvement. Might be too good to be true, but that should get Andi's
attention :)

thanks
-john


