From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v6 31/36] dt-bindings: nds32 CPU Bindings
Date: Fri, 19 Jan 2018 23:35:30 +0800
Message-ID: <CAEbi=3fKp5tj32hoH=ZTo6kqpCE+Zv1LopnpVujusSfMkeaJKg@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <e9577ec0f6b6ca17077aa2f576c8bef191c3d7c2.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0HGhx3WpF-AwC+7m8+FoaiQBTYoCLqhECrATBRLX7x5g@mail.gmail.com>
 <CAEbi=3ef8JHf_Jpru1B2L3+Xz-Oz4p_t84Lh=5kuTFo0YEz=5A@mail.gmail.com>
 <CAK8P3a38hCHULZt=fGXJebcoiEGCwA0fre_kixA7sUpPP2xf5g@mail.gmail.com>
 <CAEbi=3eexCyrVhFZB8wmK1fT=QONzc63y6=dGNgj_H+Rt4zo_g@mail.gmail.com> <CAMuHMdX4nzU06ovDOwzJw-O8w0gyer-fi6skDae=K1yr-EN1gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33301 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755285AbeASPgM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jan 2018 10:36:12 -0500
In-Reply-To: <CAMuHMdX4nzU06ovDOwzJw-O8w0gyer-fi6skDae=K1yr-EN1gA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rd>

2018-01-19 23:29 GMT+08:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Greentime,
>
> On Fri, Jan 19, 2018 at 4:18 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2018-01-19 22:52 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Fri, Jan 19, 2018 at 3:32 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>>> 2018-01-18 19:02 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>>>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>>>> From: Greentime Hu <greentime@andestech.com>
>>>>>>
>>>>>> This patch adds nds32 CPU binding documents.
>>>>>>
>>>>>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>>>>>> Signed-off-by: Rick Chen <rick@andestech.com>
>>>>>> Signed-off-by: Zong Li <zong@andestech.com>
>>>>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/nds32/cpus.txt |   37 ++++++++++++++++++++++
>>>>>>  1 file changed, 37 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..9a52937
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/nds32/cpus.txt
>>>>>> @@ -0,0 +1,37 @@
>>>>>> +* Andestech Processor Binding
>>>>>> +
>>>>>> +This binding specifies what properties must be available in the device tree
>>>>>> +representation of a Andestech Processor Core, which is the root node in the
>>>>>> +tree.
>>>>>> +
>>>>>> +Required properties:
>>>>>> +
>>>>>> +       - compatible:
>>>>>> +               Usage: required
>>>>>> +               Value type: <string>
>>>>>> +               Definition: should be one of:
>>>>>> +                       "andestech,n13"
>>>>>> +                       "andestech,n15"
>>>>>> +                       "andestech,d15"
>>>>>> +                       "andestech,n10"
>>>>>> +                       "andestech,d10"
>>>>>> +                       "andestech,nds32v3"
>>>>>
>>>>> Based on https://lkml.org/lkml/2017/11/27/1290, this should say that
>>>>> the device tree should always list 'andestech,nds32v3' as the most
>>>>> generic 'compatible' value and list exactly one of the others in
>>>>> addition.
>>>
>>>> I will remove the others and just left "andestech,nds32v3" in here.
>>>
>>> No, is not what we want here, the CPU node should list exactly which core
>>> is used, what we need in the description is a clarification that
>>> andestech,nds32v3 must be used in addition to the more specific
>>> string.
>>
>> Hi, Arnd:
>>
>> Sorry I still don't get your point. Do you mean we should always use
>> compatible = "andestech,n13", "andestech,nds32v3";
>> instead of
>> compatible = "andestech,n13";
>
> Exactly. The first value is a device-specific compatible value, the second is
> a generic fallback.
>
>> And I need to add the description in this document.
>
> Indeed. See for example
> Documentation/devicetree/bindings/power/renesas,apmu.txt
>
> Thanks!

Hi, Geert:

Thank you and your example.
I get it. I will update this document like this.
- compatible: Should be "andestech,<core_name>", "andestech,nds32v3"
as fallback.
