From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 29/31] MAINTAINERS: Add nds32
Date: Thu, 9 Nov 2017 11:36:32 +0100
Message-ID: <CAK8P3a0=KNN_GdA=PQfaTU1O2Un1K45FYZZScDZN42mqhEzRHQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <16035efb78f70411998755693339471032743377.1510118606.git.green.hu@gmail.com>
 <CAL_JsqLe847Dhta2vkbaUqRdfaQnsPCncR2bZZNP-_kzvm25wg@mail.gmail.com> <CAEbi=3eSpeOCwpd=6_hcLx1wsWfAjQAPV-hdZ0R-gsznnnVziw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:55237 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdKIKgd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Nov 2017 05:36:33 -0500
In-Reply-To: <CAEbi=3eSpeOCwpd=6_hcLx1wsWfAjQAPV-hdZ0R-gsznnnVziw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Greentime <greentime@andestech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>

On Thu, Nov 9, 2017 at 10:46 AM, Greentime Hu <green.hu@gmail.com> wrote:
> 2017-11-08 21:31 GMT+08:00 Rob Herring <robh+dt@kernel.org>:
>> On Tue, Nov 7, 2017 at 11:55 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>> From: Greentime Hu <greentime@andestech.com>
>>>
>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>> ---
>>>  MAINTAINERS |    9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 2f4e462..bce1181 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -857,6 +857,15 @@ X: drivers/iio/*/adjd*
>>>  F:     drivers/staging/iio/*/ad*
>>>  F:     drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>>>
>>> +ANDES ARCHITECTURE
>>> +M:     Greentime Hu <green.hu@gmail.com>
>>> +M:     Vincent Chen <deanbo422@gmail.com>
>>> +T:     git https://github.com/andestech/linux.git
>>> +S:     Supported
>>> +F:     arch/nds32
>>
>> DT binding files?
>
> Thanks.
> I should add
> F:    Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
> F:    Documentation/devicetree/bindings/nds32/cpus.txt
>
> I will fix it in the next version patch.

Better make the second one the directory, in case you add more files
there later.

I would also add a "K: nds32" line to catch all files that have this
in their names.

       Arnd
