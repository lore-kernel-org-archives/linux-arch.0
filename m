Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759960AbdEOQkb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 May 2017 12:40:31 -0400
MIME-Version: 1.0
In-Reply-To: <CAOesGMh3UxHPYQ7SDG7+NODuT5TnP_i23ru0ZRR-rOYxbOGe_g@mail.gmail.com>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk> <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
 <CAOesGMgYDq5Sdk6OaK-mTyfdNGwcbgOVeKbeMSCOmwqd9k8TGQ@mail.gmail.com>
 <CAL_JsqJCjwvvta0n7dNpyVZkK5hp25fYO78q_pQZzUAPRDq+-w@mail.gmail.com> <CAOesGMh3UxHPYQ7SDG7+NODuT5TnP_i23ru0ZRR-rOYxbOGe_g@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 15 May 2017 11:40:09 -0500
Message-ID: <CAL_JsqL_nwRn-8L5bdcQ=0_HEiSRqF7yfonrq1GsYdcvtykRyQ@mail.gmail.com>
Subject: Re: [PATCH] devicetree: Move include prefixes from arch to separate directory
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Olof Johansson <olof@lixom.net>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frank Rowand <frowand.list@gmail.com>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20170515164009.bH8adyVKAuh28L3sWdODCFMtdp1BXhFzlbbUaGAsiWM@z>

On Mon, May 15, 2017 at 11:09 AM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, May 15, 2017 at 8:52 AM, Rob Herring <robh+dt@kernel.org> wrote:
>> On Mon, May 15, 2017 at 10:27 AM, Olof Johansson <olof@lixom.net> wrote:
>>> On Mon, May 15, 2017 at 7:47 AM, Rob Herring <robh+dt@kernel.org> wrote:
>>>> On Mon, May 15, 2017 at 9:26 AM, Russell King - ARM Linux
>>>> <linux@armlinux.org.uk> wrote:
>>>>> On Mon, May 15, 2017 at 08:01:07AM -0500, Rob Herring wrote:
>>>>>> I'd prefer not to mix things in scripts/dtc that aren't the import of
>>>>>> dtc (yes, we do have a few other things already, but they are at least
>>>>>> scripts). Couldn't this go in include/dt-bindings/ instead?

[...]

>>>> Another idea. Could kbuild create all the symlinks at build time instead?
>>>
>>> I considered that, but given that we're talking about a few soft links
>>> that we need to find a good home for, it seemed like overkill that
>>> adds magic to the build process. Having somehting that is easily
>>> discovered when looking around the source tree is a lot better.
>>>
>>> I looked around the tree for suitable homes for this directory of
>>> links, and the least out-of-place I could find was under scripts/dtc.
>>> You even have a script for uprevving the imported dtc sources, so it's
>>> not like it's causing any problems from that point of view. But I do
>>> agree that it's not ideal -- it was just the least bad option I could
>>> find at the time. Better suggestions are welcome.
>>
>> Fair enough. Like I said, it was only a preference and certainly not
>> unprecedented. I'll just get less receptive with each addition. :)
>
> I'm familiar with that feeling. :)
>
>> When and by whom do you propose merging this?
>
> Given that it crosses architectures but fixes my mistaken recursive
> linking I was planning on either including it in arm-soc fixes or for
> full visibility just send it as a patch to Linus. Mind giving me an
> ack?

Given what it fixes, arm-soc probably makes the most sense.

Acked-by: Rob Herring <robh@kernel.org>

> Or, if you prefer to merge it that's fine with me too. I'd like to fix
> the tree for people who are seeing the problems soon though.
>
>> The only other comment I would have is at some point, we're going to
>> have overlays that aren't tied to any arch. Where are we going to put
>> those? Maybe they are tied to some vendor which tends to have most
>> stuff in $arch and we just continue this band-aid. Or we define some
>> common location. I bring this up now only because both could use that
>> location.
>
> Those are good questions. What kind of common overlays are you
> anticipating? Things like fragments describing connectors, etc?

Daughterboards on connectors is one. Another somewhat different case
is non-probeable buses hanging off of probeable devices where the host
system may not even be DT based. For example, GPIOs, I2C, UART, etc.
devices behind a USB serial chip and standard USB connector.

> Rule so far has been that the first arch to introduce something keeps
> it (that's between arm/arm64): Mostly it's been arm64 referencing arm
> contents so far.
>
> I guess we could introduce the concept of a common/ directory
> somewhere. As you say, finding a good home for it isn't 100% obvious
> today, and we should make sure ownership of the directory is clear
> since we've seen things go badly when patches get merged through too
> many paths on these files.

Agreed. I'm happy for you to own that. ;)

Rob
