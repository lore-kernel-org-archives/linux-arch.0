Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:34778 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964855AbWCGXBo
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Mar 2006 18:01:44 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k27N1hnW031160
	for <linux-arch@vger.kernel.org>; Tue, 7 Mar 2006 18:01:43 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k27Mx1v9269172
	for <linux-arch@vger.kernel.org>; Tue, 7 Mar 2006 15:59:01 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k27N1hFX014114
	for <linux-arch@vger.kernel.org>; Tue, 7 Mar 2006 16:01:43 -0700
Subject: Re: Request for feedback on Generic Timeofday Subsystem (B20)
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <20060307224028.GA31872@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05E1EDF8@scsmsx401.amr.corp.intel.com>
	 <1141695346.11401.39.camel@cog.beaverton.ibm.com>
	 <20060307190607.GA31533@agluck-lia64.sc.intel.com>
	 <1141760224.21582.17.camel@leatherman>
	 <20060307224028.GA31872@agluck-lia64.sc.intel.com>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 15:01:58 -0800
Message-Id: <1141772520.21582.36.camel@leatherman>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-03-07 at 14:40 -0800, Luck, Tony wrote:
> > While if its a deal breaker, I'm ok with adding those raw access info
> > back into the structure, I'd first ask why ia64 must use this very
> > constrained fsyscall method instead of something more flexible where it
> > doesn't have to be written in asm like vsyscall/VDSO which x86-64 and
> > powerpc use? 
>
> I can't quite see how gettimeofday() can be correctly implemented
> purely in userspace on a system where there is jitter in the clock source,
> but I'm clueless about how vsyscall/VDSO works.

You are right there. The jitter handling (if I recall, basically a
cmpxchg w/ the last read cycle value to be sure the clocksource doesn't
go backward) wouldn't be doable in userspace, but it seems that would
already be a pretty bad hit on performance. Is it not? And how many
systems actually use unsycned/jittery ITCs instead of alternative mmioed
clocksources?

Regardless, if its really a blocking issue, I'm not opposed to putting
the direct access methods back into the structure, or going with an
alternative solution to make these bits doable. Ingo might have a better
idea for this as well.

Do you have any other issues or questions?

thanks
-john




