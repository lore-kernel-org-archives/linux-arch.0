Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:28056 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752155AbWCJBpP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2006 20:45:15 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: Request for feedback on Generic Timeofday Subsystem (B20)
Date: Thu, 9 Mar 2006 19:18:00 +0100
References: <B8E391BBE9FE384DAA4C5C003888BE6F05E1EDF8@scsmsx401.amr.corp.intel.com> <1141695346.11401.39.camel@cog.beaverton.ibm.com> <1141953314.20123.110.camel@cog.beaverton.ibm.com>
In-Reply-To: <1141953314.20123.110.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603091918.01155.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 10 March 2006 02:15, john stultz wrote:

> On an x86-64 AMD server using nopmtimer/clocksource=tsc:
> 					mainline vs TOD
> gettimeofday():				74.2%
> clock_gettime(CLOCK_MONOTONIC):		77.4%
> clock_gettime(CLOCK_REALTIME):		71.6%
> 
> Hmmmm. I'm heading out of town for the weekend in a few moments, and I'd
> really like to re-verify those numbers, but yea, that's a 25%
> improvement. Might be too good to be true, but that should get Andi's
> attention :)

What is clocksource=tsc? It doesn't exist on 64bit kernels. And what are the absolute
numbers?

And clock_gettime uses a completely different path from gettimeofday so if they 
have the same percentage your results look somewhat suspicious.

-Andi
