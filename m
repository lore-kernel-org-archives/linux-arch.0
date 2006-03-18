Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:32447 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751833AbWCRAfK
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Mar 2006 19:35:10 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2I0Z9jh016445
	for <linux-arch@vger.kernel.org>; Fri, 17 Mar 2006 19:35:09 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2I0WEAg219218
	for <linux-arch@vger.kernel.org>; Fri, 17 Mar 2006 17:32:14 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2I0Z9ki022190
	for <linux-arch@vger.kernel.org>; Fri, 17 Mar 2006 17:35:09 -0700
Subject: Re: Request for feedback on Generic Timeofday Subsystem (B20)
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <200603091918.01155.ak@suse.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05E1EDF8@scsmsx401.amr.corp.intel.com>
	 <1141695346.11401.39.camel@cog.beaverton.ibm.com>
	 <1141953314.20123.110.camel@cog.beaverton.ibm.com>
	 <200603091918.01155.ak@suse.de>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 16:35:07 -0800
Message-Id: <1142642108.2885.37.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2006-03-09 at 19:18 +0100, Andi Kleen wrote:
> On Friday 10 March 2006 02:15, john stultz wrote:
> 
> > On an x86-64 AMD server using nopmtimer/clocksource=tsc:
> > 					mainline vs TOD
> > gettimeofday():				74.2%
> > clock_gettime(CLOCK_MONOTONIC):		77.4%
> > clock_gettime(CLOCK_REALTIME):		71.6%
> > 
> > Hmmmm. I'm heading out of town for the weekend in a few moments, and I'd
> > really like to re-verify those numbers, but yea, that's a 25%
> > improvement. Might be too good to be true, but that should get Andi's
> > attention :)
> 
> What is clocksource=tsc? It doesn't exist on 64bit kernels. 

Its part of the new clocksource infrastructure, which is arch generic.


> And clock_gettime uses a completely different path from gettimeofday so if they 
> have the same percentage your results look somewhat suspicious.

Yea, It was too good to be true. I went back to confirm the numbers and
realized there were config differences. Using the same config didn't
give such interesting results, but I haven't had a chance to look into
it any closer. I've been busy reworking the patches (watch for them
later tonight) to try to achieve a more evolutionary approach as you
suggested. Once I get x86-64 back up and running I'll get some more hard
numbers for you to look at.

Sorry for the sensationalism.  :)
-john

