From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: subtle side effect of commit a1c48bb160f836
Date: Thu, 18 Jun 2015 13:03:01 +0530
Message-ID: <5582742D.9090206@synopsys.com>
References: <55826966.6050202@synopsys.com> <CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:39389 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751867AbbFRHdd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jun 2015 03:33:33 -0400
In-Reply-To: <CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Marek <mmarek@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Thursday 18 June 2015 12:40 PM, Geert Uytterhoeven wrote:
> On Thu, Jun 18, 2015 at 8:47 AM, Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
>> > commit a1c48bb160f8368 "Makefile: Fix unrecognized cross-compiler command line
>> > options" moved ARCH specific cc option handling before common -Os/O2 setup.
>> >
>> > For ARC this had a subtle effect that we can no longer over-ride generic -O2 with
>> > -O3, hence a performance regression observed going from 3.13 to 3.18 (the above
>> > commit went into 3.16)
>> >
>> > I want to understand how to properly fix this. Moving the include of arch makefile
>> > will bring back the old issue. I can introduce another option to set default optim
>> > level, but only arc/m32r care about it anyways.
> Can we include $(srctree)/arch/$(SRCARCH)/Makefile twice?

Something like this would be ideal, but does that not bring back your warnings ?

> 
> Or perhaps we can not apply the extra -O* if there's already a -O* option?

Could be, but I'm not sure how to do that ?


> Alternatively, as we already have CONFIG_CC_OPTIMIZE_FOR_SIZE,
> a(nother) Kconfig option may make sense.

I can cook this one - but is it really worth doing when only 2 arches care.

Michal, do you have any opinion on how to solve this ?

-Vineet
