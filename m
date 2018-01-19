Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:44092 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755020AbeASO1i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jan 2018 09:27:38 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3pQSxM+gJ+dJsyeo5YnuOOyFYVoJdCVmnoHR0Numya5g@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <0a0789a3f776a5248ebc01706d502a3a9823cfac.1515766253.git.green.hu@gmail.com>
 <CAK8P3a3pQSxM+gJ+dJsyeo5YnuOOyFYVoJdCVmnoHR0Numya5g@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Fri, 19 Jan 2018 22:26:57 +0800
Message-ID: <CAEbi=3e8eUDsmX2DgixgM9P=oPu1b1-wvUDpiLGx4fbUPtCOuw@mail.gmail.com>
Subject: Re: [PATCH v6 24/36] nds32: Loadable modules
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180119142657.oq_Mc7LnKjE5V2vNpaiP-zCE-ANUKM8VDDMheFrhWYs@z>

2018-01-18 18:41 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
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
> Acked-by:  Arnd Bergmann <arnd@arndb.de>

Hi, Arnd:

Thank you. I will include moduleloader.h and drop apply_relocate().
