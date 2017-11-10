Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:43535 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdKJInw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Nov 2017 03:43:52 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1k_zNN6FTRNm5kfun8Nb+3ZLtmCLjHOVZUFB10TqQBFQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <1a8efba0727437d510d10755f3fcea806833651d.1510118606.git.green.hu@gmail.com>
 <CAL_JsqJAtTSGg=yGvANGdTCWa4tDAicvOvWYr4pK5M1rjPFtfg@mail.gmail.com>
 <CAEbi=3e-hRbej7EZ68-J1YPNfdxu7O_BAZ1rvZvAhhYzAT09-g@mail.gmail.com>
 <CABGGisw5gi92aM0_tZ0htOzwZTFJpcSNZUJth5TzRXPxzssRxA@mail.gmail.com>
 <CAEbi=3eus0ZEyFaNbS_a8bDOfH3aK_FB2ckATm-ELzPZT0MJ_Q@mail.gmail.com> <CAK8P3a1k_zNN6FTRNm5kfun8Nb+3ZLtmCLjHOVZUFB10TqQBFQ@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Fri, 10 Nov 2017 16:43:11 +0800
Message-ID: <CAEbi=3evxbZ-K--fkuZu_ANfiuoChT=AmRUfEyJ0htK3cy9wdQ@mail.gmail.com>
Subject: Re: [PATCH 30/31] dt-bindings: nds32 CPU Bindings
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>, Greentime <greentime@andestech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Message-ID: <20171110084311.Fddecw5ITNolB6JZhZDRMppbqW70Fr63qe4JoF1sQ3I@z>

>>> Then having both is not valid. The strings should be in order of best
>>> match to worst match where worst match is typically either older
>>> implementations of IP blocks or generic'ish strings such as "ns16550"
>>> for a UART.
>>
>> Thanks.
>> I would like to explain it more clearly.
>> They are independent ones in implementations.
>> They are implemented based on the same nds32 ISA and architecture spec
>> with different configurations
>> like cache size, page size, cache type(VIPT/PIPT), pipeline stages...
>> Most of them are compatible.
>> They use the same toolchain to build vmlinux which can run on
>> different nds32 cores.
>
> Du you have a name for the ISA spec that distinguishes it from other nds32
> versions that are incompatible? If you do, this could be written like
>
> compatible = "andestech,n13", "andestech,nds32v3.0";
>
> to signify that a an 'n13' core implements the 'v3.0' ISA (will it
> whatever you call the ISA in reality).
>

Thanks. I got you.
I will use a proper name(maybe 'nds32v3') of ISA in this compatible
string in the next version patch.
