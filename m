From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: subtle side effect of commit a1c48bb160f836
Date: Thu, 18 Jun 2015 10:55:21 +0200
Message-ID: <CAMuHMdWZuz+x=A6h5Nt9DXAdf6x=MWg=su3smWoZd3GmOJxXKA@mail.gmail.com>
References: <55826966.6050202@synopsys.com>
	<CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com>
	<20150618081329.GA9434@pobox.suse.cz>
	<55828527.8050901@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55828527.8050901@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Michal Marek <mmarek@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Vineet,

On Thu, Jun 18, 2015 at 10:45 AM, Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
> On Thursday 18 June 2015 01:43 PM, Michal Marek wrote:
>>> > Alternatively, as we already have CONFIG_CC_OPTIMIZE_FOR_SIZE,
>>> > a(nother) Kconfig option may make sense.
>> We can also introduce some ARCH_CFLAGS that is appended near the end of
>> the list, and have arc/Makefile add its -O3 there. But I'd like to why
>> the -O3 needs to be there in first place.
>
> This is how historically ARC kernels have been built. We do track performance
> results LMBench/hackbench... and going from -O3 to -O2 caused a sudden dip in some
> of the numbers when we measured 3.18 (vs. 3.13)
>
>> Obviously, the kernel works
>> with -O2, otherwise the regression would have been identified earlier.
>
> Its a performance thing - so yeah -O2 works, but -O3 works even better :-)

Did you see some numbers increase when going from -O3 to -O2?
IIRC, -O3 enables more aggressive inlining, which can cause more L1 cache
misses.

It might be worth trying CONFIG_CC_OPTIMIZE_FOR_SIZE=y...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
