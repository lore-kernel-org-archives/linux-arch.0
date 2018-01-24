From: Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 20/36] nds32: Signal handling support
Date: Wed, 24 Jan 2018 08:56:08 +0800
Message-ID: <CAJsyPhyGpJVQegd7ns9oZOjM=XsGVixCQaH9nT_jOQsSpyRs+g@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <e145c39b3c50b3aee05bc60ad0117f1ec7cc5153.1515766253.git.green.hu@gmail.com>
 <CAK8P3a2HR6be9Fm+o1Oq-V5p51xEiuhbyqkgVWprD5BxuU29xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a2HR6be9Fm+o1Oq-V5p51xEiuhbyqkgVWprD5BxuU29xQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Guo Ren <ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

2018-01-18 18:30 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>
>> This patch adds support for signal handling.
>>
>> Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>
> I never feel qualified enough to properly review signal handling code, so
> no Ack from me for this code even though I don't see anything wrong with it.
> Hopefully someone else can give an Ack after looking more closely.
>
>        Arnd

Dear Arnd:

We'd be glad to improve signal handling code to meet your requirement.
Could you
tell us which part we need to refine or which implementation is good
for us to refer?

Thanks.

Vincent
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
