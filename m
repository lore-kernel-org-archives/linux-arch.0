From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: subtle side effect of commit a1c48bb160f836
Date: Thu, 18 Jun 2015 14:46:33 +0530
Message-ID: <55828C71.5060800@synopsys.com>
References: <55826966.6050202@synopsys.com>	<CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com>	<20150618081329.GA9434@pobox.suse.cz>	<55828527.8050901@synopsys.com> <CAMuHMdWZuz+x=A6h5Nt9DXAdf6x=MWg=su3smWoZd3GmOJxXKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58856 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbbFRJRP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jun 2015 05:17:15 -0400
In-Reply-To: <CAMuHMdWZuz+x=A6h5Nt9DXAdf6x=MWg=su3smWoZd3GmOJxXKA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>
Cc: Michal Marek <mmarek@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

+CC Claudiu - ARC gcc guru

On Thursday 18 June 2015 02:25 PM, Geert Uytterhoeven wrote:
> Hi Vineet,
> 
> On Thu, Jun 18, 2015 at 10:45 AM, Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
>> On Thursday 18 June 2015 01:43 PM, Michal Marek wrote:
>>>>> Alternatively, as we already have CONFIG_CC_OPTIMIZE_FOR_SIZE,
>>>>> a(nother) Kconfig option may make sense.
>>> We can also introduce some ARCH_CFLAGS that is appended near the end of
>>> the list, and have arc/Makefile add its -O3 there. But I'd like to why
>>> the -O3 needs to be there in first place.
>>
>> This is how historically ARC kernels have been built. We do track performance
>> results LMBench/hackbench... and going from -O3 to -O2 caused a sudden dip in some
>> of the numbers when we measured 3.18 (vs. 3.13)
>>
>>> Obviously, the kernel works
>>> with -O2, otherwise the regression would have been identified earlier.
>>
>> Its a performance thing - so yeah -O2 works, but -O3 works even better :-)
> 
> Did you see some numbers increase when going from -O3 to -O2?
> IIRC, -O3 enables more aggressive inlining, which can cause more L1 cache
> misses.

It sure does but smaller functions could cause more stack return mispredicts etc.
It all boils down to the micro-arch in the end and how gcc does arch specific
things under the hood of -O{2,s}.


> It might be worth trying CONFIG_CC_OPTIMIZE_FOR_SIZE=y...

Not for ARC. At -Os gcc is more worried about using short instructions (2 bytes),
and things like alignment of target branches, ld/st scheduling might not be as
optim as with -O2/O3. Some of the code density instructions have associated
pipeline stalls etc.

So last time (it's been a while though) when I ran benchmarks with -Os on ARC, it
was way off vs. -O2.
