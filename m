From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 30/31] dt-bindings: nds32 CPU Bindings
Date: Fri, 10 Nov 2017 09:25:19 +0100
Message-ID: <CAK8P3a1k_zNN6FTRNm5kfun8Nb+3ZLtmCLjHOVZUFB10TqQBFQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <1a8efba0727437d510d10755f3fcea806833651d.1510118606.git.green.hu@gmail.com>
 <CAL_JsqJAtTSGg=yGvANGdTCWa4tDAicvOvWYr4pK5M1rjPFtfg@mail.gmail.com>
 <CAEbi=3e-hRbej7EZ68-J1YPNfdxu7O_BAZ1rvZvAhhYzAT09-g@mail.gmail.com>
 <CABGGisw5gi92aM0_tZ0htOzwZTFJpcSNZUJth5TzRXPxzssRxA@mail.gmail.com> <CAEbi=3eus0ZEyFaNbS_a8bDOfH3aK_FB2ckATm-ELzPZT0MJ_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45519 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdKJIZV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Nov 2017 03:25:21 -0500
In-Reply-To: <CAEbi=3eus0ZEyFaNbS_a8bDOfH3aK_FB2ckATm-ELzPZT0MJ_Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>, Greentime <greentime@andestech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Nov 10, 2017 at 7:22 AM, Greentime Hu <green.hu@gmail.com> wrote:
> 2017-11-09 21:57 GMT+08:00 Rob Herring <robh@kernel.org>:
>> On Thu, Nov 9, 2017 at 3:39 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>> 2017-11-08 21:18 GMT+08:00 Rob Herring <robh+dt@kernel.org>:
>>>> Please Cc the DT list on bindings.
>>>
>>> Sorry. I am not sure what you mean.
>>> Do you mean add devicetree@vger.kernel.org to cc list?
>>
>> Yes. Use get_maintainers.pl as a guide.
>
> Roger that! Thanks!
>
>>>> On Tue, Nov 7, 2017 at 11:55 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>>>> From: Greentime Hu <greentime@andestech.com>
>>>>
>>
>>>>> +                       device_type = "cpu";
>>>>> +                       compatible = "andestech,n13", "andestech,n15";
>>>>
>>>> n13 is a superset of n15?
>>>
>>> No, they are independent ones.
>>
>> Then having both is not valid. The strings should be in order of best
>> match to worst match where worst match is typically either older
>> implementations of IP blocks or generic'ish strings such as "ns16550"
>> for a UART.
>
> Thanks.
> I would like to explain it more clearly.
> They are independent ones in implementations.
> They are implemented based on the same nds32 ISA and architecture spec
> with different configurations
> like cache size, page size, cache type(VIPT/PIPT), pipeline stages...
> Most of them are compatible.
> They use the same toolchain to build vmlinux which can run on
> different nds32 cores.

Du you have a name for the ISA spec that distinguishes it from other nds32
versions that are incompatible? If you do, this could be written like

compatible = "andestech,n13", "andestech,nds32v3.0";

to signify that a an 'n13' core implements the 'v3.0' ISA (will it
whatever you call the ISA in reality).

       Arnd
