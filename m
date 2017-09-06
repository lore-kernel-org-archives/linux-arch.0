From: Rob Herring <robh@kernel.org>
Subject: Re: Setting CPU clock frequency on early boot
Date: Wed, 6 Sep 2017 10:25:37 -0500
Message-ID: <CAL_Jsq+B74keQ3N=8x6jx1URkLq8fa9gwsc5JAuiV86Wwczi9Q@mail.gmail.com>
References: <1504625867.32565.34.camel@synopsys.com> <CAL_JsqJ7c-raBnb0U+hL+hka7zN3XosX0pU1Sswoq16nbRFb+g@mail.gmail.com>
 <b8f7f407-303a-2f3c-1a16-bfb385204930@synopsys.com> <1504705881.3829.19.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932826AbdIFPZ7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 Sep 2017 11:25:59 -0400
In-Reply-To: <1504705881.3829.19.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>

On Wed, Sep 6, 2017 at 8:51 AM, Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
> Hi Vineet, Rob,
>
> On Tue, 2017-09-05 at 16:40 -0700, Vineet Gupta wrote:
>> On 09/05/2017 03:04 PM, Rob Herring wrote:
>> >
>> > On Tue, Sep 5, 2017 at 10:37 AM, Alexey Brodkin
>> > <Alexey.Brodkin@synopsys.com> wrote:
>> > >
>> > > Hello,
>> > >
>> > > I'd like to get some feedback on our idea as well as check
>> > > if somebody faces similar situations and if so what would be the best
>> > > way to implement some generic solution that suits everyone.
>> > >
>> > > So that's our problem:
>> > > 1. On power-on hardware might start clocking CPU with either
>> > >     too high frequency (such that CPU may get stuck at some point)
>> > >     or too low frequency.
>> > >
>> > >     That all sounds stupid but let me elaborate a bit here.
>> > >     I'm talking about FPGA-based devboards firmware for which
>> > >     (here I mean just image loaded in FPGA with CPU implementation
>> > >     but not some software yet) might not be stable or be even experimental.
>> > >
>> > >     For example we may deal with dual-core or quad-core designs.
>> > >     Former might be OK running @100MHz and latter is only usable
>> > >     @75MHz and lower. The simplest solution might be to use some safe
>> > >     value before something like CPUfreq kicks in. But we don't yet have
>> > >     CPUfreq for ARC (we do plan to get it working sometime soon)
>>
>> But even if we had cpufreq driver going - I don't think it would be usable for
>> doing large freq switches, since in current implementations of SoCs (or fpga), the
>> clk/pll etc driving core (and all timers etc) are not fixed like say ARM. And as
>> discussed before (and pointed to by tglx), timer subsys can't tolerate (on
>> purpose) such large drifts.
>
> Essentially cpufreq only makes sense for "compatible" systems and unfortunately
> most of our current boards are not capable due to missing constant [decoupled from
> CPU frequency] clock source. But looking forward we are planning to improve on that
> so that hopefully even our FPGA-based boards will be usable with cpufreq.
>
>> > > which
>> > >     means simple change of CPU frequency once time-keeping infrastructure
>> > >     was brought-up is not an option... I.e. we'll end up with the system running
>> > >     much slower compared what could have been possible.
>> > >
>> > > 2. Up until now we used to do dirty hacks in early platform init code.
>> > >     Namely (see axs103_early_init() in arch/arc/plat-axs10x/axs10x.c):
>> > >      1) Read CPU's "clock-frequency" from .dtb (remember we're on very early
>> > >         boot stage still so no expanded DevTree yet exists).
>> > >      2) Check how many cores we have and which freq is usable
>> > >      3) Update PLL settings right in place if new freq != existing in PLL.
>> > >
>> > >     Even though it is proven to work but with more platforms in the pipeline
>> > >     we'll need to copy-paste pretty much the same stuff across all affected
>> > >     plats. Which is not nice.
>> > >
>> > >     Moreover back in the day we didn't have a proper clk driver for CPU's PLL.
>> > >     Thus acting on PLL registers right in place was the only thing we were able
>> > >     to do. Now with introduction of normal clk driver
>> > >     (see drivers/clk/axs10x/pll_clock.c in linux-next) we'd like to utilize
>> > >     it and have a cleaner and more universal solution to the problem.
>> > >
>> > >     That's how it could be done - https://urldefense.proofpoint.com/v2/url?u=http-3A__patchwork.ozlabs.org_patch_801240_&d=DwICAg&c=DPL6_X_6JkXF
>> > > x7AXWqB0tg&r=c14YS-cH-
>> > > kdhTOW89KozFhBtBJgs1zXscZojEZQ0THs&m=wuUcceY8Cz5EhVklWLAgj7RzU3rvpanujvQ3qTJK0Gw&s=N5IBjq_eCyOf_GRkZskzqGhczBPTbxLJW_MUfauKvuA&e=
>> > >     Basically in architecture's time_init() we check if there's explicitly
>> > >     specified "clock-frequency" parameter in cpu's node in Device Tree and
>> > >     if there's one we set it via just instantiated clk driver.
>> > The patch looks generally okay. I'd move all the logic to the clock
>> > driver unless perhaps how to set the cpu freq is defined by the
>> > architecture.
>
> Yeah, that's an interesting question. We may indeed move more smarts to the clock driver
> but:
>  1. We'll have duplicate code in different clock drivers. Even today that kind of clock
>     setup is applicable to AXS10x and HSDK platforms (and they use different clock drivers).

No, you could provide a common, shared function to call. Then each
platform can opt-in. If you can make something that applies to every
single platform now or in the future, then I'd put it in arch. If you
have plans to decouple the timer and cpu clocks, then sounds like you
can't.

IMO, if it's not part of the defined CPU architecture, then don't put
it in arch/. That's how we end up with multiple copies of the same
thing done arbitrarily different ways because few people look across
architectures.

>  2. Print out of CPU frequency which is used during boot process for us is important as well
>     especially during bring-up of new HW.
>
>  3. If there's no dedicated "clock-frequency" parameter in CPU node we won't
>     change anything so that non-affected platforms will live as they used to.
>
> That said IMHO proposed implementation is what we want to kep for now.
>
>> Also note that this code is using a new / adhoc DT binding cpu-freq in cou node to
>> do the override - is that acceptable ?

No, I meant to point that out.

> I think we'll switch to more common "clock-frequency" in the next respin.
> Indeed "cpu-freq" might be a bit misleading.

Ideally, you'd use the clock binding eventually. "clock-frequency" is
still allowed, but not both. You have to pick. Either you have simple
needs or you don't...

>
> Also FWIW one MIPS platform uses something similar
> (even though their property name is not standard but "mips-hpt-frequency"),
> see http://elixir.free-electrons.com/linux/latest/source/arch/mips/boot/dts/brcm/bcm3368.dtsi#L10
> http://elixir.free-electrons.com/linux/latest/source/arch/mips/bmips/setup.c#L141.

That's fine, but you need a good reason.

Rob
