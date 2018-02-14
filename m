From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 31/37] MAINTAINERS: Add nds32
Date: Wed, 14 Feb 2018 13:54:53 +0800
Message-ID: <CAEbi=3cYCAoqrw0JTQkEdnBNSpZUxZA+ZUSmrQd70S+xSro6Yw@mail.gmail.com>
References: <cover.1518505384.git.greentime@andestech.com> <f7758221d49fd24fdff7c900aa5951a6c1c6a3cd.1518505384.git.greentime@andestech.com>
 <1518537768.22190.42.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518537768.22190.42.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

2018-02-14 0:02 GMT+08:00 Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>:
> On Tue, 2018-02-13 at 17:09 +0800, Greentime Hu wrote:
>> Add a maintainer information for the nds32(Andes) architecture.
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -868,6 +868,17 @@ X:       drivers/iio/*/adjd*
>>  F:   drivers/staging/iio/*/ad*
>>  F:   drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>>
>> +ANDES ARCHITECTURE
>> +M:   Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> +M:   Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> +T:   git https://github.com/andestech/linux.git
>> +S:   Supported
>> +F:   arch/nds32
>
> This should have a trailing /
>
> F:      arch/nds32/

Thank you Joe.
I will add this trailing /
>
>> +F:   Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
>> +F:   Documentation/devicetree/bindings/nds32

And here

>> +K:   nds32
>
> Perhaps this should be
>
> K:      \bnds32
>
> as there are some existing uses of nds32 in the current tree.
>
> or maybe case insensitive like
>
> K:      (?i:\bnds32)
> or
> K:      (?:\bnds32|\bNDS32)
>

I think it might be better to keep it "nds32" becaue some intrinsic
functions are defined with __nds32__xxx.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
