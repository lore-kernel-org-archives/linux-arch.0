From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 34/35] clocksource/drivers/Kconfig: Support andestech
 atcpit100 timer
Date: Tue, 28 Nov 2017 10:53:37 +0800
Message-ID: <CAEbi=3f6YZJySA5A2+y1hiPHwfkq+05cisnRwyhKYDXQdnFzWA@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <1a22db002413ff60851737736a86b40c38877220.1511785528.git.green.hu@gmail.com>
 <CAK8P3a2ovDuwWCq2HABZaCVGO04TX0VdgnQbK65RvHhsMEzsiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a2ovDuwWCq2HABZaCVGO04TX0VdgnQbK65RvHhsMEzsiw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rick Chen <rickchen36-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

2017-11-27 22:11 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: Rick Chen <rickchen36-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Add CLKSRC_ATCPIT100 for Andestech atcpit100 timer selection.
>> It often be used in Andestech AE3XX platform.
>>
>> Signed-off-by: Rick Chen <rickchen36-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> No need to split out the Makefile patch from the actual driver, they
> clearly belong together.
> The binding change should be a separate patch, as you did.
>
> It's probably best to separate the driver patches from the
> architecture submission
> in the future, they can simply get merged by the respective subsystem
> maintainers,
> with a smaller Cc list.
>

Hi, Arnd:

Thanks.
We will merge these 2 patches together in the next version patch.
We will sent to clocksource subsystem with a seperate patchset.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
