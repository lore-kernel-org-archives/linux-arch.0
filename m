From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 31/36] dt-bindings: nds32 CPU Bindings
Date: Fri, 19 Jan 2018 23:18:30 +0800
Message-ID: <CAEbi=3eexCyrVhFZB8wmK1fT=QONzc63y6=dGNgj_H+Rt4zo_g@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <e9577ec0f6b6ca17077aa2f576c8bef191c3d7c2.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0HGhx3WpF-AwC+7m8+FoaiQBTYoCLqhECrATBRLX7x5g@mail.gmail.com>
 <CAEbi=3ef8JHf_Jpru1B2L3+Xz-Oz4p_t84Lh=5kuTFo0YEz=5A@mail.gmail.com> <CAK8P3a38hCHULZt=fGXJebcoiEGCwA0fre_kixA7sUpPP2xf5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a38hCHULZt=fGXJebcoiEGCwA0fre_kixA7sUpPP2xf5g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Guo Ren <ren_guo-Y+KPrCd2zL4@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

2018-01-19 22:52 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
> On Fri, Jan 19, 2018 at 3:32 PM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> 2018-01-18 19:02 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
>>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>>>
>>>> This patch adds nds32 CPU binding documents.
>>>>
>>>> Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>>> Signed-off-by: Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>>> Signed-off-by: Zong Li <zong-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>>> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>>> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/nds32/cpus.txt |   37 ++++++++++++++++++++++
>>>>  1 file changed, 37 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
>>>> new file mode 100644
>>>> index 0000000..9a52937
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/nds32/cpus.txt
>>>> @@ -0,0 +1,37 @@
>>>> +* Andestech Processor Binding
>>>> +
>>>> +This binding specifies what properties must be available in the device tree
>>>> +representation of a Andestech Processor Core, which is the root node in the
>>>> +tree.
>>>> +
>>>> +Required properties:
>>>> +
>>>> +       - compatible:
>>>> +               Usage: required
>>>> +               Value type: <string>
>>>> +               Definition: should be one of:
>>>> +                       "andestech,n13"
>>>> +                       "andestech,n15"
>>>> +                       "andestech,d15"
>>>> +                       "andestech,n10"
>>>> +                       "andestech,d10"
>>>> +                       "andestech,nds32v3"
>>>
>>> Based on https://lkml.org/lkml/2017/11/27/1290, this should say that
>>> the device tree should always list 'andestech,nds32v3' as the most
>>> generic 'compatible' value and list exactly one of the others in
>>> addition.
>
>> I will remove the others and just left "andestech,nds32v3" in here.
>
> No, is not what we want here, the CPU node should list exactly which core
> is used, what we need in the description is a clarification that
> andestech,nds32v3 must be used in addition to the more specific
> string.

Hi, Arnd:

Sorry I still don't get your point. Do you mean we should always use
compatible = "andestech,n13", "andestech,nds32v3";
instead of
compatible = "andestech,n13";

And I need to add the description in this document.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
