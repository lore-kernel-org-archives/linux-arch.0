Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36475 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934656AbdEOP15 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2017 11:27:57 -0400
Received: by mail-ua0-f194.google.com with SMTP id i46so10267798uaa.3
        for <linux-arch@vger.kernel.org>; Mon, 15 May 2017 08:27:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk> <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
From: Olof Johansson <olof@lixom.net>
Date: Mon, 15 May 2017 08:27:54 -0700
Message-ID: <CAOesGMgYDq5Sdk6OaK-mTyfdNGwcbgOVeKbeMSCOmwqd9k8TGQ@mail.gmail.com>
Subject: Re: [PATCH] devicetree: Move include prefixes from arch to separate directory
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frank Rowand <frowand.list@gmail.com>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20170515152754.7nUWbDAy92FYIt4c2NmYY9NAtQClmARmF7MS200b1zQ@z>

On Mon, May 15, 2017 at 7:47 AM, Rob Herring <robh+dt@kernel.org> wrote:
> On Mon, May 15, 2017 at 9:26 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Mon, May 15, 2017 at 08:01:07AM -0500, Rob Herring wrote:
>>> I'd prefer not to mix things in scripts/dtc that aren't the import of
>>> dtc (yes, we do have a few other things already, but they are at least
>>> scripts). Couldn't this go in include/dt-bindings/ instead?
>>
>> I don't think that works.
>>
>> The include path used is "include", which means that we force people
>> to use:
>>
>> #include <dt-bindings/foo.dtsi>
>
> No, I was thinking you'd add include/dt-bindings/include-prefix/ to
> the include path instead of scripts/dtc/include-prefix/. The only
> downside I can see is people could mistakenly do:
>
> #include <dt-bindings/include-prefix/$arch/foo.dtsi>

I considered that but thought it was a worse solution than the one I
ended up with. It's just confusing to have -I paths that enter an
include hierarchy at different levels like that.

Just see what already happened with the mistake on rockchip, where
Heiko accidentally included <include/dt-include/...> instead -- it'd
be nice to catch that when it happens through tools

>>
>> in their DT files.  This means that we'd need to populate $topdir/include
>> with per-architecture symlinks on top of the 26 or so directories already
>> there, so that:
>>
>> #include <arch/foo.dtsi>
>>
>> would work.  That's quite horrible, since $topdir/include is the main
>> include path for C headers.
>>
>> I guess we could have symlinks inside include/dt-bindings, but that
>> makes the includes:
>>
>> #include <dt-bindings/arch/foo.dtsi>
>>
>> but that's rather absurd because these _aren't_ dt-binding definitions.
>
> True, but the same can be said that "scripts/dtc" is not includes nor
> kernel build infrastructure.
>
>> Maybe what we should do is:
>>
>> mkdir include/dt
>> git mv include/dt-bindings include/dt
>> for arch in arch/*; do
>>   dts=$arch/boot/dts
>>   if [ -d $dts ]; then
>>      a=include/dt/$(basename $arch)
>>      ln -s $dts $a
>>      git add $a
>>   fi
>> done
>> ... fixup scripts/Makefile.lib ...
>> git commit
>
> That would just break every existing include in dts files.

It doesn't break dts includes if done together with a change in -I,
but it might break includes from the driver side (or needs another -I
there).

>
> Another idea. Could kbuild create all the symlinks at build time instead?

I considered that, but given that we're talking about a few soft links
that we need to find a good home for, it seemed like overkill that
adds magic to the build process. Having somehting that is easily
discovered when looking around the source tree is a lot better.

I looked around the tree for suitable homes for this directory of
links, and the least out-of-place I could find was under scripts/dtc.
You even have a script for uprevving the imported dtc sources, so it's
not like it's causing any problems from that point of view. But I do
agree that it's not ideal -- it was just the least bad option I could
find at the time. Better suggestions are welcome.

-Olof
