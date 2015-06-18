Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58294 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbbFRIqF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jun 2015 04:46:05 -0400
Message-ID: <55828527.8050901@synopsys.com>
Date: Thu, 18 Jun 2015 14:15:27 +0530
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
MIME-Version: 1.0
Subject: Re: subtle side effect of commit a1c48bb160f836
References: <55826966.6050202@synopsys.com> <CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com> <20150618081329.GA9434@pobox.suse.cz>
In-Reply-To: <20150618081329.GA9434@pobox.suse.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Message-ID: <20150618084527.4icOP3ozQEP1oNrqDHS1oJ35OSVhs4SJiIVTVTp7FFg@z>

On Thursday 18 June 2015 01:43 PM, Michal Marek wrote:
>> > Alternatively, as we already have CONFIG_CC_OPTIMIZE_FOR_SIZE,
>> > a(nother) Kconfig option may make sense.
> We can also introduce some ARCH_CFLAGS that is appended near the end of
> the list, and have arc/Makefile add its -O3 there. But I'd like to why
> the -O3 needs to be there in first place. 

This is how historically ARC kernels have been built. We do track performance
results LMBench/hackbench... and going from -O3 to -O2 caused a sudden dip in some
of the numbers when we measured 3.18 (vs. 3.13)

> Obviously, the kernel works
> with -O2, otherwise the regression would have been identified earlier.

Its a performance thing - so yeah -O2 works, but -O3 works even better :-)

> So why can't users specify -O3 in KCFLAGS like on any other
> architecture.

Sweet, I didn't know about this. But I don't see any arch setting this - only tile
using it. So yeah - below does the trick !

--------->
