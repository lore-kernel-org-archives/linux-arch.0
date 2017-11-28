From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 30/35] net: faraday add nds32 support.
Date: Tue, 28 Nov 2017 10:55:23 +0800
Message-ID: <CAEbi=3ccsD9KAE8hUgJYATA0Dbg3P7xgR-wXy_bHw-3TeE-k=Q@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <1aa759dbbb1032dd20e5fadbb0ce5aa4b8b22690.1511785528.git.green.hu@gmail.com>
 <CAK8P3a2GJERt78uWgdDy+Azr-ZMcOcB+D6Akq99tSfwKmt2LiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a2GJERt78uWgdDy+Azr-ZMcOcB+D6Akq99tSfwKmt2LiA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

2017-11-27 22:15 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>
>> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>
> This is missing a patch description.
>

Thanks.
Sorry. I miss it. I will add the commit messages in the next version patch.

>> diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
>> index 040c7f1..0ae6e9a 100644
>> --- a/drivers/net/ethernet/faraday/Kconfig
>> +++ b/drivers/net/ethernet/faraday/Kconfig
>> @@ -5,7 +5,7 @@
>>  config NET_VENDOR_FARADAY
>>         bool "Faraday devices"
>>         default y
>> -       depends on ARM
>> +       depends on ARM || NDS32
>>         ---help---
>>           If you have a network (Ethernet) card belonging to this class, say Y.
>>
>
> We probably want to make all three here
>
> depends on ARM || NDS32 || COMPILE_TEST
>

Thanks.
I will modify it in the next version patch.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
