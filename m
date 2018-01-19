From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 24/36] nds32: Loadable modules
Date: Fri, 19 Jan 2018 22:26:57 +0800
Message-ID: <CAEbi=3e8eUDsmX2DgixgM9P=oPu1b1-wvUDpiLGx4fbUPtCOuw@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <0a0789a3f776a5248ebc01706d502a3a9823cfac.1515766253.git.green.hu@gmail.com>
 <CAK8P3a3pQSxM+gJ+dJsyeo5YnuOOyFYVoJdCVmnoHR0Numya5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a3pQSxM+gJ+dJsyeo5YnuOOyFYVoJdCVmnoHR0Numya5g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Guo Ren <ren_guo-Y+KPrCd2zL4@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

2018-01-18 18:41 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>
>> This patch adds support for loadable modules.
>
> One detail:
>
> You still seem to have both the ELF_REL and ELF_RELA based functions
> implemented here, you should drop the unused ELF_REL version:
>
>> diff --git a/arch/nds32/kernel/module.c b/arch/nds32/kernel/module.c
>> new file mode 100644
>> index 0000000..714a6d6
>> --- /dev/null
>> +++ b/arch/nds32/kernel/module.c
>> @@ -0,0 +1,286 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2005-2017 Andes Technology Corporation
>> +
>> +#include <linux/module.h>
>> +#include <linux/elf.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include <asm/pgtable.h>
>
> include <linux/moduleloader.h> to catch this.
>
>> +int
>> +apply_relocate(Elf32_Shdr * sechdrs, const char *strtab,
>> +              unsigned int symindex, unsigned int relsec,
>> +              struct module *module)
>> +{
>> +       return 0;
>> +}
>
> and drop this.
>
> With that change,
>
> Acked-by:  Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

Hi, Arnd:

Thank you. I will include moduleloader.h and drop apply_relocate().
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
