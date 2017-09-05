From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Setting CPU clock frequency on early boot
Date: Tue, 5 Sep 2017 16:40:17 -0700
Message-ID: <b8f7f407-303a-2f3c-1a16-bfb385204930@synopsys.com>
References: <1504625867.32565.34.camel@synopsys.com>
 <CAL_JsqJ7c-raBnb0U+hL+hka7zN3XosX0pU1Sswoq16nbRFb+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJ7c-raBnb0U+hL+hka7zN3XosX0pU1Sswoq16nbRFb+g@mail.gmail.com>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 09/05/2017 03:04 PM, Rob Herring wrote:
> On Tue, Sep 5, 2017 at 10:37 AM, Alexey Brodkin
> <Alexey.Brodkin@synopsys.com> wrote:
>> Hello,
>>
>> I'd like to get some feedback on our idea as well as check
>> if somebody faces similar situations and if so what would be the best
>> way to implement some generic solution that suits everyone.
>>
>> So that's our problem:
>> 1. On power-on hardware might start clocking CPU with either
>>     too high frequency (such that CPU may get stuck at some point)
>>     or too low frequency.
>>
>>     That all sounds stupid but let me elaborate a bit here.
>>     I'm talking about FPGA-based devboards firmware for which
>>     (here I mean just image loaded in FPGA with CPU implementation
>>     but not some software yet) might not be stable or be even experimental.
>>
>>     For example we may deal with dual-core or quad-core designs.
>>     Former might be OK running @100MHz and latter is only usable
>>     @75MHz and lower. The simplest solution might be to use some safe
>>     value before something like CPUfreq kicks in. But we don't yet have
>>     CPUfreq for ARC (we do plan to get it working sometime soon)

But even if we had cpufreq driver going - I don't think it would be usable for 
doing large freq switches, since in current implementations of SoCs (or fpga), the 
clk/pll etc driving core (and all timers etc) are not fixed like say ARM. And as 
discussed before (and pointed to by tglx), timer subsys can't tolerate (on 
purpose) such large drifts.

>> which
>>     means simple change of CPU frequency once time-keeping infrastructure
>>     was brought-up is not an option... I.e. we'll end up with the system running
>>     much slower compared what could have been possible.
>>
>> 2. Up until now we used to do dirty hacks in early platform init code.
>>     Namely (see axs103_early_init() in arch/arc/plat-axs10x/axs10x.c):
>>      1) Read CPU's "clock-frequency" from .dtb (remember we're on very early
>>         boot stage still so no expanded DevTree yet exists).
>>      2) Check how many cores we have and which freq is usable
>>      3) Update PLL settings right in place if new freq != existing in PLL.
>>
>>     Even though it is proven to work but with more platforms in the pipeline
>>     we'll need to copy-paste pretty much the same stuff across all affected
>>     plats. Which is not nice.
>>
>>     Moreover back in the day we didn't have a proper clk driver for CPU's PLL.
>>     Thus acting on PLL registers right in place was the only thing we were able
>>     to do. Now with introduction of normal clk driver
>>     (see drivers/clk/axs10x/pll_clock.c in linux-next) we'd like to utilize
>>     it and have a cleaner and more universal solution to the problem.
>>
>>     That's how it could be done - https://urldefense.proofpoint.com/v2/url?u=http-3A__patchwork.ozlabs.org_patch_801240_&d=DwICAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=c14YS-cH-kdhTOW89KozFhBtBJgs1zXscZojEZQ0THs&m=wuUcceY8Cz5EhVklWLAgj7RzU3rvpanujvQ3qTJK0Gw&s=N5IBjq_eCyOf_GRkZskzqGhczBPTbxLJW_MUfauKvuA&e=
>>     Basically in architecture's time_init() we check if there's explicitly
>>     specified "clock-frequency" parameter in cpu's node in Device Tree and
>>     if there's one we set it via just instantiated clk driver.
> The patch looks generally okay. I'd move all the logic to the clock
> driver unless perhaps how to set the cpu freq is defined by the
> architecture.

But the above patch is clk driver agnostic and it would have to be added each clk 
driver (axs10x, hsdk - both in linux-next) ?
Also note that this code is using a new / adhoc DT binding cpu-freq in cou node to 
do the override - is that acceptable ?

-Vineet

>
>> We may indeed proceed with mentioned solution for ARC but if that makes
>> sense for somebody else it might worth getting something similar in generic
>> init code. Any thoughts?
> If any ARM platforms are doing something similar, then it's done in
> their clock driver via of_clk_init. Or they just wait for cpufreq to
> kick in and expect the bootloader has initialized things to a
> reasonable frequency.

