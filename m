From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 29/35] dt-bindings: nds32 CPU Bindings
Date: Tue, 28 Nov 2017 11:18:52 +0800
Message-ID: <CAEbi=3cbuUUAxuQn5Q-02CGijKZD7kZtk15XoMD17+JE3Dib-g@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <20a04f4a5b08dcec221e0c511e42ff3df711ae66.1511785528.git.green.hu@gmail.com>
 <20171127134232.q343uymer47zt74m@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171127134232.q343uymer47zt74m-agMKViyK24J5pKCnmE3YQBJ8xKzm50AiAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Zong Li <zong-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

2017-11-27 21:42 GMT+08:00 Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>:
> Him
>
> On Mon, Nov 27, 2017 at 08:28:16PM +0800, Greentime Hu wrote:
>> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>
>> This patch adds nds32 CPU binding documents.
>>
>> Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>> Signed-off-by: Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>> Signed-off-by: Zong Li <zong-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
