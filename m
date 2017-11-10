From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 12/31] nds32: Device specific operations
Date: Fri, 10 Nov 2017 17:14:28 +0100
Message-ID: <CAK8P3a3u8JECzVqzfX4pGN3e_UHsZ_o+Q7PpHAoMuj6iR-7uKQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <4e9acf2ec55fb26ddb290ca2d955eeea628e0a77.1510118606.git.green.hu@gmail.com>
 <CAK8P3a04p+GUz3ex=t=CVy8ZcVFFZGwJaaPDoyT74bjieiKHVw@mail.gmail.com>
 <CAEbi=3eoTQ+operFB5Oq9VkAjG-Ehs=UQhOOELkeK2eSuuf0=g@mail.gmail.com> <CAEbi=3fCjkTSXLe+jP4UTe1W7570aN9LEpM9-v54p8xEW2YnAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:49089 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbdKJQOa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Nov 2017 11:14:30 -0500
In-Reply-To: <CAEbi=3fCjkTSXLe+jP4UTe1W7570aN9LEpM9-v54p8xEW2YnAA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, deanbo422@gmail.com

On Fri, Nov 10, 2017 at 5:07 PM, Greentime Hu <green.hu@gmail.com> wrote:
> 2017-11-09 15:04 GMT+08:00 Greentime Hu <green.hu@gmail.com>:
>> 2017-11-08 17:04 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>
>>>> +
>>>> +#define ioremap(cookie,size)           __ioremap(cookie,size,0,1)
>>>> +#define ioremap_nocache(cookie,size)   __ioremap(cookie,size,0,1)
>>>> +#define iounmap(cookie)                        __iounmap(cookie)
>>>
>>>> +#include <asm-generic/io.h>
>>>
>>> asm-generic/io.h now provides an ioremap_nocache() helper along with
>>> ioremap_uc/ioremap_wc/ioremap_wt, so I think you can remove the
>>> ioremap_nocache definition here. You might also be able to remove
>>> __ioremap and __iounmap, and only provide ioremap/iounmap, plus
>>> the identity macro 'define ioremap ioremap'
>>
>> Thanks. I will try to use generic ioremap_nocache() helper in the next
>> version patch.
>
> I think I can't remove ioremap_nocache definition because it is defined
> in asm-generic/io.h with !CONFIG_MMU.

Ah, I see.

Could you move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt
out of that #ifdef, or would that break other architectures?

      Arnd
