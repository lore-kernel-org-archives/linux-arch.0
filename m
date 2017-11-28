Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36781 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdK1DTe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 22:19:34 -0500
MIME-Version: 1.0
In-Reply-To: <20171127134232.q343uymer47zt74m@lakrids.cambridge.arm.com>
References: <cover.1511785528.git.green.hu@gmail.com> <20a04f4a5b08dcec221e0c511e42ff3df711ae66.1511785528.git.green.hu@gmail.com>
 <20171127134232.q343uymer47zt74m@lakrids.cambridge.arm.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 28 Nov 2017 11:18:52 +0800
Message-ID: <CAEbi=3cbuUUAxuQn5Q-02CGijKZD7kZtk15XoMD17+JE3Dib-g@mail.gmail.com>
Subject: Re: [PATCH v2 29/35] dt-bindings: nds32 CPU Bindings
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>, Rick Chen <rick@andestech.com>, Zong Li <zong@andestech.com>
Message-ID: <20171128031852.lR2Ulsl5JJE6MblY_szoS_2MXW1iOspQADqwN4XdMVM@z>

2017-11-27 21:42 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> Him
>
> On Mon, Nov 27, 2017 at 08:28:16PM +0800, Greentime Hu wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> This patch adds nds32 CPU binding documents.
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Rick Chen <rick@andestech.com>
>> Signed-off-by: Zong Li <zong@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>> ---
>>  Documentation/devicetree/bindings/nds32/cpus.txt |   32 ++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
>>
>> diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
>> new file mode 100644
>> index 0000000..c302c89
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nds32/cpus.txt
>> @@ -0,0 +1,32 @@
>> +* Andestech Processor Binding
>> +
>> +This binding specifies what properties must be available in the device tree
>> +representation of a Andestech Processor Core, which is the root node in the
>> +tree.
>> +
>> +Required properties:
>> +
>> +     - compatible:
>> +             Usage: required
>> +             Value type: <string>
>> +             Definition: should be one of:
>> +                     "andestech,n13"
>> +                     "andestech,n15"
>> +                     "andestech,d15"
>> +                     "andestech,n10"
>> +                     "andestech,d10"
>> +                     "andestech,nds32v3"
>
> Are these specific parts, or architecture versions?
>
> I guess "andestech,nds32v3" is an architecture version, and the rest are
> specific parts?

Yes, nds32v3 is an architecture version and the rest are nds32v3
compatible processor's name.

>> +     - device_type
>> +             Usage: required
>> +             Value type: <string>
>> +             Definition: must be "cpu"
>> +     - clock-frequency: Contains the clock frequency for CPU, in Hz.
>> +
>> +* Examples
>> +
>> +/ {
>> +     cpu {
>> +             device_type = "cpu";
>> +             compatible = "andestech,n13", "andestech,nds32v3";
>> +     };
>
> This is missing the required clock-frequency property.
>
> There should be a /cpus node, with each CPU listed under that, to align
> with the devicetree spec. Even if you never support SMP, there's no
> reason to be different from other architectures.
>
> You should have something like:
>
> / {
>         cpus {
>                 cpu {
>                         device_type = "cpu";
>                         compatible = "andestech,n13";
>                         clock-frequency = <...>;
>                 };
>         };
> };
>
> Thanks,
> Mark.

Thanks.
I will modify it in the next version patch.
