From: Rob Herring <robh@kernel.org>
Subject: Re: Setting CPU clock frequency on early boot
Date: Wed, 6 Sep 2017 14:20:04 -0500
Message-ID: <CAL_Jsq+oBVeZ9FrvCZsVWyQjTiFw=mujf-p64oLEEo4XYkdmVQ@mail.gmail.com>
References: <1504625867.32565.34.camel@synopsys.com> <CAL_JsqJ7c-raBnb0U+hL+hka7zN3XosX0pU1Sswoq16nbRFb+g@mail.gmail.com>
 <b8f7f407-303a-2f3c-1a16-bfb385204930@synopsys.com> <1504705881.3829.19.camel@synopsys.com>
 <CAL_Jsq+B74keQ3N=8x6jx1URkLq8fa9gwsc5JAuiV86Wwczi9Q@mail.gmail.com> <1504714938.3829.40.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750933AbdIFTU0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 Sep 2017 15:20:26 -0400
In-Reply-To: <1504714938.3829.40.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Sep 6, 2017 at 11:22 AM, Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
> Hi Rob,
>
> On Wed, 2017-09-06 at 10:25 -0500, Rob Herring wrote:
>> On Wed, Sep 6, 2017 at 8:51 AM, Alexey Brodkin
>> <Alexey.Brodkin@synopsys.com> wrote:
>> >
>> > Hi Vineet, Rob,
>> >
>> > On Tue, 2017-09-05 at 16:40 -0700, Vineet Gupta wrote:
>> > >
>> > > On 09/05/2017 03:04 PM, Rob Herring wrote:
>> > > >
>> > > >
>> > > > On Tue, Sep 5, 2017 at 10:37 AM, Alexey Brodkin
>> > > > <Alexey.Brodkin@synopsys.com> wrote:
>
> [snip]
>
>> > Yeah, that's an interesting question. We may indeed move more smarts to the clock driver
>> > but:
>> >  1. We'll have duplicate code in different clock drivers. Even today that kind of clock
>> >     setup is applicable to AXS10x and HSDK platforms (and they use different clock drivers).
>>
>> No, you could provide a common, shared function to call. Then each
>> platform can opt-in. If you can make something that applies to every
>> single platform now or in the future, then I'd put it in arch. If you
>> have plans to decouple the timer and cpu clocks, then sounds like you
>> can't.
>
> Right so we'll implement a function which is called by a platform if required.
> That way we escape copy-pasting while keeping enough flexibility for current
> and future platforms.
>
>> IMO, if it's not part of the defined CPU architecture, then don't put
>> it in arch/. That's how we end up with multiple copies of the same
>> thing done arbitrarily different ways because few people look across
>> architectures.
>
> So do you propose to have the function [that reads "clock-frequency" from say
> CPU node and passes its value to CPU's parent clock driver] in generic
> [i.e. architecture agnostic] code somewhere in "init/main.c"?

No, just like you said above and have the platform's clock driver
initialize frequencies.

I haven't seen anyone else want such a thing as generally the
bootloader should initialize things to something reasonable.

>> >  2. Print out of CPU frequency which is used during boot process for us is important as well
>> >     especially during bring-up of new HW.
>> >
>> >  3. If there's no dedicated "clock-frequency" parameter in CPU node we won't
>> >     change anything so that non-affected platforms will live as they used to.
>> >
>> > That said IMHO proposed implementation is what we want to kep for now.
>> >
>> > >
>> > > Also note that this code is using a new / adhoc DT binding cpu-freq in cou node to
>> > > do the override - is that acceptable ?
>>
>> No, I meant to point that out.
>
> Sorry, but for me it's not clear what did you mean here.
> Care to elaborate a bit more?

I noticed the same thing and meant to highlight that in my first
reply. Use clock-frequency, don't invent something new.

>> > I think we'll switch to more common "clock-frequency" in the next respin.
>> > Indeed "cpu-freq" might be a bit misleading.
>>
>> Ideally, you'd use the clock binding eventually.
>
> Again I'm probably missing something :)

"clock-frequency" property and the clock bindings (i.e. clocks =
<&phandle>) are generally mutually exclusive at least within clock
consumer side. There's the assigned-clocks binding which provides the
ability to set both parent clocks and frequency.

> I meant we will have both clock phandle and "clock-frequency" at the same time.
> Something like this:
> -------------------------------->8---------------------------
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 cpu@0 {
>                         device_type = "cpu";
>                         compatible = "snps,archs38";
>                         reg = <0>;
>                         clocks = <&core_clk>;
>                         clock-frequency = <100000000>;  <-- That's where we want to set desired value
>                 };
>         ...
>         }
>
>         core_clk: core-clk@80 {
>                 compatible = "snps,axs10x-arc-pll-clock";
>                 reg = <0x80 0x10>, <0x100 0x10>;
>                 #clock-cells = <0>;
>                 clocks = <&input_clk>;
>         };
> -------------------------------->8---------------------------
>
> Or alternatively we may move "clock-frequency" right to the clock's node and have
> it like that:
> -------------------------------->8---------------------------
>         core_clk: core-clk@80 {
>                 compatible = "snps,axs10x-arc-pll-clock";
>                 reg = <0x80 0x10>, <0x100 0x10>;
>
> #clock-cells = <0>;
>                 clocks = <&input_clk>;
>                 clock-frequency = <100000000>;  <-- That's where we want to set desired value

I think this is how it should be done if you use clock-frequency prop.
This is inline with how fixed-clock binding is done.

Rob
