Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269128AbUIAARJ@vger.kernel.org>
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:26463 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264299AbUIAAQ0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 Aug 2004 20:16:26 -0400
Message-ID: <413514D0.2020308@yahoo.com.au>
Date: Wed, 01 Sep 2004 10:16:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: domain setup in 2.6.9rc1-bk6
References: <m3llfvk4vh.fsf@averell.firstfloor.org> <20040831100924.GI26072@krispykreme> <20040831113328.GA11830@wotan.suse.de>
In-Reply-To: <20040831113328.GA11830@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: Anton Blanchard <anton@samba.org>, Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen wrote:
> On Tue, Aug 31, 2004 at 08:09:24PM +1000, Anton Blanchard wrote:
> 
>>>Problem is that I need a architecture specific hook to 
>>>turn off SMT idle for AMD dual core CPUs, which otherwise
>>>look like SMT siblings. I suppose I will do more tunings
>>>in this area in the future anyways, so having it in the 
>>>architecture would be better.
>>
>>From a ppc64 perspective I liked the merging of the domains code.
>>
>>We could have the ability to override generic domain setup per
>>architecture but leave all the default stuff in there.
> 
> 
> Currently all I want is to disable SD_SHARE_POWER when one flag 
> is set. A simple way to do this would be appreciated.
> 

You can define ARCH_HAS_SCHED_TUNE, and define your own
SD_SIBLING_INIT, SD_CPU_INIT, SD_NODE_INIT. Also, you just
need to define a cpu_sibling_map in order to use CONFIG_SCHED_SMT.

> Later overriding would be fine. A simple way to do this would
> be to declare it weak.
> 

Ingo preferred to do it this way. I can't say I blame him because
the setup code is not exactly something trivial that you want
duplicated everywhere (although it is now much improved).

It would be simple enough to just re-export it to the arch code,
however I guess I agree with tackling that when the need arises.

I think it may not be *too* difficult to even come up with a
decent API to handle more arbitrary setups now. Definitely let
me know when you run into a limitation, and I'll be interested in
fixing it.

Thanks
Nick
